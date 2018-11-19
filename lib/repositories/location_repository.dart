import 'dart:async';

import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getCurrentPosition(LocationAccuracy desiredAccuracy);

  /// only work on foreground
  Stream<Position> getPositionStream(LocationOptions options);
}
