import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class SearchExample extends StatefulWidget {
  @override
  _SearchExampleState createState() => _SearchExampleState();
}

class _SearchExampleState extends State<SearchExample> {
  MapboxMapController? mapController;
  List<SymbolOptions> symbols = [];
  LatLng center = LatLng(37.7749, -122.4194);
  String selectedCategory = "";

  Future<void> performSearch(String place) async {
    String apiKey =
        '<Your Mapbox API Key>';
    String url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$place.json?access_token=$apiKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> features = data['features'];

      symbols.clear();

      features.forEach((feature) {
        LatLng coordinates = LatLng(feature['geometry']['coordinates'][1],
            feature['geometry']['coordinates'][0]);
        String name = feature['place_name'];

        symbols.add(
          SymbolOptions(
            geometry: coordinates,
            iconImage: 'attraction-15',
            textField: name,
            textOffset: Offset(0, 2),
          ),
        );
      });

      setState(() {});
      if (features.isNotEmpty) {
        mapController
            ?.animateCamera(CameraUpdate.newLatLng(symbols[0].geometry!));
      }
    } else {
      print('Failed to load place search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter a place',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                selectedCategory = value;
              },
              onSubmitted: (value) {
                performSearch(value);
              },
            ),
          ),
          Expanded(
            child: MapboxMap(
              accessToken:
                  '<Your Mapbox API Key>',
              initialCameraPosition: CameraPosition(target: center, zoom: 11.0),
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
