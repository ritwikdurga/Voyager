// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';
import 'package:http/http.dart' as http;

class BlockIti extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const BlockIti({Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  _BlockItiState createState() => _BlockItiState();
}

class _BlockItiState extends State<BlockIti>
    with AutomaticKeepAliveClientMixin {
  List<BlockData> blockDataList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // clear the blockDataList
    blockDataList.clear();
    for (var i = 0;
        i <= widget.endDate.difference(widget.startDate).inDays;
        i++) {
      blockDataList
          .add(BlockData(date: widget.startDate.add(Duration(days: i))));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (var blockData in blockDataList)
              Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  extentRatio: 0.42,
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        _onDeleteBlock(blockData);
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
                  blockData: blockData,
                  onDelete: () {
                    setState(() {
                      blockDataList.remove(blockData);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onDeleteBlock(BlockData blockData) {
    setState(() {
      int index =
          blockDataList.indexWhere((element) => element.date == blockData.date);
      if (index != -1) {
        blockDataList.removeAt(index);
        blockData.locations.clear();
      }
    });
  }
}

class BlockData {
  final DateTime date;
  List<String> locations = [];

  BlockData({required this.date});
}

class BlockWidget extends StatefulWidget {
  final BlockData blockData;
  final VoidCallback onDelete;
  final DateTime startDate;
  final DateTime endDate;

  const BlockWidget({
    required this.blockData,
    required this.onDelete,
    required this.startDate,
    required this.endDate,
    Key? key,
  }) : super(key: key);

  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late TextEditingController _locationController;
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  String apiKey = dotenv.env['KEY']!;

  Future<String> getAddress(String longitude, String latitude) async {
    String endpoint =
        'https://api.mapbox.com/search/geocode/v6/reverse?access_token=$apiKey&longitude=$longitude&latitude=$latitude';
    try {
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data['features'][0]['properties']['full_address']);
        String address = data['features'][0]['properties']['full_address'];
        print('hi123342');
        return address;
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              Container(
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
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae libero tincidunt aliquam. Donec nec odio vitae libero tincidunt aliquam.',
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
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Text(
                          '9:00 AM - 5:00 PM',
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
                          '4.5/5',
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
                          // add google color
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child: FutureBuilder<String>(
                              future: getAddress('-73.989',
                                  '40.733'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); 
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  var addressData = snapshot.data!;
                                  return Text(
                                    addressData,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
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
                    ),
                    SizedBox(height: 10.0),
                    Row(
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
                              final availableMaps =
                                  await MapLauncher.installedMaps;
                              print(availableMaps);

                              if (availableMaps.isNotEmpty) {
                                try {
                                  await availableMaps.first.showMarker(
                                    coords: Coords(37.759392,
                                        -122.510733), // to be changed
                                    title: 'Title', // to be changed
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
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 10.0),
            Padding(
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
                      //getAddress();
                      if (_locationController.text.isNotEmpty)
                        setState(() {
                          widget.blockData.locations
                              .add(_locationController.text);
                          _locationController.clear();
                        });
                      else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kRedColor,
                            // Change the background color of the snackbar
                            content: Center(
                              child: Text(
                                'Please enter a location',
                                style: TextStyle(
                                  fontSize:
                                      16, // Change the font size as needed
                                  fontFamily: 'ProductSans',
                                  color: Colors
                                      .white, // Change the font family as needed
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
            ),
          ],
        ],
      ),
    );
  }
}
