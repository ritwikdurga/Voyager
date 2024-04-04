import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class SplitPage extends StatefulWidget {
  final Function(List<String>?) onSelectedItemsChanged;
  List<String>? selectedItems;
  bool noOneSelected;
  SplitPage(
      {required this.onSelectedItemsChanged,
      required this.noOneSelected,
      required this.selectedItems});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<String>? selectedItems;
  late bool noOneSelected;
  String photoURL =
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItems = widget.selectedItems;
    noOneSelected = widget.noOneSelected;
  }

  final List<String> items = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Williams',
    'Emma Brown',
    'NO ONE'
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('split'),
      // ),
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
                SizedBox(width: screenWidth * 0.30),
                Text(
                  'Split',
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
              final isSelected =
                  selectedItems != null ? selectedItems!.contains(item) : false;

              return ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(photoURL),
                ),
                title: Text(item),
                onTap: () {
                  setState(() {
                    if (item == 'NO ONE' && !isSelected) {
                      // If 'NO ONE' is clicked, deselect all other items
                      if (selectedItems != null) {
                        selectedItems!.clear();
                      } else {
                        selectedItems = [];
                      }
                      selectedItems!.add('NO ONE');
                      noOneSelected = true;
                    } else if (isSelected) {
                      if (item == 'NO ONE') {
                        noOneSelected = false;
                      }
                      selectedItems!.remove(item);
                    } else if (!noOneSelected) {
                      if (selectedItems == null) {
                        selectedItems = [];
                      }
                      selectedItems!.add(item);
                    }
                  });
                  widget.onSelectedItemsChanged(
                      selectedItems); // Invoke the callback
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
                // Pass selected items back to the previous page
                Navigator.of(context).pop(selectedItems);
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
}
