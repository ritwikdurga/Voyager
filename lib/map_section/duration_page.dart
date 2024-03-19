import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Directions extends StatefulWidget {
  @override
  _DirectionsState createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  List<String> _originSuggestions = [];
  List<String> _destinationSuggestions = [];
  bool _showOriginSuggestions = false;
  bool _showDestinationSuggestions = false;
  Map<String, dynamic>? _responseDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directions'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _originController,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                labelText: 'Origin',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          if (_showOriginSuggestions)
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _originSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_originSuggestions[index]),
                    onTap: () {
                      _originController.text = _originSuggestions[index];
                      _showOriginSuggestions = false;
                      _getPlaceDetails(_originController.text, isOrigin: true);
                    },
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _destinationController,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          if (_showDestinationSuggestions)
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _destinationSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_destinationSuggestions[index]),
                    onTap: () {
                      _destinationController.text = _destinationSuggestions[index];
                      _showDestinationSuggestions = false;
                      _getPlaceDetails(_destinationController.text, isOrigin: false);
                    },
                  );
                },
              ),
            ),
          ElevatedButton(
            onPressed: _fetchTravelTimes,
            child: Text('Fetch Travel Times'),
          ),
        ],
      ),
    );
  }

  Future<void> _searchPlaces(String value) async {
    if (value.isNotEmpty) {
      String apiKey = '<YOUR_API_KEY>';
      String endpoint = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$value.json?access_token=$apiKey';
      try {
        var response = await http.get(Uri.parse(endpoint));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<dynamic> features = data['features'];
          if (_originController.text == value) {
            _originSuggestions.clear();
            for (var feature in features) {
              _originSuggestions.add(feature['place_name']);
            }
            setState(() {
              _showOriginSuggestions = true;
            });
          } else if (_destinationController.text == value) {
            _destinationSuggestions.clear();
            for (var feature in features) {
              _destinationSuggestions.add(feature['place_name']);
            }
            setState(() {
              _showDestinationSuggestions = true;
            });
          }
        }
      } catch (e) {
        print('Error searching places: $e');
      }
    } else {
      setState(() {
        _showOriginSuggestions = false;
        _showDestinationSuggestions = false;
      });
    }
  }

  Future<void> _getPlaceDetails(String query, {required bool isOrigin}) async {
    String apiKey = '<YOUR_API_KEY>';
    String endpoint = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$apiKey';

    try {
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _responseDetails = data;
        });
      } else {
        print('Failed to load place details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchTravelTimes() async {
    String apiKey = '<YOUR_API_KEY>';
    String profile = 'mapbox/driving';

    // Fetching coordinates for origin
    String originEndpoint = 'https://api.mapbox.com/geocoding/v5/mapbox.places/${_originController.text}.json?access_token=$apiKey';
    var originResponse = await http.get(Uri.parse(originEndpoint));
    var originData = json.decode(originResponse.body);
    var originFeatures = originData['features'];
    var originCoordinates = originFeatures[0]['geometry']['coordinates'];

    // Fetching coordinates for destination
    String destinationEndpoint = 'https://api.mapbox.com/geocoding/v5/mapbox.places/${_destinationController.text}.json?access_token=$apiKey';
    var destinationResponse = await http.get(Uri.parse(destinationEndpoint));
    var destinationData = json.decode(destinationResponse.body);
    var destinationFeatures = destinationData['features'];
    var destinationCoordinates = destinationFeatures[0]['geometry']['coordinates'];

    String coordinates = '${originCoordinates[0]},${originCoordinates[1]};${destinationCoordinates[0]},${destinationCoordinates[1]}';
    String endpoint = 'https://api.mapbox.com/directions-matrix/v1/$profile/$coordinates?access_token=$apiKey';

    try {
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Travel Times'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Origin: ${_originController.text}'),
                    Text('Destination: ${_destinationController.text}'),
                    Text('Travel Time: ${data['durations'][0][1]} seconds'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to fetch travel times');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

