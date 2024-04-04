// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/utils/constants.dart'; // Import the shared_preferences package

class PaidByPage extends StatefulWidget {
  String? selectedPaidBy;
  PaidByPage({required this.selectedPaidBy});
  @override
  _PaidByPageState createState() => _PaidByPageState();
}

class _PaidByPageState extends State<PaidByPage> {
  String photoURL =
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80';

  final List<String> items = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Williams',
    'Emma Brown',
  ];

  String? selectedPaidBy;

  @override
  void initState() {
    super.initState();
    // Retrieve previously selected option from shared preferences
    selectedPaidBy = widget.selectedPaidBy;
    //_loadSelectedOption();
  }

  // void _loadSelectedOption() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     selectedPaidBy = prefs.getString('selectedPaidBy');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 20)),
                SizedBox(width: screenWidth * 0.25),
                Text(
                  'Paid By',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ProductSans',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              final isSelected = selectedPaidBy == item;

              return ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(photoURL),
                ),
                title: Text(item,
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.bold,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  setState(() {
                    selectedPaidBy = item;
                  });
                  // Save selected option to shared preferences
                  _saveSelectedOption();
                },
                trailing: isSelected ? Icon(Icons.check) : null,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // Pass the selected person back to the previous page
                Navigator.of(context).pop(selectedPaidBy);
              },
              child: Text(
                'Done',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSelectedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPaidBy', selectedPaidBy ?? '');
  }
}
