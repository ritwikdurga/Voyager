// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import date symbol data
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/flight_ticket_widget.dart';
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
  String DepartureDate;

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  @override
  void initState() {
    _selectedDate = DateTime.parse(widget.DepartureDate);
    super.initState();
    getFlights();
  }

  late DateTime _selectedDate;
  var itineraries;
  // call the api to get the flights

  Future<void> getFlights() async {
    var url =
        Uri.parse('https://sky-scanner3.p.rapidapi.com/flights/search-one-way');

    var headers = {
      'X-RapidAPI-Key': 'b2aab9152bmsh7f208feb5f2b581p1c5e70jsnd0a5652a8b5a',
      'X-RapidAPI-Host': 'sky-scanner3.p.rapidapi.com'
    };

    var params = {
      'fromEntityId': widget.selectedFromAirport?['entity_id'],
      'toEntityId': widget.selectedToAirport?['entity_id'],
      'departDate': widget.DepartureDate,
      if (widget.Class != null) 'cabinClass': widget.Class!.toLowerCase(),
    };

    var response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        itineraries = responseBody['data']['itineraries'];
      });
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
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          scrollDirection: Axis.vertical,
          children: [
            HorizontalCalendarCustom(
              date: widget.DepartureDate.isEmpty
                  ? DateTime.now()
                  : DateFormat('yyyy-MM-dd').parse(widget.DepartureDate),
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
                  widget.DepartureDate = DateFormat('yyyy-MM-dd').format(date);
                  itineraries = null;
                });
                getFlights();
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
            itineraries != null
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: itineraries.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      //print(itineraries[index]);
                      //print('Type of itineraries[$index]: ${itineraries[index].runtimeType}');
                      return Column(
                        children: [
                          MultipleTicketsWidget(
                            ticketsData: [itineraries[index]],
                            passengerCount: widget.PassengerCount,
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                : SizedBox(),
          ],
        ),
      ),
      //body:  MultipleTicketsWidget(),
    );
  }
}
