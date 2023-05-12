import 'package:flutter/material.dart';

import '/data/account_data.dart';
import '/data/text_field_controller.dart';
import '/includes/custom_button.dart';
import '/includes/custom_text_field.dart';
import 'change_password.dart';
import 'signin.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool emailNotify = false;
  bool usernameNotify = false;
  bool passwordNotify = false;
  bool cofirmPasswordNotify = false;

  @override
  Widget build(BuildContext context) {
    routeSignIn() {
      Controller.clearController();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SigninPage()),
          (route) => false);
    }

    confirmButton() {
      Controller.clearController;
      setState(() {
        emailNotify = Controller.email.text.isEmpty;
        usernameNotify = Controller.username.text.isEmpty;
      });
      if (Controller.email.text == Authen.email &&
          Controller.username.text == Authen.username) {
        Controller.clearController;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ChangePasswordPage()));
      }
    }

    return scaffold(context, [
      const SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter email',
              controller: Controller.email,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Visibility(
                    visible: emailNotify,
                    child: const Text('The email is not empty!')),
              ],
            ),
            CustomTextField(
              labelText: 'Username',
              hintText: 'Enter username',
              controller: Controller.username,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Visibility(
                    visible: usernameNotify,
                    child: const Text('The username is not empty!')),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: CustomButton(
            name: 'Confirm', center: true, onPressed: confirmButton),
      ),
      CustomButton(
          text: 'Do you already have an account? ',
          name: 'Sign in',
          center: true,
          color: Colors.white,
          colorButton: Colors.transparent,
          onPressed: routeSignIn),
      const SizedBox(height: 20.0),
    ]);
  }
}
