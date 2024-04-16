// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/add_to_trips.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_trains.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';

import '../../utils/constants.dart';

class TicketWid extends StatefulWidget {
  const TicketWid({
    super.key,
    required this.width,
    required this.height,
    required this.topText,
    required this.bottomText,
    required this.fromStationName,
    required this.toStationName,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.duration,
    required this.name,
    required this.number,
    required this.passengersCount,
    required this.symbol,
    required this.fareData,
    this.padding,
    this.margin,
    required this.classes,
    this.color = Colors.transparent,
    this.isCornerRounded = false,
    this.shadow,
  });

  final double width;
  final double height;
  final String topText;
  final String bottomText;
  final String fromStationName;
  final String toStationName;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String duration;
  final String name;
  final String number;
  final int passengersCount;

  final Map<String, int> fareData;
  final IconData symbol;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;
  final List<String> classes;

  @override
  State<TicketWid> createState() => _TicketWidState();
}

class _TicketWidState extends State<TicketWid> {
  String? _selectedClass;
  bool _isClassSelected = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final tripsProvider = Provider.of<TripsProvider>(context);
    return ClipPath(
      clipper: TicketClipper(),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            margin: widget.margin,
            decoration: BoxDecoration(
              boxShadow: widget.shadow,
              color: widget.color,
              borderRadius: BorderRadius.circular(
                widget.isCornerRounded ? 20 : 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.height * 0.3,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.number,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 20,
                              child: Text(
                                widget.fromStationName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Show ellipsis if overflow occurs
                              ),
                            ),
                          ),

                          Text(
                            widget.topText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          // date of travel
                          Text(
                            widget.fromDate,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          // time of arrival
                          Text(
                            widget.fromTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            widget.symbol,
                            size: 20,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // time of travel
                        Text(
                          widget.duration,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 20,
                              child: Text(
                                widget.toStationName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Show ellipsis if overflow occurs
                              ),
                            ),
                          ),
                          Text(
                            widget.bottomText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          // date of travel
                          Text(
                            widget.toDate,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          // time of arrival
                          Text(
                            widget.toTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // a row widget to display add to trip button at one end and its price at the other end
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: widget.height * 0.3,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> trainDataMap = {
                        'fromStation': widget.fromStationName,
                        'toStation': widget.toStationName,
                        'topText': widget.topText,
                        'bottomText': widget.bottomText,
                        'price': widget.fareData[_selectedClass!].toString(),
                        'trainNumber': widget.number,
                        'trainOperator': widget.name,
                        'fromDate': widget.fromDate,
                        'toDate': widget.toDate,
                        'fromTime': widget.fromTime,
                        'toTime': widget.toTime,
                      };
                      TrainData trainData = TrainData.fromMap(trainDataMap);
                      print(trainData);
                      showBottomSheetForSelectingTrips(
                          context,
                          tripsProvider.tripList.length,
                          tripsProvider.tripList,
                          null,
                          trainData,
                          2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text('Add to Trip',
                        style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                        )),
                  ),

                  // dropdown to select the class of travel
                  DropdownButton<String>(
                    value: _selectedClass,
                    items: widget.classes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? selectedValue) {
                      // Handle the selection here
                      setState(() {
                        _selectedClass = selectedValue;
                        _isClassSelected = true;
                      });
                      print("Selected value: $selectedValue");
                    },
                    hint: Text(
                      'Classes',
                      style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    dropdownColor: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  if (_isClassSelected)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹ ${widget.fareData[_selectedClass!]}',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // "/ person" text
                            Text(
                              '/ person',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        // now if user enters the number of persons then the total price will be calculated
                        // and displayed here
                        Row(
                          children: [
                            Text(
                              'Total: ',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '₹ ${(widget.fareData[_selectedClass] ?? 1) * widget.passengersCount} ',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          Positioned(
            top: widget.height * 0.7, // Adjust position as needed
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: DashedLinePainter(
                themeProvider: themeProvider,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height * 0.7), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height * 0.7), radius: 20.0));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  final ThemeProvider themeProvider; // Assuming you have a ThemeProvider class

  DashedLinePainter({required this.themeProvider});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white // Set the color of the dashed line based on theme mode
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
