import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyager/models/user_model.dart';

class SplitPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>?) onSelectedItemsChanged;
  final List<Map<String, dynamic>>? selectedItems;
  final bool noOneSelected;
  final List<UserModel> userData;

  const SplitPage({
    super.key,
    required this.onSelectedItemsChanged,
    required this.noOneSelected,
    required this.selectedItems,
    required this.userData,
  });

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<Map<String, dynamic>>? selectedItems;
  late bool noOneSelected;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedItems ?? [];
    noOneSelected = widget.noOneSelected;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'name': 'None',
        'photoURL': '',
        'uid': FirebaseAuth.instance.currentUser?.uid ?? '',
      },
      ...widget.userData.map((user) {
        return {
          'name': user.name ?? '',
          'photoURL': user.photoURL ?? '',
          'uid': user.uid ?? '',
        };
      })
    ];

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
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                ),
                SizedBox(width: screenWidth * 0.30),
                const Text(
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> item = items[index];
                final String name = item['name'];
                final String uid = item['uid'];
                final String photoURL = item['photoURL'] ??
                    ''; // Provide default value for photoURL

                final bool isSelected = selectedItems != null
                    ? selectedItems!
                        .any((selectedItem) => selectedItem['name'] == name)
                    : false;

                return ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(photoURL),
                  ),
                  title: Text(name),
                  onTap: () {
                    setState(() {
                      if (name == 'None' && !isSelected) {
                        selectedItems = [
                          {'name': 'None', 'uid': 'None'}
                        ];
                        noOneSelected = true;
                      } else if (isSelected) {
                        selectedItems!
                            .removeWhere((item) => item['name'] == name);
                        if (name == 'None') {
                          noOneSelected = false;
                        }
                      } else if (!noOneSelected) {
                        selectedItems!.add({'name': name, 'uid': uid});
                      }
                    });
                    widget.onSelectedItemsChanged(selectedItems);
                  },
                  trailing: isSelected ? const Icon(Icons.check) : null,
                );
              },
            ),
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
                Navigator.of(context).pop(selectedItems);
              },
              child: const Text(
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
