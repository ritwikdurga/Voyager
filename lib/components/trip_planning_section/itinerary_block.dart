// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class BlockIti extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const BlockIti({Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  _BlockItiState createState() => _BlockItiState();
}

class _BlockItiState extends State<BlockIti> {
  List<BlockData> blockDataList = [];

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

class _BlockWidgetState extends State<BlockWidget> {
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
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
    return Container(
      key: UniqueKey(),
      child: ExpansionTile(
        title: Center(
          child: Text(DateFormat('dd MMM yyyy').format(widget.blockData.date),
              style: TextStyle(
                  fontSize: 18.0,
                  color:themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.grey.shade800,
                  fontWeight: FontWeight.bold)),
        ),
        children: [
          for (var location in widget.blockData.locations)
            ExpansionTile(
              title: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(location),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeLocation(location),
              ),
              children: [
                // location description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                      'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae libero tincidunt aliquam. Donec nec odio vitae libero tincidunt aliquam.'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // location timings
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('9:00 AM - 5:00 PM'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // location  review
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.star),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('4.5/5'),
                      // google icon
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Ionicons.logo_google,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // location address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '123, Lorem Ipsum, Dolor Sit Amet, Consectetur Adipiscing Elit.',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                // location address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.link),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'www.example.com',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // location contact
                SizedBox(
                  height: 10.0,
                ),
                // location address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '+91 1234567890',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // map and directions button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      // two text buttons
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Get Directions'),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('View on Map'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    setState(() {
                      widget.blockData.locations.add(_locationController.text);
                      _locationController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          // ElevatedButton(
          //   onPressed: widget.onDelete,
          //   child: Text('Delete Block'),
          // ),
        ],
      ),
    );
  }
}
