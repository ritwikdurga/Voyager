import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MarkingMap extends StatefulWidget {
  @override
  _MarkingMapState createState() => _MarkingMapState();
}

class _MarkingMapState extends State<MarkingMap> {
  final String mapboxPublicToken = '<KEY>'; // Your Mapbox access token here

  List<LatLng> coordinates = [
    LatLng(-33.852, 10.211), // Coordinates for marker 1
    LatLng(-33.850, 100.215), // Coordinates for marker 2
    LatLng(-33.855, 150.210), // Coordinates for marker 3
    // Add more coordinates as needed
  ];

  late MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MapboxMap(
          onMapCreated: _onMapCreated,
          accessToken: mapboxPublicToken,
          initialCameraPosition: CameraPosition(
            target: coordinates[0], // Center the map on the first coordinate
            zoom: 2.0,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _addMarkers();
  }

  Future<void> _addMarkers() async {
    var markerImage = await loadMarkerImage();

    mapController.addImage('marker', markerImage);

    for (var coordinate in coordinates) {
      await mapController.addSymbol(
        SymbolOptions(
          iconSize: 0.3,
          iconImage: "marker",
          geometry: coordinate,
          iconAnchor: "bottom",
        ),
      );
    }
  }

  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/a.png");
    return byteData.buffer.asUint8List();
  }
}
