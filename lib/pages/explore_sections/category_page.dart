// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyager/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

_callNumber(String number) async {
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

class CategoryPage extends StatelessWidget {
  String place;
  late String heading;
  late String category_id;
  CategoryPage(
      {super.key,
      required this.place,
      required this.heading,
      required this.category_id});
  String apiKey = dotenv.env['KEY']!;

  Future<List<Map<String, dynamic>>> getInfoAboutCategory(String city) async {
    String? endpoint;
    switch (city) {
      case 'Manali':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=77.1887%2C32.2396&bbox=77.0933%2C32.2202%2C77.2922%2C32.2610';
        break;
      case 'Delhi':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=77.2090%2C28.6139&bbox=77.1003%2C28.4045%2C77.3475%2C28.8835';
        break;
      case 'Goa':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=74.1240%2C15.2993&bbox=73.6266%2C14.4324%2C74.6475%2C15.9907';
        break;
      case 'Hyderabad':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=78.4867%2C17.3850&bbox=78.3072%2C17.2172%2C78.5854%2C17.5399';
        break;
      case 'Chennai':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=80.2707%2C13.0827&bbox=80.1642%2C12.9611%2C80.3272%2C13.1335';
        break;
      case 'Jaipur':
        endpoint =
            'https://api.mapbox.com/search/searchbox/v1/category/$category_id?access_token=$apiKey&language=en&limit=25&proximity=75.7873%2C26.9124&bbox=75.7482%2C26.8426%2C75.8450%2C26.9821';
        break;
      default:
        break;
    }
    try {
      var response = await http.get(Uri.parse(endpoint as String));
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
        future: getInfoAboutCategory(place),
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
                              Text(
                                name,
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
                            Text(
                              address,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'ProductSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Phone: ',
                                  style: TextStyle(
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'ProductSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    phone,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: 'ProductSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () => _callNumber(phone),
                                ),
                              ],
                            ),
                            GestureDetector(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Website: ',
                                        style: TextStyle(
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'ProductSans',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        website,
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
                            final availableMaps =
                                await MapLauncher.installedMaps;
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
