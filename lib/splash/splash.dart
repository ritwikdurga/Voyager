// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/login_section/intro_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

import '../auth/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _navigateToMainPage();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  _navigateToMainPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    await Future.delayed(Duration(milliseconds: 3000));
    if (!_isDisposed) {
      if (!_seen) {
        await prefs.setBool('seen', true);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => IntroPage()),
          );
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      isRegistered: false,
                    )),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: Transform.scale(
        scale: 0.5,
        child: Center(
          // Set background color of the container
          child: Lottie.network(
            "https://lottie.host/d86d8b06-bb7f-438d-9613-0d0b6673fce0/jYPAfJIAKk.json",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
