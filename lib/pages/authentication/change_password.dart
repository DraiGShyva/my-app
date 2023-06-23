import 'package:flutter/material.dart';

import '/data/account_data.dart';

import 'package:app/models/authentication/custom_text_field.dart';
import 'package:app/models/authentication/custom_button.dart';
import 'package:app/models/authentication/text_field_controller.dart';

import 'signin.dart';

class ChangePasswordPage extends StatefulWidget {
  final String keyAccount;
  const ChangePasswordPage({super.key, required this.keyAccount});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ),
        (route) => false,
      );
    }

    changePassword() {
      Controller.clearController;
      setState(() {
        passwordNotify = Controller.password.text.isEmpty;
        cofirmPasswordNotify = Controller.confirmPassword.text.isEmpty;
      });
      if (Controller.password.text == Controller.confirmPassword.text &&
          Controller.password.text.isNotEmpty) {
        Authen.account[widget.keyAccount]['password'] =
            Controller.password.text;
        Authen.updateAccount();
        routeSignIn();
      }
    }

    return scaffold(
      context,
      [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
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
                    child: const Text('The password is not empty!'),
                  ),
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
                    child: const Text('The confirm password is not empty!'),
                  ),
                  Visibility(
                    visible: (Controller.password.text !=
                            Controller.confirmPassword.text &&
                        Controller.confirmPassword.text.isNotEmpty),
                    child: const Text('Confirm password does not match!'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: CustomButton(
            name: 'Change',
            center: true,
            onPressed: changePassword,
          ),
        ),
        CustomButton(
            text: 'Do you already have an account? ',
            name: 'Sign in',
            center: true,
            color: Colors.white,
            colorButton: Colors.transparent,
            onPressed: routeSignIn),
      ],
    );
  }
}
