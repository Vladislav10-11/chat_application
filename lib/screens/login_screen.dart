import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/components/my_button.dart';
import 'package:chat_application/components/my_textfiled.dart';
import 'package:chat_application/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  LoginSreen({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    // auth service

    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    }

    // catch any errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.token_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            // welcome back message
            Text("Welcome back!".toUpperCase(), style: AppFonts.textInterface),
            const SizedBox(
              height: 25,
            ),
            // email textfiled
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            // pw textfield
            MyTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            // login button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 20,
            ),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a remember?", style: AppFonts.textMessages),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
                      style: GoogleFonts.spaceMono(
                        color: Color(0xffD627C4),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
