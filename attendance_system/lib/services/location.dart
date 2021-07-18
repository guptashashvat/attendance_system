import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../utilities/constants.dart';

String apiKey = 'AIzaSyAsoOPaY1ChpxpkReSTq8H2aJci3KRZRp4';

class Location {
  Future<String> getCurrentLocation({Position position}) async {
    try {
      if (position == null) {
        position = await determineCurrentPosition();
      }
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      return "${addresses.first.addressLine}";
    } catch (e) {
      return '${position.latitude}  ${position.longitude}';
    }
  }

  double getDistanceFromBranchLocation({@required Position position}) {
    return Geolocator.distanceBetween(
        position.latitude, position.longitude, branchLatitude, branchLongitude);
  }

  Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
