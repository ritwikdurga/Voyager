// sort.dart

import 'package:flutter/material.dart';

class SortPage extends StatefulWidget {
  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort Options'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Date(newest first)'),
            onTap: () {
              // Do something when Option 1 is selected
              Navigator.pop(context, 'Option 1');
            },
          ),
          ListTile(
            title: Text('Date(oldest first)'),
            onTap: () {
              // Do something when Option 1 is selected
              Navigator.pop(context, 'Option 2');
            },
          ),
           ListTile(
            title: Text('Amount(highest first)'),
            onTap: () {
              // Do something when Option 1 is selected
              Navigator.pop(context, 'Option 3');
            },
          ),
           ListTile(
            title: Text('Amount(lowest first)'),
            onTap: () {
              // Do something when Option 1 is selected
              Navigator.pop(context, 'Option 4');
            },
          ),
           ListTile(
            title: Text('category'),
            onTap: () {
              // Do something when Option 1 is selected
              Navigator.pop(context, 'Option 5');
            },
          ),
          // Add more options as needed
        ],
      ),
    );
  }
}
