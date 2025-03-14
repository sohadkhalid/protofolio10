import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_/service/location_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = "The site was not Enable";

  //  creat obj from LocationService
  final LocationService _locationService = LocationService();

  //  request permission
  Future<void> _requestPermission() async {
    bool granted = await _locationService.requestLocationPermission();
    setState(() {
      _locationMessage =
          granted ? "The site is permitted" : "permission denied ";
    });
  }

  //  Get the current location
  Future<void> _fetchLocation() async {
    Position? position = await _locationService.getCurrentLocation();
    setState(() {
      if (position != null) {
        _locationMessage =
            "The current location:\nLatitude: ${position.latitude}, Longitude: ${position.longitude}";
      } else {
        _locationMessage = "The site could not be found";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location settings ")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermission,
              child: Text("Location Enable"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchLocation,
              child: Text("Get the current location"),
            ),
          ],
        ),
      ),
    );
  }
}
