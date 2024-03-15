import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import date symbol data
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/horizontal_cal.dart';
import '../components/ticket_widget.dart';
import '../utils/constants.dart';

class SearchFlights extends StatefulWidget {
  const SearchFlights({super.key});

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Flights on ${DateFormat.yMMMd().format(_selectedDate)}',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Iconsax.sort,
                          size: 20,
                        ),
                        onPressed: () {
                          // Add your sort functionality here
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Iconsax.filter,
                          size: 20,
                        ),
                        onPressed: () {
                          // Add your filter functionality here
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TicketWid(
                      name: 'Air India',
                      number: 'AI-202',
                      symbol: Icons.flight,
                      width: width,
                      height: 200,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      topText: "TIC",
                      bottomText: "TIC",
                    ),
                    SizedBox(height: 12),
                    TicketWid(
                      name: 'Air India',
                      number: 'AI-202',
                      symbol: Icons.flight,
                      width: width,
                      height: 200,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      topText: "TIC",
                      bottomText: "TIC",
                    ),
                    SizedBox(height: 12),
                    TicketWid(
                      name: 'Air India',
                      number: 'AI-202',
                      symbol: Icons.flight,
                      width: width,
                      height: 200,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      topText: "TIC",
                      bottomText: "TIC",
                    ),
                    SizedBox(height: 12),
                    TicketWid(
                      name: 'Air India',
                      number: 'AI-202',
                      symbol: Icons.flight,
                      width: width,
                      height: 200,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      topText: "TIC",
                      bottomText: "TIC",
                    ),
                    SizedBox(height: 12),
                    TicketWid(
                      name: 'Air India',
                      number: 'AI-202',
                      symbol: Icons.flight,
                      width: width,
                      height: 200,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      topText: "TIC",
                      bottomText: "TIC",
                    ),
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
