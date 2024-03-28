import 'package:chat_application/screens/login_screen.dart';
import 'package:chat_application/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginScreen = true;
  // toggle between login or register
  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginSreen(
        onTap: togglePages,
      );
    } else {
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}
