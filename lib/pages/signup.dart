import 'package:flutter/material.dart';

import '../data/text_field_controller.dart';
import '../includes/custom_button.dart';
import '../includes/custom_text_field.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover)),
          child: Material(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const FlutterLogo(size: 100),
                      const SizedBox(height: 100),
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
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                                (route) => false);
                          })
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
