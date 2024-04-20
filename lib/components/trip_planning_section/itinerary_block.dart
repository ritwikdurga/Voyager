// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_local_variable, unused_field, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:voyager/services/data_comparator.dart';
import 'package:voyager/utils/constants.dart';
import 'package:http/http.dart' as http;

class BlockIti extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String tripId;

  const BlockIti(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.tripId});

  @override
  State<BlockIti> createState() => _BlockItiState();
}

class _BlockItiState extends State<BlockIti>
    with AutomaticKeepAliveClientMixin {
  List<BlockData> blockDataList = [];
  late Stream<DocumentSnapshot> _dataStream;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _dataStream = FirebaseFirestore.instance
        .collection('trips')
        .doc(widget.tripId)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateBlocDataInFirebase() async {
    try {
      await FirebaseFirestore.instance
          .collection('trips')
          .doc(widget.tripId)
          .update({
        'blockData': blockDataList.map((data) => data.toMap()).toList()
      });
      print('Block data updated successfully!');
    } catch (e) {
      print('Error updating block data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<DocumentSnapshot>(
      stream: _dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (!snapshot.hasData) {
          return const Text("No data available");
        }
        var data = snapshot.data;
        List<BlockData> blockDataListNew = [];
        try {
          if (data?['blockData'] != null) {
            blockDataListNew = List<BlockData>.from(data?['blockData'].map(
                (item) => BlockData(
                    date: DateTime.parse(item['date']),
                    locations: item['locations'])));
          } else {
            throw Exception('blockData is null or not available');
          }
        } catch (e) {
          print(e);
          for (var i = 0;
              i <= widget.endDate.difference(widget.startDate).inDays;
              i++) {
            blockDataListNew.add(BlockData(
                date: widget.startDate.add(Duration(days: i)), locations: []));
          }
        }
        print(blockDataListNew[0].locations.length);
        if (!areBlockDataListsEqual(blockDataListNew, blockDataList)) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              blockDataList.clear();
              blockDataList.addAll(blockDataListNew);
              print(blockDataListNew[0].locations.length);
              print(blockDataList[0].locations.length);
            });
          });
        }
        final themeProvider = Provider.of<ThemeProvider>(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (int i = 0; i < blockDataList.length; i++)
                  Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      extentRatio: 0.42,
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            _onDeleteBlock(blockDataList[i]);
                          },
                          label: 'Delete',
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                    child: BlockWidget(
                      startDate: widget.startDate,
                      endDate: widget.endDate,
                      blockDataList: blockDataList,
                      callbackUpdateFunc: updateBlocDataInFirebase,
                      indx: i,
                      loc: widget.location,
                      onDelete: () {
                        setState(() {
                          blockDataList.remove(blockDataList[i]);
                          updateBlocDataInFirebase();
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDeleteBlock(BlockData blockData) {
    setState(() {
      blockDataList.remove(blockData);
      updateBlocDataInFirebase();
    });
  }
}

class BlockData {
  final DateTime date;
  List<dynamic> locations;
  BlockData({required this.date, required this.locations});

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'locations': locations,
    };
  }

  factory BlockData.fromMap(Map<String, dynamic> map) {
    return BlockData(
      date: DateTime.parse(map['date']),
      locations: List<String>.from(map['locations']),
    );
  }
}

class BlockWidget extends StatefulWidget {
  final void Function() callbackUpdateFunc;
  final List<BlockData> blockDataList;
  final int indx;
  late BlockData blockData;
  final VoidCallback onDelete;
  final DateTime startDate;
  final DateTime endDate;
  final String loc;
  BlockWidget({
    required this.callbackUpdateFunc,
    required this.blockDataList,
    required this.indx,
    required this.onDelete,
    required this.startDate,
    required this.endDate,
    required this.loc,
    super.key,
  });
  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Map<String, Map<String, dynamic>> _locationInfoDataMap = {};
  late TextEditingController _locationController;
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  String apiKey = dotenv.env['KEY']!;

  Future<Map<String, dynamic>> fetchLocationData(String loc) async {
    if (_locationInfoDataMap.containsKey(loc)) {
      // If data for the location is already present, return it directly
      return _locationInfoDataMap[loc]!;
    } else {
      try {
        // Fetch data from Firestore instead of making a request to Google Generative AI
        // You need to replace this logic with your Firestore data fetching logic
        final firestoreData = await FirebaseFirestore.instance
            .collection('locations')
            .doc(loc)
            .get();
        if (firestoreData.exists) {
          // If data exists in Firestore, add it to the cache and return
          final data = firestoreData.data()!;
          _locationInfoDataMap[loc] = data;
          return data;
        } else {
          // If data doesn't exist in Firestore, fetch it from Google Generative AI
          final model = GenerativeModel(
            model: 'gemini-pro',
            apiKey: 'AIzaSyAdTLdQjPK_GFd-8agz8XYeJ6A79lZBL1Y',
          );
          final content = [
            Content.text(
                'Provide the "rating", "description", and "timings" of $loc, ${widget.loc} in HH MM format as a string in JSON map format')
          ];
          final response = await model.generateContent(content);
          final responseText = response.text!;
          final trimmedResponse = responseText.substring(
              responseText.indexOf('{'), responseText.lastIndexOf('}') + 1);
          final jsonResponseMap = json.decode(trimmedResponse);
          _locationInfoDataMap[loc] = jsonResponseMap;
          return jsonResponseMap;
        }
      } catch (e) {
        print('Error fetching location data: $e');
        rethrow;
      }
    }
  }

  Future<String> getAddress(String longitude, String latitude) async {
    String endpoint =
        'https://api.mapbox.com/search/geocode/v6/reverse?access_token=$apiKey&longitude=$longitude&latitude=$latitude';
    try {
      //var response = await http.get(Uri.parse(endpoint));
      // if (response.statusCode == 200) {
      //   var data = json.decode(response.body);
      //   print(data['features'][0]['properties']['full_address']);
      //   String address = data['features'][0]['properties']['full_address'];
      //   //print('hi123342');
      //   return address;
      // } else {
      //   throw Exception('Failed to load suggestions');
      // }
      return '';
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    widget.blockData = widget.blockDataList[widget.indx];
    _locationController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // getAddress();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _removeLocation(String location) {
    setState(() {
      widget.blockData.locations.remove(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (widget.blockDataList.isNotEmpty) {
      widget.blockData = widget.blockDataList[widget.indx];
    }
    //widget.callbackUpdateFunc();
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: Duration(milliseconds: 750), // Adjust duration as needed
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
                if (_expanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade400,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  DateFormat('dd MMM yyyy')
                      .format(widget.blockData.date)
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.righteous().fontFamily,
                  ),
                ),
              ),
            ),
          ),
          if (_expanded) ...[
            for (var location in widget.blockData.locations) ...[
              buildLocationInfoWidget(themeProvider, location),
            ],
            SizedBox(height: 10.0),
            buildAddLocationWidget(widget.callbackUpdateFunc),
          ],
        ],
      ),
    );
  }

  Widget buildLocationInfoWidget(ThemeProvider themeProvider, String loc) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchLocationData(loc),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (_locationInfoDataMap.containsKey(loc)) {
            var existingData = _locationInfoDataMap[loc]!;
            existingData.addAll(data);
          } else {
            _locationInfoDataMap[loc] = data;
          }
          return _buildLocationInfoWidgetWithData(themeProvider, loc, data);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLocationInfoWidgetWithData(
      ThemeProvider themeProvider, String location, Map<String, dynamic> data) {
    var description = data['description'];
    var rating = data['rating'];
    var timings = data['timings'];

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kGreenColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 10.0),
              Text(
                location,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.deepOrange[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeLocation(location),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.blueAccent),
              SizedBox(width: 10.0),
              Text(
                timings ?? "N/A",
                style: TextStyle(
                  fontSize: 14.0,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade400
                      : Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.star, color: Colors.blueAccent),
              SizedBox(width: 10.0),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: 14.0,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade400
                      : Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                Ionicons.logo_google,
                size: 15,
                color: Colors.green,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            description ?? "N/A",
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'ProductSans',
              fontWeight: FontWeight.bold,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.grey.shade400
                  : Colors.grey[700],
            ),
          ),
          SizedBox(height: 10.0),
          buildAddressWidget(themeProvider),
          SizedBox(height: 10.0),
          buildDirectionWidgets(),
        ],
      ),
    );
  }

  Widget buildAddressWidget(ThemeProvider themeProvider) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.blueAccent),
        SizedBox(width: 10.0),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<String>(
              future: getAddress('-73.989', '40.733'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  var addressData = snapshot.data!;
                  return Text(
                    addressData,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.grey.shade400
                          : Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDirectionWidgets() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text(
              'View on Map',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.deepOrange[500],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: TextButton(
            onPressed: () async {
              final availableMaps = await MapLauncher.installedMaps;
              print(availableMaps);

              if (availableMaps.isNotEmpty) {
                try {
                  await availableMaps.first.showMarker(
                    coords: Coords(37.759392, -122.510733),
                    title: 'Title',
                  );
                } catch (e) {
                  print('Error showing marker: $e');
                }
              } else {
                print('No maps available');
              }
            },
            child: Text(
              'Get Directions',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.deepOrange[500],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddLocationWidget(Function callbackFunc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Add a location',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_locationController.text.isNotEmpty) {
                setState(() {
                  widget.blockData.locations.add(_locationController.text);
                  callbackFunc();
                  _locationController.clear();
                });
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kRedColor,
                    content: Center(
                      child: Text(
                        'Please enter a location',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProductSans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
