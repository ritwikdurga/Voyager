import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('split'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          final isSelected =
              selectedItems != null ? selectedItems!.contains(item) : false;

          return ListTile(
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
              widget
                  .onSelectedItemsChanged(selectedItems); // Invoke the callback
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
