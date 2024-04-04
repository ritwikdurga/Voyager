// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart'; // Import date symbol data
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/flight_ticket_widget.dart';
import '../../components/search_section/horizontal_cal.dart';
import '../../components/search_section/ticket_widget.dart';
import '../../utils/constants.dart';

class SearchFlights extends StatefulWidget {
  SearchFlights(
      {Key? key,
      required this.selectedFromAirport,
      required this.selectedToAirport,
      required this.departureDate,
      required this.flightClass,
      required this.passengerCount})
      : super(key: key);

  final Map<String, String>? selectedFromAirport;
  final Map<String, String>? selectedToAirport;
  final String? flightClass;
  final int passengerCount;
  String departureDate;

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  late DateTime _selectedDate;
  late Future<void> _futureFlights;
  List<dynamic>? _itineraries;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.parse(widget.departureDate);
    _futureFlights = getFlights();
  }

  Future<void> getFlights() async {
    var url =
        Uri.parse('https://sky-scanner3.p.rapidapi.com/flights/search-one-way');

    var headers = {
      'X-RapidAPI-Key': '<Your API key here>',
      'X-RapidAPI-Host': 'sky-scanner3.p.rapidapi.com'
    };

    var params = {
      'fromEntityId': widget.selectedFromAirport?['entity_id'],
      'toEntityId': widget.selectedToAirport?['entity_id'],
      'departDate': widget.departureDate,
      if (widget.flightClass != null)
        'cabinClass': widget.flightClass!.toLowerCase(),
    };

    var response =
        await http.get(url.replace(queryParameters: params), headers: headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        _itineraries = responseBody['data']['itineraries'];
      });
      print(_itineraries);
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
        title: Text('Search Flights',style: TextStyle(color: Colors.blueAccent,fontWeight:FontWeight.bold)),
      ),
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _futureFlights,
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
              return ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                scrollDirection: Axis.vertical,
                children: [
                  HorizontalCalendarCustom(
                    date: widget.departureDate.isEmpty
                        ? DateTime.now()
                        : DateFormat('yyyy-MM-dd').parse(widget.departureDate),
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
                        widget.departureDate =
                            DateFormat('yyyy-MM-dd').format(date);
                        _itineraries = null;
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
                  _itineraries != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _itineraries!.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            //print(itineraries[index]);
                            //print('Type of itineraries[$index]: ${itineraries[index].runtimeType}');
                            return Column(
                              children: [
                                MultipleTicketsWidget(
                                  ticketsData: [_itineraries![index]],
                                  passengerCount: widget.passengerCount,
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        )
                      : SizedBox(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
