// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../components/search_section/flight_ticket_widget.dart';
import '../../utils/constants.dart';

class SearchRoundFlights extends StatefulWidget {
  SearchRoundFlights(
      {super.key,
      required this.selectedFromAirport,
      required this.selectedToAirport,
      required this.Class,
      required this.PassengerCount,
      required this.DepartureDate,
      required this.ArrivalDate});

  Map<String, String>? selectedFromAirport;
  Map<String, String>? selectedToAirport;
  String? Class;
  int PassengerCount;
  String DepartureDate;
  String ArrivalDate;

  @override
  State<SearchRoundFlights> createState() => _SearchRoundFlightsState();
}

class _SearchRoundFlightsState extends State<SearchRoundFlights> {
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
    var url = Uri.parse(
        'https://sky-scanner3.p.rapidapi.com/flights/search-roundtrip');

    var headers = {
      'X-RapidAPI-Key': '<YOUR API KEY>',
      'X-RapidAPI-Host': 'sky-scanner3.p.rapidapi.com'
    };

    var params = {
      'fromEntityId': widget.selectedFromAirport?['entity_id'],
      'toEntityId': widget.selectedToAirport?['entity_id'],
      'departDate': widget.DepartureDate,
      'returnDate': widget.ArrivalDate,
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
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flights from ${widget.selectedFromAirport?['place']} to ${widget.selectedToAirport?['place']} and back',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
