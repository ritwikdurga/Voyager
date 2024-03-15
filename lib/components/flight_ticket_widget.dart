import 'package:flutter/material.dart';

class MultipleTicketsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Flights'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TicketWid(
              width: MediaQuery.of(context).size.width,
              height: 250,
              // Adjust height as needed
              topText: 'Top Text $index',
              bottomText: 'Bottom Text $index',
              isLastItem: index == 2,
            ),
          );
        },
      ),
    );
  }
}

class TicketWid extends StatefulWidget {
  const TicketWid({
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
  }) : super(key: key);

  final double width;
  final double height;
  final String topText;
  final String bottomText;
  final bool isLastItem; // Declare isLastItem parameter
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
              color: Colors.blueAccent,
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
                        'Air India',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'AI-181',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
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
                                'Netaji Subhash Chandra Bose International Airport',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // date of arrival
                          Text(
                            '15 MAR',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          // time of arrival
                          Text(
                            '10:00 AM',
                            style: const TextStyle(
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
                          child: Icon(Icons.flight, size: 20),
                        ),
                        SizedBox(height: 5),
                        // time of travel
                        Text(
                          '2H 45M',
                          style: const TextStyle(
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
                                'Chatrapati Shivaji Maharaj International Airport',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // date of arrival
                          Text(
                            '15 MAR',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          // time of arrival
                          Text(
                            '12:45 PM',
                            style: const TextStyle(
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
                color: Colors.blueAccent,
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
                              '₹ 200',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // "/ person" text
                            Text(
                              '/ person',
                              style: const TextStyle(
                                color: Colors.black,
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
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '₹ 400',
                              style: const TextStyle(
                                color: Colors.black,
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
      ..color = Colors.black // Set the color of the dashed line
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