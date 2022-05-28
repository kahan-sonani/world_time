import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class TimezoneData with ChangeNotifier {
  Map? locations;
  DateTime? localTime;
  List<Placemark>? address;

  Future<List<Placemark>?> getLocation() async {
    return _determineAddress();
  }

  Future<void> updateLocation() async {
    List<Placemark>? address = await getLocation();
    print(address);
    setPosition(address!);
  }

  Future<List<Placemark>?> _determineAddress() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Position? pos = await Geolocator.getLastKnownPosition();
      return placemarkFromCoordinates(pos!.latitude, pos.longitude);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return placemarkFromCoordinates(position.latitude, position.longitude);
  }

  void setPosition(List<Placemark> address) {
    this.address = address;
    notifyListeners();
  }

  TimezoneData() {
    tz.initializeTimeZones();
    locations = tz.timeZoneDatabase.locations;
    localTime = DateTime.now();
  }

  String calculateArea() {
    return "${address?[0].street}, ${address?[0].subLocality}, ${address?[0].locality}, ${address?[0].postalCode}";
  }

  String calculateState() {
    return "${address?[0].administrativeArea}, ${address?[0].country}";
  }

  String calculateAddress() {
    return "${address?[0].street}, ${address?[0].subLocality}, ${address?[0].locality}, ${address?[0].thoroughfare}, ${address?[0].administrativeArea}, ${address?[0].country}, ${address?[0].postalCode}";
  }
}
