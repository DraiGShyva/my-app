import 'package:flutter/material.dart';

import '../data/account_data.dart';
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
  bool usernameNotify = false;
  bool passwordNotify = false;
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
                                controller: Controller.username,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 10, height: 10),
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
                                  const SizedBox(width: 10, height: 10),
                                  Visibility(
                                      visible: passwordNotify,
                                      child: const Text(
                                          'The password is not empty!')),
                                  Visibility(
                                      visible: Controller.password.text !=
                                              Authen.password &&
                                          Controller
                                              .confirmPassword.text.isNotEmpty,
                                      child: const Text(
                                          'Password does not match!'))
                                ],
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
                                setState(() {
                                  usernameNotify =
                                      Controller.username.text.isEmpty;
                                  passwordNotify =
                                      Controller.password.text.isEmpty;
                                });
                                if (Authen.username ==
                                        Controller.username.text &&
                                    Authen.password ==
                                        Controller.password.text) {
                                  Controller.clearController;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                      (route) => false);
                                }
                              }),
                        ),
                        CustomButton(
                            text: 'Do not have an account? ',
                            name: 'Register now',
                            center: true,
                            color: Colors.blue,
                            colorButton: Colors.transparent,
                            onPressed: () {
                              Controller.clearController();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupPage()));
                            }),
                        CustomButton(
                            text: 'Forgot password? ',
                            name: 'Click here',
                            center: true,
                            color: Colors.blue,
                            colorButton: Colors.transparent,
                            onPressed: () {
                              Controller.clearController();
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
