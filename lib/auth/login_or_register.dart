import 'package:flutter/material.dart';
import 'package:voyager/pages/login_page.dart';
import '../pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  final bool noReg;

  const LoginOrRegister({Key? key, this.noReg = false}) : super(key: key);

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
    if (!widget.noReg) {
      return LoginPage(onTap: toggleView);
    }
    if (showLogin) {
      return LoginPage(onTap: toggleView);
    } else {
      return RegisterPage(onTap: toggleView);
    }
  }
}
