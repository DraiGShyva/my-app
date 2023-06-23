import 'package:flutter/material.dart';

import '/data/account_data.dart';

import 'package:app/models/authentication/custom_text_field.dart';
import 'package:app/models/authentication/custom_button.dart';
import 'package:app/models/authentication/text_field_controller.dart';

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
      });
      for (final key in Authen.account.keys) {
        if (Controller.email.text == Authen.account[key]['email']) {
          Controller.clearController;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(keyAccount: key)));
          break;
        } else if (key == Authen.account.keys.last) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email are incorrect!'),
            ),
          );
        }
      }
    }

    return scaffold(context, [
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
    ]);
  }
}
