// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _controller = TextEditingController();

  Future<void> send(String query) async {
    final Email email = Email(
      body: query,
      subject: 'Feedback',
      recipients: ["explorewithvoyager@gmail.com"],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Submitted Successfully',
          textAlign: TextAlign.center,
          style:TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

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
              controller: _controller,
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
                    color: Colors.grey.shade800,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.w400),
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
                String text = _controller.text;
                send(text);
                FocusManager.instance.primaryFocus?.unfocus();
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
