import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MarkingMap extends StatefulWidget {
  final List<Map<String, double>> coordinatesList;
  MarkingMap({required this.coordinatesList});
  @override
  State<MarkingMap> createState() => _MarkingMapState();
}

class _MarkingMapState extends State<MarkingMap> {
  final String mapboxPublicToken = dotenv.env['KEY']!; // Your Mapbox access token here

  late List<LatLng> coordinates;

  @override
  void initState() {
    super.initState();
    coordinates = convertToLatLng(widget.coordinatesList);
    print(coordinates.toList());
    print(widget.coordinatesList.toList());
  }

  List<LatLng> convertToLatLng(List<Map<String, double>> coordinatesList) {
    return coordinatesList.map((coordinate) {
      return LatLng(coordinate['latitude']!, coordinate['longitude']!);
    }).toList();
  }

  late MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: MapboxMap(
          onMapCreated: _onMapCreated,
          accessToken: mapboxPublicToken,
          initialCameraPosition: CameraPosition(
            target: coordinates.isNotEmpty ? coordinates[0] : LatLng(0, 0),
            zoom: 8.0,
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
    if (mapController != null) {
      mapController!.addImage(
          'marker', markerImage); // Check if mapController is not null

      for (var coordinate in coordinates) {
        mapController!.addSymbol(
          SymbolOptions(
            iconSize: 0.3,
            iconImage: "marker",
            geometry: coordinate,
            iconAnchor: "bottom",
          ),
        );
      }
    } else {
      print('Map controller is null');
    }
    mapController.addImage('marker', markerImage);
    print(coordinates.toList());

    for (var coordinate in coordinates) {
      await mapController.addSymbol(
        SymbolOptions(
          iconSize: 0.3,
          iconImage: 'marker',
          geometry: coordinate,
          iconAnchor: 'bottom',
        ),
      );
      print(coordinate);
    }
  }

  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load('assets/images/location-pin.png');
    return byteData.buffer.asUint8List();
  }
}