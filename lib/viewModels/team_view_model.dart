import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_tracking_demo/utils/global_functions.dart';
import 'package:live_tracking_demo/utils/navigation_service.dart';
import '../infrastructure/catalog_facade_service.dart';
import '../infrastructure/team/model/coordinates.dart';
import '../utils/web_socket_service.dart';

class TeamViewModel extends ChangeNotifier {
  TeamViewModel({
    required this.catalogFacadeService,
    required this.webSocketService,
  });

  final CatalogFacadeService catalogFacadeService;
  final WebSocketService webSocketService;

  Polyline _polyline = const Polyline(polylineId: PolylineId("route"));
  Polyline get polyline => _polyline;

  Marker _marker = const Marker(markerId: MarkerId('currentLocation'));
  Marker get marker => _marker;

  final Coordinates currentCoordinates = Coordinates(
    latitude: 25.07017488492422,
    longitude: 55.1370683013168,
  );

  final List<LatLng> _polylineCoordinates = [];
  List<LatLng> get polylineCoordinates => _polylineCoordinates;

  void updateMarkerAndPolyline(
      Coordinates coordinates, GoogleMapController googleMapController) {
    final position = LatLng(coordinates.latitude, coordinates.longitude);
    _polylineCoordinates.add(position);
    _marker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: position,
    );
    googleMapController.animateCamera(CameraUpdate.newLatLng(position));
    _polyline = Polyline(
      polylineId: const PolylineId('route'),
      points: _polylineCoordinates,
      color: Colors.blue,
      width: 5,
    );
  }

  void establishWebSocketConnection() {
    try {
      webSocketService.connectToTheSocket();
    } catch (e) {
      showToast(
        message: "Something went wrong! $e",
        context: NavigationService.navigatorKey.currentContext!,
      );
    }
  }

  void joinVehicleTrackingRoom({required String vehicleId}) {
    try {
      webSocketService.joinVehicleTrackingRoom(vehicleId: vehicleId);
    } catch (e) {
      showToast(
        message: "Something went wrong! $e",
        context: NavigationService.navigatorKey.currentContext!,
      );
    }
  }
}
