import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class NormalMapPage extends StatefulWidget {
  @override
  _NormalMapPageState createState() => _NormalMapPageState();
}

class _NormalMapPageState extends State<NormalMapPage> with TickerProviderStateMixin{
  MapboxMapController? mapController;
  List<SymbolOptions> symbols = [];
  LatLng center = LatLng(37.7749, -122.4194); // Default center
  String selectedPlace = ""; // User-selected category
  final PlaceAutocomplete placeAutocomplete = PlaceAutocomplete(
    apiKey: '<YOUR_MAPBOX_API_KEY>',
  );

  List<String> suggestions = [];
  TextEditingController _searchController = TextEditingController();
  bool showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combined Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) async {
                suggestions = await placeAutocomplete.getSuggestions(value);
                setState(() {
                  showSuggestions = true;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search places...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (showSuggestions)
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]),
                    onTap: () {
                      _handleSelection(suggestions[index]);
                    },
                  );
                },
              ),
            ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (showSuggestions) {
                  setState(() {
                    showSuggestions = false;
                  });
                }
              },
              child: MapboxMap(
                accessToken: '<YOUR_MAPBOX_API_KEY>',
                initialCameraPosition:
                    CameraPosition(target: center, zoom: 11.0),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSelection(String query) async {
    String apiKey = '<YOUR_MAPBOX_API_KEY>';
    String endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$apiKey';

    try {
      var response = await http.get(Uri.parse(endpoint));
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
        print('Failed to load search results');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        showSuggestions = false;
      });
    }
  }

}

class PlaceAutocomplete {
  final String apiKey;

  PlaceAutocomplete({required this.apiKey});

  Future<List<String>> getSuggestions(String query) async {
    String endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$apiKey';

    try {
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<String> suggestions = [];
        for (var feature in data['features']) {
          suggestions.add(feature['place_name']);
        }
        return suggestions;
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
