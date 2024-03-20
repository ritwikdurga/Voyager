// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:voyager/map_section/normal__map_page.dart';

import '../../../utils/constants.dart';

class LocationInput extends StatefulWidget {
  final Function(String)? onLocationSelected;
  String? initialLocation;
  LocationInput({super.key, this.onLocationSelected, this.initialLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput>
    with AutomaticKeepAliveClientMixin {
  final PlaceAutocomplete placeAutocomplete = PlaceAutocomplete(
    apiKey:
        dotenv.env['KEY']!,
  );

  @override
  bool get wantKeepAlive => true;

  List<String> suggestions = [];
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        if (widget.initialLocation != null) {
          _searchController.text = widget.initialLocation!;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<List<String>> getSuggestions(String query) async {
    String apiKey =
        dotenv.env['KEY']!;
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Text(
          'Where do you want to go?',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[800],
            ),
            child: TextField(
              focusNode: _searchFocusNode,
              controller: _searchController,
              onChanged: (value) async {
                suggestions = await placeAutocomplete.getSuggestions(value);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search places...',
                prefixIcon: Icon(Iconsax.location),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions[index]),
                onTap: () {
                  _searchController.text = suggestions[index];
                  _searchFocusNode.unfocus();
                  if (widget.onLocationSelected != null) {
                    widget.onLocationSelected!(suggestions[index]);
                  }
                  suggestions.clear();
                  setState(() {});
                  //print('Selected: ${suggestions[index]}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
