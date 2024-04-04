// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'ProductSans',
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Meet the developers behind Voyager',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontFamily: 'ProductSans')),
              SizedBox(height: 20),
              // 1st container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Chunduri Abhijit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
             SizedBox(height: 20),
              // 2nd container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Chukka Nithin',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A 2nd Year Undergrad at IIT Roorkee. Have good coding experience with C++ and Java. Passionate about Competitive Programming. Hobbies include watching movies and listening to music. Interested in cybersecurity.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 3rd container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Pikala Ritwik Durga',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A 2nd Year Undergrad at IIT Roorkee. Have good coding experience with C++ and Java. Passionate about coding and hacking. Always eager to learn new things. Enjoy reading magazines and playing video games in my free time.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 4th container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Ritwik',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum dolor sitafaf ad ad adf adf adf ad fadf adf adf adf ad fadf adf ad fad fadf adf adf adf ad amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 5th container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Ritwik',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum dolor sitafaf ad ad adf adf adf ad fadf adf adf adf ad fadf adf ad fad fadf adf adf adf ad amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 6th container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Ritwik',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum dolor sitafaf ad ad adf adf adf ad fadf adf adf adf ad fadf adf ad fad fadf adf adf adf ad amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 7th container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                            'Ritwik',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            
                            children: [
                              Icon(Icons.email, color: HexColor('5c6bc0'),),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/github1.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              new SvgPicture.asset(
                                'assets/svg/linkedin.svg',
                                height: 20.0,
                                width: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum dolor sitafaf ad ad adf adf adf ad fadf adf adf adf ad fadf adf ad fad fadf adf adf adf ad amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'ProductSans',
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Text('Ritwik'),
              //     Spacer(),
              //     Text('Designed & developed frontend'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Abhijit'),
              //     Spacer(),
              //     Text('Developed frontend'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Harish'),
              //     Spacer(),
              //     Text('Developed frontend'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Nithin'),
              //     Spacer(),
              //     Text('Developed backend'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Leela'),
              //     Spacer(),
              //     Text('Found model for AI'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Lohith'),
              //     Spacer(),
              //     Text('Nothing'),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text('Bharath'),
              //     Spacer(),
              //     Text('Nothing'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
