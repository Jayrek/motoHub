import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

import '../data/model/location_model.dart';

class LocationService {
  loc.Location location = loc.Location();

  Stream<LocationModel> get locationStream => _streamController.stream;

  late Stream<LocationModel> _myLocation;

  Stream<LocationModel> get myLocation => _myLocation;

  final StreamController<LocationModel> _streamController =
      StreamController<LocationModel>.broadcast();

  LocationService() {
    String address = '';
    location.requestPermission().then((granted) {
      location.onLocationChanged.listen((locationData) {
        getAddressFromLatLng(locationData.latitude!.toDouble(),
                locationData.longitude!.toDouble())
            .then((value) => address = value);
        _streamController.add(LocationModel(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
            addressName: address));
        debugPrint('LATT: ${locationData.latitude}');
        debugPrint('LONG: ${locationData.longitude}');
        debugPrint('ADDRESssS: $address');
      });
    });
  }

  Future<String> getAddressFromLatLng(double lat, double long) async {
    try {
      final List<Placemark> addressName =
          await placemarkFromCoordinates(lat, long);
      if (addressName[0].street!.toLowerCase().contains('unnamed')) {
        return '${addressName[1].street}, ${addressName[1].locality}';
      } else {
        return '${addressName[0].street}, ${addressName[0].locality}';
      }
    } catch (e) {
      debugPrint('addressName $e');
      return '';
    }
  }
}
