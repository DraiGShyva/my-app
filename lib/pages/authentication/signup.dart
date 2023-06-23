import 'package:flutter/material.dart';

import 'package:app/models/authentication/custom_text_field.dart';
import 'package:app/models/authentication/custom_button.dart';
import 'package:app/models/authentication/text_field_controller.dart';

import '/data/account_data.dart';

import 'signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

    registerButton() {
      setState(() {
        emailNotify = Controller.email.text.isEmpty;
        usernameNotify = Controller.username.text.isEmpty;
        passwordNotify = Controller.password.text.isEmpty;
        cofirmPasswordNotify = Controller.confirmPassword.text.isEmpty;
      });
      if (Authen.account.containsValue(Controller.email.text) &&
          Authen.account.containsValue(Controller.email.text)) {
        if (Controller.password.text == Controller.confirmPassword.text &&
            Controller.password.text.isNotEmpty) {
          Authen.createAccount({
            'email': Controller.email.text,
            'username': Controller.username.text,
            'password': Controller.password.text,
          });
          routeSignIn();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or username already exist!'),
          ),
        );
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
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter password',
              controller: Controller.password,
              isPassword: true,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Visibility(
                    visible: passwordNotify,
                    child: const Text('The password is not empty!')),
              ],
            ),
            CustomTextField(
              labelText: 'Confirm password',
              hintText: 'Enter the password again',
              controller: Controller.confirmPassword,
              isPassword: true,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Visibility(
                    visible: cofirmPasswordNotify,
                    child: const Text('The confirm password is not empty!')),
                Visibility(
                    visible: (Controller.password.text !=
                            Controller.confirmPassword.text &&
                        Controller.confirmPassword.text.isNotEmpty),
                    child: const Text('Confirm password does not match!'))
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: CustomButton(
            name: 'Register', center: true, onPressed: registerButton),
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
