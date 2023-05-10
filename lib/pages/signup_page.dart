import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../data/text_field_controller.dart';
import '../includes/custom_button.dart';
import '../includes/custom_text_field.dart';
import 'signin_page.dart';

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
                                labelText: 'Email',
                                hintText: 'Enter email',
                                controller: Controller.email,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Visibility(
                                      visible: emailNotify,
                                      child: const Text(
                                          'The email is not empty!')),
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
                                      child: const Text(
                                          'The username is not empty!')),
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
                                      child: const Text(
                                          'The password is not empty!')),
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
                                      child: const Text(
                                          'The confirm password is not empty!')),
                                  Visibility(
                                      visible: (Controller.password.text !=
                                              Controller.confirmPassword.text &&
                                          Controller
                                              .confirmPassword.text.isNotEmpty),
                                      child: const Text(
                                          'Confirm password does not match!'))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: CustomButton(
                              name: 'Register',
                              center: true,
                              onPressed: () {
                                Controller.clearController;
                                setState(() {
                                  emailNotify = Controller.email.text.isEmpty;
                                  usernameNotify =
                                      Controller.username.text.isEmpty;
                                  passwordNotify =
                                      Controller.password.text.isEmpty;
                                  cofirmPasswordNotify =
                                      Controller.confirmPassword.text.isEmpty;
                                });
                                if (Controller.password.text ==
                                        Controller.confirmPassword.text &&
                                    Controller.password.text.isNotEmpty) {
                                  Authen.username = Controller.username.text;
                                  Authen.password = Controller.password.text;
                                  Controller.clearController;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SigninPage()),
                                      (route) => false);
                                }
                              }),
                        ),
                        CustomButton(
                            text: 'Do you already have an account? ',
                            name: 'Sign in',
                            center: true,
                            color: Colors.blue,
                            colorButton: Colors.transparent,
                            onPressed: () {
                              Controller.clearController();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SigninPage()),
                                  (route) => false);
                            }),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
              ]),
            ),
          )),
    );
  }
}
