import 'package:app/includes/custom_page.dart';
import 'package:flutter/material.dart';

import '../data/text_field_controller.dart';
import '../includes/custom_button.dart';
import '../includes/custom_text_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(widgets: [
      CustomTextField(
          labelText: 'Username',
          hintText: 'Enter username',
          controller: usernameController),
      CustomTextField(
        labelText: 'Password',
        hintText: 'Enter password',
        controller: passwordController,
        isPassword: true,
      ),
      CustomButton(name: 'Login', onPressed: () {}),
      CustomButton(
          text: 'Do not have an account? ',
          name: 'Register now',
          colorText: Colors.blue,
          colorButton: Colors.transparent,
          onPressed: () {}),
      CustomButton(
          text: 'Forgot password? ',
          name: 'Click here',
          colorText: Colors.blue,
          colorButton: Colors.transparent,
          onPressed: () {})
    ]);
  }
}
