import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class AutocompleteExample extends StatefulWidget {
  @override
  _AutocompleteExampleState createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  final PlaceAutocomplete placeAutocomplete = PlaceAutocomplete(
    apiKey:
        '<YOUR_MAPBOX_API_KEY>',
  );

  List<String> suggestions = [];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Autocomplete Example'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) async {
              suggestions = await placeAutocomplete.getSuggestions(value);
              setState(() {});
            },
            decoration: InputDecoration(
              labelText: 'Search places...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    // Handle selection
                    print('Selected: ${suggestions[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
