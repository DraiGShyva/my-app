import 'package:app/pages/signup.dart';
import 'package:flutter/material.dart';
import '/data/text_field_controller.dart';
import '/includes/custom_button.dart';
import '/includes/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                                (route) => false);
                          }),
                      CustomButton(
                          text: 'Forgot password? ',
                          name: 'Click here',
                          colorText: Colors.blue,
                          colorButton: Colors.transparent,
                          onPressed: () {})
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
