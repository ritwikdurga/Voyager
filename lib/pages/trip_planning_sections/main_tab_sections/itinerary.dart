// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:voyager/utils/constants.dart';
import '../../../components/trip_planning_section/horizontal_calendar.dart';
import '../../../components/trip_planning_section/itinerary_block.dart';
import 'package:http/http.dart' as http;

class ItineraryTrips extends StatefulWidget {
  final startDate;
  final endDate;
  final location;
  final tripId;
  String? budget;
  String? tripMateKind;
  List<String>? tripPreferences;
  bool? isManual;

  ItineraryTrips(
      {super.key,
      this.startDate,
      this.endDate,
      this.budget,
      this.tripMateKind,
      this.isManual,
      this.tripPreferences,
      required this.location,
      required this.tripId});

  @override
  State<ItineraryTrips> createState() => _ItineraryTripsState();
}

class _ItineraryTripsState extends State<ItineraryTrips>
    with AutomaticKeepAliveClientMixin {
  BlockIti? _blockIti;

  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late List<String> locationsToVisit;

  @override
  bool get wantKeepAlive => true;

  Future<List<String>> getPOIforLoc() async {
    String param1 = widget.location.toString().toLowerCase();

    var params = {
      'param1': param1,
    };
    var url = Uri.parse('http://$using:8000/getallloc');

    var response = await http.get(url.replace(queryParameters: params));

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody);
      List<String> locations = [];
      responseBody.forEach((index, location) {
        locations.add(location.toString());
      });
      return locations;
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future<void> _initializeState() async {
    final locations = await getPOIforLoc();
    setState(() {
      locationsToVisit = locations;
      _blockIti = BlockIti(
        budget: widget.budget,
        tripMateKind: widget.tripMateKind,
        tripPreferences: widget.tripPreferences,
        isManual: widget.isManual ?? false,
        suggestions: locationsToVisit,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        location: widget.location,
        tripId: widget.tripId,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    _initializeState();
  }

  @override
  Widget build(BuildContext context) {
    if (_blockIti == null) {
      return CircularProgressIndicator();
    } else {
      super.build(context);
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: CustomStartEndCal(
                      selectedStartDate: _selectedStartDate,
                      selectedEndDate: _selectedEndDate,
                      onDateRangeSelected: (startDate, endDate) {
                        setState(() {
                          _selectedStartDate = DateTime(
                              startDate!.year, startDate.month, startDate.day);
                          _selectedEndDate = DateTime(
                              endDate!.year, endDate.month, endDate.day);
                          _updateBlockItis();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  extentRatio: 0.42,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        deleteTask(context, 0);
                      },
                      label: 'Delete',
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
                child: _blockIti!,
              ),
            ),
          ],
        ),
      );
    }
  } // Function to update the list of BlockIti widgets

  void _updateBlockItis() {
    setState(() {
      _blockIti = BlockIti(
        tripMateKind: widget.tripMateKind,
        tripPreferences: widget.tripPreferences,
        budget: widget.budget,
        isManual: widget.isManual ?? false,
        suggestions: locationsToVisit,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        location: widget.location,
        tripId: widget.tripId,
      );
    });
  }

  // Function to delete a block
  void deleteTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content:
              Text('Are you sure you want to delete this itinerary block?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Handle deletion here
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
