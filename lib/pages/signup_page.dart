import 'package:flutter/material.dart';

import '../data/text_field_controller.dart';
import '../includes/custom_page.dart';
import '../includes/custom_button.dart';
import '../includes/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(widgets: [
      CustomTextField(
          labelText: 'Email',
          hintText: 'Enter email',
          controller: emailController),
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
      CustomTextField(
        labelText: 'Confirm password',
        hintText: 'Enter the password again',
        controller: checkPassController,
        isPassword: true,
      ),
      CustomButton(name: 'Register', onPressed: () {}),
      CustomButton(
          text: 'Do you already have an account? ',
          name: 'Sign in',
          colorText: Colors.blue,
          colorButton: Colors.transparent,
          onPressed: () {})
    ]);
  }
}
