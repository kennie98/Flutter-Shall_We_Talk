import 'package:shall_we_talk/services/database.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final String uid;
  LocationService({this.uid});

  Future<void> updateCurrentLocation() async {
    Position currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    await DatabaseService(uid: uid).updateUserLocation(
        currentLocation.latitude, currentLocation.longitude);
  }

  Future<Position> getCurrentLocation() async {
    Position currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    return currentLocation;
  }
}