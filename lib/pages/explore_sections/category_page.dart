// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyager/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryPage extends StatelessWidget {
  late String heading;
  late String category_id;
  CategoryPage({super.key, required this.heading, required this.category_id});
  String apiKey = dotenv.env['KEY']!;

  Future<List<Map<String, dynamic>>> getInfoAboutCategory() async {
    String endpoint =
        'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=-122.41%2C39&bbox=-124.35526789303981%2C38.41262975705166%2C-120.52250410696067%2C39.54169087094499';

    try {
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Map<String, dynamic>> places = [];
        for (var feature in data['features']) {
          var place = {
            'name': feature['properties']['name'],
            'address': feature['properties']['full_address'],
            'phone': feature['properties']['metadata']['phone'] ?? 'N/A',
            'website': feature['properties']['metadata']['website'] ?? 'N/A',
            'latitude': feature['properties']['coordinates']['latitude'],
            'longitude': feature['properties']['coordinates']['longitude'],
          };
          places.add(place);
        }
        return places;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          heading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getInfoAboutCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>>? places = snapshot.data;
            if (places != null && places.isNotEmpty) {
              return ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  var place = places[index];
                  var name = place['name'];
                  var address = place['address'];
                  var phone = place['phone'];
                  var website = place['website'];
                  var latitude = place['latitude'];
                  var longitude = place['longitude'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                              
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange[400],
                                    fontFamily: 'ProductSans',
                                    fontSize: 20,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(address,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: 'ProductSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                            ),
                            Row(
                              children: [
                                Text('Phone: ',
                                    style: TextStyle(
                                      color: themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'ProductSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                ),
                                Text(phone,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: 'ProductSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ), 
                                ),
                              ],
                            ),
                            GestureDetector(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text('Website: ',
                                          style: TextStyle(
                                            color: themeProvider.themeMode == ThemeMode.dark
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'ProductSans',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      ),
                                      Text(website,
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontFamily: 'ProductSans',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(website);
                                  launchUrl(uri);
                                }),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Iconsax.map),
                          onPressed: () async {
                            final availableMaps = await MapLauncher.installedMaps;
                            print(availableMaps);
                      
                            if (availableMaps.isNotEmpty) {
                              try {
                                await availableMaps.first.showMarker(
                                  coords: Coords(latitude, longitude),
                                  title: name,
                                );
                              } catch (e) {
                                print('Error showing marker: $e');
                              }
                            } else {
                              print('No maps available');
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          }
        },
      ),
    );
  }
}
