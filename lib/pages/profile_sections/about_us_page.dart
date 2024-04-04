// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'chunduri_a@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject':
                                          // say hi to the developer
                                          'User of Voyager App',
                                      'body':
                                          'Hi Abhijit, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/abhijitch1');
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  SnackBar(
                                      content: Text(
                                          'Developer has not provided LinkedIn profile link'));
                                },
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'chukka_n@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Nithin, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/nithinchukka');
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://www.linkedin.com/in/nithinchukka/');
                                  launchUrl(uri);
                                },
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'pikala_rd@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Ritwik, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/ritwikdurga');
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://www.linkedin.com/in/ritwik-durga/');
                                  launchUrl(uri);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A Sophomore at IIT Roorkee. Have good coding experience with C++ and Java. Passionate about coding and hacking. Always eager to learn new things. Enjoy reading magazines and playing video games in my free time.',
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
                            'Nenavath Harish',
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'nenavath_h@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Harish, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/harish1517203');
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://www.linkedin.com/in/harish-nenavath-92777525b/');
                                  launchUrl(uri);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A Sophomore at IIT Roorkee. I have good coding experience with C++ and Java. Interest in Playing Video games and software development.',
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
                            'Reddi Leela Jogeendar Sai',
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'reddi_ljs@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Leela, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/rljsai'); // add here
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://www.linkedin.com/in/reddi-leela-jogeendar-sai-752256259/'); // add here
                                  launchUrl(uri);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A Sophomore at IIT roorkee. Have coding experience in c++ and java. Passionate about music and movies. Interests in software development and machine learning',
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
                            'Tanala Ratna Bharath',
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'tanala_rb@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Bharath, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/'); // add here
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://github.com/abhijitch1'); // add here
                                  launchUrl(uri);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A 2nd Year Undergraduate at IIT Roorkee. Good at data structures and competitive programming. Interest in exploring research software development',
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
                            'Vangapandu Lohith Kumar',
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
                              GestureDetector(
                                onTap: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'vangapandu_lk@cs.iitr.ac.in',
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'User of Voyager App',
                                      'body':
                                          'Hi Lohith, I am a user of Voyager App and I want to say hi to you.'
                                    }),
                                  );
                                  // if(await canLaunchUrl(emailLaunchUri)) {
                                  //   await launchUrl(emailLaunchUri);
                                  // } else {
                                  //   throw 'Could not launch ${emailLaunchUri.toString()}';
                                  // }
                                  try {
                                    await launchUrl(emailLaunchUri);
                                  } catch (e) {
                                    SnackBar(
                                        content: Text(
                                            'Could not launch ${emailLaunchUri.toString()}'));
                                  }
                                },
                                child: Icon(
                                  Icons.email,
                                  color: HexColor('5c6bc0'),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                  child: SvgPicture.asset(
                                    'assets/svg/github1.svg',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  onTap: () {
                                    Uri uri = Uri.parse(
                                        'https://github.com/lohith49');
                                    launchUrl(uri);
                                  }),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                child: SvgPicture.asset(
                                  'assets/svg/linkedin.svg',
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                onTap: () {
                                  Uri uri = Uri.parse(
                                      'https://www.linkedin.com/in/lohith-kumar-vangapandu-44036b259/'); // add here
                                  launchUrl(uri);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'A Sophomore at IIT Roorkee. Have good coding experience, especially in C++. Beyond academics, I enjoy playing cricket. Main interest in software development.',
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
            ],
          ),
        ),
      ),
    );
  }
}
