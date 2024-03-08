import 'package:flutter/material.dart';
import 'package:group9_auth/pages/login_page.dart';
import 'package:group9_auth/utils/constants.dart';

import '../pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  final bool Noreg;
  const LoginOrRegister({Key? key, this.Noreg = false}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show the login page
  bool showLogin = true;

  // toggle between login and register page
  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.Noreg){
      return LoginPage(onTap: toggleView);
    }
    if (showLogin) {
      return LoginPage(onTap: toggleView);
    } else {
      return RegisterPage(onTap: toggleView);
    }
  }
}
