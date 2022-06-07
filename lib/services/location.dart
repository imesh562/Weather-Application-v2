import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  // This method is used to get the location of the user.
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } catch (exception) {
      // ignore: avoid_print
      print(exception);
    }
  }
}
