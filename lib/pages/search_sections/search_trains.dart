// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../components/search_section/horizontal_cal.dart';
import '../../components/search_section/ticket_widget.dart';
import '../../utils/constants.dart';

class SearchTrains extends StatefulWidget {
  final String? fromStation;
  final String? toStation;
  final String fromStationName;
  final String toStationName;
  late String date;
  final int passengers;

  SearchTrains({
    Key? key,
    required this.fromStation,
    required this.toStation,
    required this.fromStationName,
    required this.toStationName,
    required this.date,
    required this.passengers,
  }) : super(key: key);

  @override
  State<SearchTrains> createState() => _SearchTrainsState();
}

class _SearchTrainsState extends State<SearchTrains> {
  late DateTime _selectedDate;
  late Future<List<dynamic>> trainDataFuture;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.date);
    debugPrint('Date: ${widget.date}');
    debugPrint('From: ${widget.fromStation}');
    debugPrint('To: ${widget.toStation}');
  }

  Future<Map<String, int>> getTrainFare(String trainNumber) async {
    var url = Uri.parse(
        'https://irctc1.p.rapidapi.com/api/v2/getFare?trainNo=${trainNumber}&fromStationCode=${widget.fromStation}&toStationCode=${widget.toStation}');
    var headers = {
      'X-RapidAPI-Key': dotenv.env['TRAIN_KEY']!,
      'X-RapidAPI-Host': 'irctc1.p.rapidapi.com'
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // Decode JSON here
        var jsonResponse = json.decode(response.body);
        var generalData = jsonResponse['data']['general'];
        Map<String, int> fareData = {};
        generalData.forEach((data) {
          fareData[data['classType']] = data['fare'];
        });
        return fareData;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return {}; // Return an empty map here or handle the error accordingly
      }
    } catch (error) {
      print('Error: $error');
      return {}; // Return an empty map here or handle the error accordingly
    }
  }

  Future<List<dynamic>> getTrains() async {
    var url = Uri.parse(
        'https://irctc1.p.rapidapi.com/api/v3/trainBetweenStations?fromStationCode=${widget.fromStation}&toStationCode=${widget.toStation}&dateOfJourney=${widget.date}');
    var headers = {
      'X-RapidAPI-Key': dotenv.env['TRAIN_KEY']!,
      'X-RapidAPI-Host': 'irctc1.p.rapidapi.com'
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // Decode JSON here
        var jsonResponse = json.decode(response.body);
        print(jsonResponse['data']);
        return jsonResponse['data'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  String formatDuration(String duration) {
    List<String> parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    String formattedDuration = '${hours}H ${minutes}M';
    return formattedDuration;
  }

  @override
  Widget build(BuildContext context) {
    trainDataFuture = getTrains();
    final double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Search Trains',style: TextStyle(color: Colors.blueAccent,fontWeight:FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HorizontalCalendarCustom(
              date: widget.date.isEmpty
                  ? DateTime.now()
                  : DateFormat('yyyy-MM-dd').parse(widget.date),
              initialDate: DateTime.now(),
              textColor: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              backgroundColor: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.black
                  : Colors.white,
              selectedColor: Colors.blueAccent,
              showMonth: true,
              locale: Localizations.localeOf(context),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  widget.date = DateFormat('yyyy-MM-dd').format(date);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Trains on ${DateFormat.yMMMd().format(_selectedDate)}',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: trainDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<dynamic> trainData = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: trainData.length,
                      itemBuilder: (context, index) {
                        var train = trainData[index];
                        List<String> classTypes = [];
                        Map<String, int>? fareData;

                        return FutureBuilder<Map<String, int>>(
                          future:
                              getTrainFare(train['train_number'].toString()),
                          builder: (context, fareSnapshot) {
                            if (fareSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (fareSnapshot.hasError) {
                              return Text('Error: ${fareSnapshot.error}');
                            } else {
                              fareData = fareSnapshot.data;
                              train['class_type'].forEach((classType) {
                                classTypes.add(classType.toString());
                              });
                              debugPrint(classTypes.toString());
                              debugPrint(fareData.toString());
                              return Column(
                                children: [
                                  TicketWid(
                                    name: train['train_name'],
                                    number: train['train_number'],
                                    fromStationName: widget.fromStationName,
                                    toStationName: widget.toStationName,
                                    fromDate: DateFormat('dd MMM').format(
                                        DateFormat('dd-MM-yyyy')
                                            .parse(train['train_date'])),
                                    toDate: DateFormat('dd MMM').format(
                                        DateFormat('dd-MM-yyyy')
                                            .parse(train['train_date'])
                                            .add(
                                                Duration(days: train['to_day']))
                                            .subtract(Duration(
                                                days: train['from_day']))),
                                    fromTime: DateFormat("h:mm a").format(
                                        DateFormat("HH:mm")
                                            .parse(train['from_sta'])),
                                    toTime: DateFormat("h:mm a").format(
                                        DateFormat("HH:mm")
                                            .parse(train['to_sta'])),
                                    duration: formatDuration(train['duration']),
                                    fareData: fareData ?? {},
                                    classes: classTypes,
                                    symbol: Icons.train,
                                    width: width,
                                    height: 200,
                                    passengersCount: widget.passengers,
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    topText: widget.fromStation!,
                                    bottomText: widget.toStation!,
                                  ),
                                  if (index != trainData.length - 1)
                                    SizedBox(
                                      height: 12,
                                    )
                                ],
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
