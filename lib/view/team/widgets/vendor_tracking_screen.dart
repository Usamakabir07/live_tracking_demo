import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_tracking_demo/viewModels/team_view_model.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/team/model/coordinates.dart';

class VendorTrackingScreen extends StatefulWidget {
  static const String routeName = '/vendor-tracking';
  const VendorTrackingScreen({super.key});

  @override
  State<VendorTrackingScreen> createState() => _VendorTrackingScreenState();
}

class _VendorTrackingScreenState extends State<VendorTrackingScreen> {
  GoogleMapController? googleMapController;

  setMapController() async {
    googleMapController = await Completer<GoogleMapController>().future;
  }

  @override
  void initState() {
    setMapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TeamViewModel>(
          builder: (context, viewModel, _) {
            return StreamBuilder<Coordinates>(
              stream: viewModel.webSocketService.coordinatesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final coordinates = snapshot.data!;
                  viewModel.updateMarkerAndPolyline(
                      coordinates, googleMapController!);
                }
                return GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(viewModel.currentCoordinates.latitude,
                        viewModel.currentCoordinates.longitude),
                    zoom: 15,
                  ),
                  markers: viewModel.marker != null
                      ? {viewModel.marker}
                      : Set<Marker>(),
                  polylines: viewModel.polyline != null
                      ? {viewModel.polyline}
                      : Set<Polyline>(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }
}
