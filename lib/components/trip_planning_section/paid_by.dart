import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/utils/constants.dart';
import 'package:voyager/models/user_model.dart';

class PaidByPage extends StatefulWidget {
  final Map<String, dynamic>? selectedPaidBy;
  final List<UserModel> userdata;

  const PaidByPage({
    super.key,
    required this.selectedPaidBy,
    required this.userdata,
  });

  @override
  State<PaidByPage> createState() => _PaidByPageState();
}

class _PaidByPageState extends State<PaidByPage> {
  late Map<String, dynamic> selectedPaidBy;

  @override
  void initState() {
    super.initState();
    selectedPaidBy = widget.selectedPaidBy ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Map<String, dynamic>> items = widget.userdata.map((user) {
      return {
        'name': user.name ?? '',
        'photoURL': user.photoURL ?? '',
        'uid': user.uid ?? '',
      };
    }).toList();

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
                SizedBox(width: screenWidth * 0.25),
                const Text(
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
            physics: const ClampingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> item = items[index];
              final String name = item['name'];
              final String photoURL = item['photoURL'];
              final String uid = item['uid'];
              final bool isSelected = selectedPaidBy['name'] == name &&
                  selectedPaidBy['uid'] == uid;
              return ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(photoURL),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedPaidBy = {
                      'name': name,
                      'uid': uid,
                    };
                  });
                  // Save selected option to shared preferences
                  _saveSelectedOption(uid);
                },
                trailing: isSelected ? const Icon(Icons.check) : null,
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

  void _saveSelectedOption(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPaidBy', selectedPaidBy['name']);
    await prefs.setString('selectedPaidByUid', uid);
  }
}
