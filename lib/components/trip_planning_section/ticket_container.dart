// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketContainer extends StatelessWidget {
  final Function(int) onDeleted;
  final Function(String?) updateNotes;
  final String DepartLocation;
  final String topText;
  final String fromDate;
  final String fromTime;
  final String ArrivalLocation;
  final String bottomText;
  final String toDate;
  final String toTime;
  final String transitCarrier;
  final String price;
  final String operaterHeading;
  final int index;
  String? note;

  TicketContainer({
    super.key,
    required this.DepartLocation,
    required this.topText,
    required this.fromDate,
    required this.fromTime,
    required this.ArrivalLocation,
    required this.bottomText,
    required this.toDate,
    required this.toTime,
    required this.transitCarrier,
    required this.price,
    required this.operaterHeading,
    required this.onDeleted,
    required this.updateNotes,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 0.95 * screenWidth,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEPART',
                  ),
                  Container(
                    width: 0.5 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DepartLocation,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Text(
                    topText,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE',
                  ),
                  Container(
                    width: 0.17 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        fromDate,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TIME',
                  ),
                  Container(
                    width: 0.22 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(DateFormat('hh:mm a')
                          .format(DateFormat('HH:mm').parse(fromTime))),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ARRIVE',
                  ),
                  Container(
                    width: 0.5 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ArrivalLocation,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Text(
                    bottomText,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE',
                  ),
                  Container(
                    width: 0.17 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        toDate,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TIME',
                  ),
                  Container(
                    width: 0.22 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(DateFormat('hh:mm a')
                          .format(DateFormat('HH:mm').parse(toTime))),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    operaterHeading,
                  ),
                  Container(
                    width: 0.58 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        transitCarrier,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COST',
                  ),
                  Container(
                    width: 0.3 * screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        price,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 0.25,
            color: Colors.white,
          ),
          Container(
            width: 0.9 * screenWidth,
            height: 80,
            alignment: Alignment.center,
            child: TextField(
              onChanged: (newNote) {
                note = newNote;
                updateNotes(note);
              },
              decoration: InputDecoration(
                hintText: 'Notes',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  onDeleted(index);
                },
                child: Text(
                  'Delete',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
