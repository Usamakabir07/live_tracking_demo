import 'dart:async';
import 'dart:developer';
import 'package:live_tracking_demo/infrastructure/team/model/coordinates.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'global_functions.dart';
import 'navigation_service.dart';

class WebSocketService {
  WebSocketService(this.socket);
  final io.Socket socket;

  final StreamController<Coordinates> _controller =
      StreamController<Coordinates>.broadcast();

  Stream<Coordinates> get coordinatesStream => _controller.stream;

  void connectToTheSocket() {
    socket.connect();
    socket.on('connect', (_) {
      log('Connected to the server');
    });
  }

  void sendCoordinates(Coordinates coordinates) {
    String sendingCoordinates = coordinatesToJson(coordinates);
    socket.emit('locationUpdate', {
      'room': 'vehicle123',
      'location': sendingCoordinates,
    });
    log('sending data: $sendingCoordinates');
  }

  void joinVehicleTrackingRoom({required String vehicleId}) {
    socket.emit('joinRoom', vehicleId);
    receiveVehicleCoordinates();
    log(vehicleId);
  }

  Coordinates receiveVehicleCoordinates() {
    Coordinates coordinates = Coordinates(
      latitude: 25.07017488492422,
      longitude: 55.1370683013168,
    );
    try {
      socket.on('locationUpdate', (data) {
        log('receiving coordinates: $data');
        coordinates = Coordinates.fromJson(data);
        _controller.add(coordinates);
      });
    } catch (e) {
      showToast(
        message: "Something went wrong! $e",
        context: NavigationService.navigatorKey.currentContext!,
      );
    }
    return coordinates;
  }

  void disConnectSocket() {
    socket.disconnect();
    _controller.close();
    socket.on('disconnect', (_) {
      log('Disconnected from the server');
    });
  }
}
