import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Category'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Expense Category',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select a category',
                style: TextStyle(
                  fontSize: 18,
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
                          color: selectedCategory == category
                              ? Colors
                                  .blue // Change color for selected category
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
        return Icon(Icons.local_drink);
      case 'Sightseeing':
        return Icon(Icons.landscape);
      case 'Activities':
        return Icon(Icons.sports);
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
