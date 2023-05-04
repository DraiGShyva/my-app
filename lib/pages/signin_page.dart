import 'package:flutter/material.dart';

import '../data/text_field_controller.dart';
import '../includes/custom_button.dart';
import '../includes/custom_text_field.dart';
import 'home_page.dart';
import 'signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                const FlutterLogo(size: 100),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(219, 255, 236, 179),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            children: [
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
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: CustomButton(
                              name: 'Login',
                              center: true,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (route) => false);
                              }),
                        ),
                        CustomButton(
                            text: 'Do not have an account? ',
                            name: 'Register now',
                            center: true,
                            color: Colors.blue,
                            colorButton: Colors.transparent,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()),
                                  (route) => false);
                            }),
                        CustomButton(
                            text: 'Forgot password? ',
                            name: 'Click here',
                            center: true,
                            color: Colors.blue,
                            colorButton: Colors.transparent,
                            onPressed: () {}),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
