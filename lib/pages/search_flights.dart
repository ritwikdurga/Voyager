import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import date symbol data
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/horizontal_cal.dart';
import '../components/ticket_widget.dart';
import '../utils/constants.dart';

class SearchFlights extends StatefulWidget {
  SearchFlights(
      {super.key,
      required this.selectedFromAirport,
      required this.selectedToAirport,
      required this.DepartureDate,
      required this.Class,
      required this.PassengerCount});

  Map<String, String>? selectedFromAirport;
  Map<String, String>? selectedToAirport;
  String? Class;
  int PassengerCount;
  DateTime? DepartureDate;

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    print(widget.selectedFromAirport.toString());
    print(widget.selectedToAirport.toString());
    print(widget.DepartureDate.toString());
    print(widget.PassengerCount);
    getFlights();
  }

  // call the api to get the flights
  Future<void> getFlights() async {
    var url =
        Uri.parse('https://sky-scanner3.p.rapidapi.com/flights/search-one-way');

    var headers = {
      'X-RapidAPI-Key': 'befb2e3d3amsh91f7217f2b2de4cp170455jsn501d2baf90f7',
      'X-RapidAPI-Host': 'sky-scanner3.p.rapidapi.com'
    };

    var params = {
      'fromEntityId': widget.selectedFromAirport?['entity_id'],
      'toEntityId': widget.selectedToAirport?['entity_id'],
      'departDate': DateFormat('yyyy-MM-dd').format(widget.DepartureDate!),
      if (widget.Class != null) 'cabinClass': widget.Class,
    };

    var response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var itineraries = responseBody['data']['itineraries'];
      print(itineraries);
      //print(response.body.itineraries.toString());
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Search Flights'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HorizontalCalendarCustom(
              date: DateTime.now(),
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
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flights on ${DateFormat.yMMMd().format(_selectedDate)}',
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    // TicketWid(
                    //   name: 'Air India',
                    //   number: 'AI-202',
                    //   symbol: Icons.flight,
                    //   width: width,
                    //   height: 200,
                    //   color: themeProvider.themeMode == ThemeMode.dark
                    //       ? Colors.white
                    //       : Colors.black,
                    //   topText: "TIC",
                    //   bottomText: "TIC",
                    // ),
                    // SizedBox(height: 12),
                    // TicketWid(
                    //   name: 'Air India',
                    //   number: 'AI-202',
                    //   symbol: Icons.flight,
                    //   width: width,
                    //   height: 200,
                    //   color: themeProvider.themeMode == ThemeMode.dark
                    //       ? Colors.white
                    //       : Colors.black,
                    //   topText: "TIC",
                    //   bottomText: "TIC",
                    // ),
                    // SizedBox(height: 12),
                    // TicketWid(
                    //   name: 'Air India',
                    //   number: 'AI-202',
                    //   symbol: Icons.flight,
                    //   width: width,
                    //   height: 200,
                    //   color: themeProvider.themeMode == ThemeMode.dark
                    //       ? Colors.white
                    //       : Colors.black,
                    //   topText: "TIC",
                    //   bottomText: "TIC",
                    // ),
                    // SizedBox(height: 12),
                    // TicketWid(
                    //   name: 'Air India',
                    //   number: 'AI-202',
                    //   symbol: Icons.flight,
                    //   width: width,
                    //   height: 200,
                    //   color: themeProvider.themeMode == ThemeMode.dark
                    //       ? Colors.white
                    //       : Colors.black,
                    //   topText: "TIC",
                    //   bottomText: "TIC",
                    // ),
                    // SizedBox(height: 12),
                    // TicketWid(
                    //   name: 'Air India',
                    //   number: 'AI-202',
                    //   symbol: Icons.flight,
                    //   width: width,
                    //   height: 200,
                    //   color: themeProvider.themeMode == ThemeMode.dark
                    //       ? Colors.white
                    //       : Colors.black,
                    //   topText: "TIC",
                    //   bottomText: "TIC",
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
