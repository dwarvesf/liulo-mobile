import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:liulo/repositories/location_repository.dart';

class FlutterLocationRepository implements LocationRepository {

  Geolocator geolocator = Geolocator();

  @override
  Future<Position> getCurrentPosition(LocationAccuracy desiredAccuracy) async {
    return await geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy);
  }

  @override
  Stream<Position> getPositionStream(LocationOptions options) {
    return geolocator.getPositionStream(options);
  }

}
