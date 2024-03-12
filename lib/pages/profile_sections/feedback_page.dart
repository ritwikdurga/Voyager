import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text('Feedback',
            style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Enter your feedback',
                hintStyle: TextStyle(
                    color: Colors.grey.shade800, fontFamily: 'ProductSans'),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                // Submit feedback logic
              },
              child: Text('Submit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.white,
                      fontFamily: 'ProductSans')),
            ),
          ],
        ),
      ),
    );
  }
}
