// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class MultipleTicketsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> ticketsData;
  final int passengerCount;

  const MultipleTicketsWidget(
      {Key? key, required this.ticketsData, required this.passengerCount})
      : super(key: key);

  @override
  State<MultipleTicketsWidget> createState() => _MultipleTicketsWidgetState();
}

class _MultipleTicketsWidgetState extends State<MultipleTicketsWidget> {
  String formatDuration(int durationInMinutes) {
    int hours = durationInMinutes ~/ 60;
    int minutes = durationInMinutes % 60;
    return '${hours}H ${minutes}M';
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.ticketsData.toString());
    //print(widget.ticketsData[0]['legs'][0]['stopCount'].toInt());
    //print(widget.ticketsData[0]['legs'][0]['segments'][0]['origin']['displayCode']);
    // print(widget.ticketsData[0]['legs'][0]['segments'][0]['flightNumber'].toInt());
    return ListView.builder(
      itemCount: widget.ticketsData[0]['legs'][0]['stopCount'].toInt() + 1,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        //print(widget.ticketsData[0]['legs'][0]['segments'][0]['arrival'].toString());
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              TicketWidget(
                width: MediaQuery.of(context).size.width,
                height: 250,
                fromAirport: widget.ticketsData[0]['legs'][0]['segments'][index]
                    ['origin']['name'],
                toAirport: widget.ticketsData[0]['legs'][0]['segments'][index]
                    ['destination']['name'],
                topText: widget.ticketsData[0]['legs'][0]['segments'][index]
                    ['origin']['displayCode'],
                bottomText: widget.ticketsData[0]['legs'][0]['segments'][index]
                    ['destination']['displayCode'],
                price: int.parse(widget.ticketsData[0]['price']['formatted']
                        .replaceAll(RegExp(r'[^\d]'), '')) *
                    83,
                isLastItem: widget.ticketsData[0]['legs'].length == 2
                    ? false
                    : index ==
                        widget.ticketsData[0]['legs'][0]['stopCount'].toInt(),
                passengers: widget.passengerCount,
                duration: formatDuration(widget.ticketsData[0]['legs'][0]
                        ['segments'][index]['durationInMinutes']
                    .toInt()),
                flightNumber: widget.ticketsData[0]['legs'][0]['segments']
                    [index]['flightNumber'],
                flightOperator: widget.ticketsData[0]['legs'][0]['segments']
                    [index]['operatingCarrier']['name'],
                fromDate: DateFormat('dd MMM').format(DateTime.parse(
                    widget.ticketsData[0]['legs'][0]['segments'][index]
                        ['departure'])),
                toDate: DateFormat('dd MMM').format(DateTime.parse(widget
                    .ticketsData[0]['legs'][0]['segments'][index]['arrival'])),
                fromTime: DateFormat('hh:mm a').format(DateTime.parse(
                    widget.ticketsData[0]['legs'][0]['segments'][index]
                        ['departure'])),
                toTime: DateFormat('hh:mm a').format(DateTime.parse(widget
                    .ticketsData[0]['legs'][0]['segments'][index]['arrival'])),
              ),
              if (widget.ticketsData[0]['legs'].length == 2)
                TicketWidget(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fromAirport: widget.ticketsData[0]['legs'][1]['segments']
                      [index]['origin']['name'],
                  toAirport: widget.ticketsData[0]['legs'][1]['segments'][index]
                      ['destination']['name'],
                  topText: widget.ticketsData[0]['legs'][1]['segments'][index]
                      ['origin']['displayCode'],
                  bottomText: widget.ticketsData[0]['legs'][1]['segments']
                      [index]['destination']['displayCode'],
                  price: int.parse(widget.ticketsData[0]['price']['formatted']
                          .replaceAll(RegExp(r'[^\d]'), '')) *
                      83,
                  isLastItem: index ==
                      widget.ticketsData[0]['legs'][1]['stopCount'].toInt(),
                  passengers: widget.passengerCount,
                  duration: formatDuration(widget.ticketsData[0]['legs'][1]
                          ['segments'][index]['durationInMinutes']
                      .toInt()),
                  flightNumber: widget.ticketsData[0]['legs'][1]['segments']
                      [index]['flightNumber'],
                  flightOperator: widget.ticketsData[0]['legs'][1]['segments']
                      [index]['operatingCarrier']['name'],
                  fromDate: DateFormat('dd MMM').format(DateTime.parse(
                      widget.ticketsData[0]['legs'][1]['segments'][index]
                          ['departure'])),
                  toDate: DateFormat('dd MMM').format(DateTime.parse(
                      widget.ticketsData[0]['legs'][1]['segments'][index]
                          ['arrival'])),
                  fromTime: DateFormat('hh:mm a').format(DateTime.parse(
                      widget.ticketsData[0]['legs'][1]['segments'][index]
                          ['departure'])),
                  toTime: DateFormat('hh:mm a').format(DateTime.parse(
                      widget.ticketsData[0]['legs'][1]['segments'][index]
                          ['arrival'])),
                ),
            ],
          ),
        );
      },
    );
  }
}

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.topText,
    required this.bottomText,
    required this.isLastItem, // Add isLastItem parameter
    this.padding,
    this.margin,
    this.color = Colors.transparent,
    this.isCornerRounded = false,
    this.shadow,
    required this.price,
    required this.passengers,
    required this.fromAirport,
    required this.toAirport,
    required this.duration,
    required this.flightNumber,
    required this.flightOperator,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
  }) : super(key: key);

  final double width;
  final double height;
  final String topText;
  final String bottomText;
  final bool isLastItem;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;
  final int price;
  final int passengers;
  final String fromAirport;
  final String toAirport;
  final String duration;
  final String flightNumber;
  final String flightOperator;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              borderRadius: BorderRadius.circular(
                widget.isCornerRounded ? 20 : 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              // bottom: widget.height * 0.3,
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
                        '${widget.flightOperator}',
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
                  '${widget.flightNumber}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 60,
                              child: Text(
                                '${widget.fromAirport} Airport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3, // Show ellipsis if overflow occurs
                              ),
                            ),
                          ),

                          Text(
                            widget.topText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // date of arrival
                          Text(
                            '${widget.fromDate}',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          // time of arrival
                          Text(
                            '${widget.fromTime}',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.flight,
                            size: 20,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        // time of travel
                        Text(
                          widget.duration,
                          style: TextStyle(
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 60,
                              child: Text(
                                '${widget.toAirport} Airport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3, // Show ellipsis if overflow occurs
                              ),
                            ),
                          ),
                          Text(
                            widget.bottomText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // date of arrival
                          Text(
                            '${widget.toDate}',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          // time of arrival
                          Text(
                            '${widget.toTime}',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
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
          if (widget.isLastItem) // Show only for the last item
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: widget.height * 0.3,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add to Trip'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹ ${widget.price}',
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
                              '₹ ${widget.price * widget.passengers}',
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
            top: widget.height, // Adjust position as needed
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: DashedLinePainter(),
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
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blueAccent // Set the color of the dashed line
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double dashWidth = 5;
    final double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
