import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the shared_preferences package

class PaidByPage extends StatefulWidget {
  String? selectedPaidBy;
  PaidByPage({required this.selectedPaidBy});
  @override
  _PaidByPageState createState() => _PaidByPageState();
}

class _PaidByPageState extends State<PaidByPage> {
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
    selectedPaidBy=widget.selectedPaidBy;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Paid By'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          final isSelected = selectedPaidBy == item;

          return ListTile(
            title: Text(item),
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
