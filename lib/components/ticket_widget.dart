import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class TicketWid extends StatefulWidget {
  const TicketWid({
    Key? key,
    required this.width,
    required this.height,
    required this.topText,
    required this.bottomText,
    this.padding,
    this.margin,
    this.color = Colors.transparent,
    this.isCornerRounded = false,
    this.shadow,
  }) : super(key: key);

  final double width;
  final double height;
  final String topText;
  final String bottomText;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;

  @override
  _TicketWidState createState() => _TicketWidState();
}

class _TicketWidState extends State<TicketWid> {
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
                        'Achhnera Kasganj Express Special',
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
                  '18181',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 20,
                              child: Text(
                                'Kashi Vishwanath Temple',
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
                            '15 MAR',
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
                            '10:00 AM',
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.train,
                            size: 20,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        // time of travel
                        Text(
                          '2H 45M',
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
                          Container(
                            width: 120,
                            // Set the maximum width you want the text to occupy
                            child: SizedBox(
                              height: 20,
                              child: Text(
                                'Bharatpur Junction',
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
                            '15 MAR',
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
                            '12:45 PM',
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
                    child: Text('Add to Trip',
                        style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                            '₹ 200',
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
                            '₹ 400',
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
