// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../components/trip_planning_section/horizontal_calendar.dart';
import '../../../components/trip_planning_section/itinerary_block.dart';

class ItineraryTrips extends StatefulWidget {
  final startDate;
  final endDate;

  const ItineraryTrips({Key? key, this.startDate, this.endDate})
      : super(key: key); // Corrected the syntax for the constructor

  @override
  State<ItineraryTrips> createState() => _ItineraryTripsState();
}

class _ItineraryTripsState extends State<ItineraryTrips>
    with AutomaticKeepAliveClientMixin {
  late BlockIti _blockIti; // Declare _blockIti variable without initialization

  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize _blockIti, _selectedStartDate, and _selectedEndDate in initState
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    _blockIti = BlockIti(
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        _selectedEndDate =
                            DateTime(endDate!.year, endDate.month, endDate.day);
                        _updateBlockItis();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // add an add icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_fix_normal,
                color: Colors.blueAccent,
                size: 18.0,
              ),
              Text('Autofill Itinerary',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ProductSans',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ],
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
              child: _blockIti,
            ),
          ),
        ],
      ),
    );
  }

  // Function to update the list of BlockIti widgets
  void _updateBlockItis() {
    setState(() {
      _blockIti = BlockIti(
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
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
