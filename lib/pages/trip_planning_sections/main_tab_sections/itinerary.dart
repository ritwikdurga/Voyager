// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:voyager/utils/constants.dart';
import '../../../components/trip_planning_section/horizontal_calendar.dart';
import '../../../components/trip_planning_section/itinerary_block.dart';

class ItineraryTrips extends StatefulWidget {
  final startDate;
  final endDate;
  final location;
  final tripId;
  const ItineraryTrips(
      {super.key,
      this.startDate,
      this.endDate,
      required this.location,
      required this.tripId});

  @override
  State<ItineraryTrips> createState() => _ItineraryTripsState();
}

class _ItineraryTripsState extends State<ItineraryTrips>
    with AutomaticKeepAliveClientMixin {
  late BlockIti _blockIti;

  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    _blockIti = BlockIti(
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
      location: widget.location,
      tripId: widget.tripId,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                color: kGreenColor,
                size: 18.0,
              ),
              Text(
                'Autofill Itinerary',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'ProductSans',
                  color: kGreenColor,
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
