// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart'; // Import Bounceable package
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:intl/intl.dart';
import 'package:voyager/pages/trip_planning_sections/continue_planning.dart';

class trips extends StatefulWidget {
  late Trip? trip;
  trips({super.key, required this.screenWidth, this.trip});
  final double screenWidth;

  @override
  State<trips> createState() => _tripsState();
}

class _tripsState extends State<trips> with SingleTickerProviderStateMixin {
  bool isBookmarked = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final dateFormat = DateFormat('d MMM');
    final startDateFormatted =
        dateFormat.format(widget.trip?.startDate ?? DateTime.now());
    final endDateFormatted =
        dateFormat.format(widget.trip?.endDate ?? DateTime.now());

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: shape,
      color: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      surfaceTintColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      elevation: 0,
      child: Bounceable(
        // Wrap InkWell with Bounceable
        onTap: () {
          print(
            widget.trip?.tripId ?? "NaN",
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContinuePlanning(
                tripId: widget.trip?.tripId ?? "NaN",
              ),
            ),
          );
        },
        child: SizedBox(
          height: widget.screenWidth / 3 + 20,
          width: widget.screenWidth - 10,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/a.png',
                fit: BoxFit.cover,
                height: widget.screenWidth / 3 + 20,
                width: widget.screenWidth - 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$startDateFormatted - $endDateFormatted',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (isBookmarked) {
                              _controller.reverse();
                              isBookmarked = false;
                            } else {
                              isBookmarked = true;
                              _controller.forward();
                            }
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Lottie.network(
                              'https://lottie.host/bee59ff8-eb4a-4245-9e8d-ad6521f98bf1/zFNurdNhaS.json',
                              controller: _controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      widget.trip?.title ?? "NaN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
