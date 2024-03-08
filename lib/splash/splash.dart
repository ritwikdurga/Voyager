import 'package:flutter/material.dart';
import 'package:group9_auth/pages/intro_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if(!_seen){
        await prefs.setBool('seen', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroPage()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash.json',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
