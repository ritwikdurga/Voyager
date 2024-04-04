// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class ExpenseCategoryPage extends StatefulWidget {
  final Function(Map<String, dynamic>?) onCategorySelected;
  ExpenseCategoryPage({required this.onCategorySelected});
  @override
  _ExpenseCategoryPageState createState() => _ExpenseCategoryPageState();
}

class _ExpenseCategoryPageState extends State<ExpenseCategoryPage> {
  String? selectedCategory; // Initialized as nullable
  final List<String> categories = [
    'Flights',
    'Lodging',
    'Car Rental',
    'Transit',
    'Food',
    'Drinks',
    'Sightseeing',
    'Activities',
    'Shopping',
    'Gas',
    'Groceries',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(width: screenWidth * 0.15),
                  Text(
                    'Expense Category',
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
            Center(
              child: Text(
                'Select a category',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'ProductSans',
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    widget.onCategorySelected({
                      'category': category,
                      'icon': _getIconForCategory(category),
                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _getIconForCategory(category),
                      SizedBox(height: 8),
                      Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold,
                          color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get icon for category
  Icon _getIconForCategory(String category) {
    switch (category) {
      case 'Flights':
        return Icon(Icons.airplanemode_active);
      case 'Lodging':
        return Icon(Icons.hotel);
      case 'Car Rental':
        return Icon(Icons.directions_car);
      case 'Transit':
        return Icon(Icons.directions_transit);
      case 'Food':
        return Icon(Icons.restaurant);
      case 'Drinks':
        return Icon(Icons.local_bar);
      case 'Sightseeing':
        return Icon(Icons.landscape);
      case 'Activities':
        return Icon(Icons.local_activity);
      case 'Shopping':
        return Icon(Icons.shopping_bag);
      case 'Gas':
        return Icon(Icons.local_gas_station);
      case 'Groceries':
        return Icon(Icons.local_grocery_store);
      default:
        return Icon(Icons.category);
    }
  }
}
