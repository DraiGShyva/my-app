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
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover)),
        ),
        Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const FlutterLogo(size: 100),
                  const SizedBox(height: 100),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
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
                          CustomButton(name: 'Login', onPressed: () {}),
                          CustomButton(
                              text: 'Do not have an account? ',
                              name: 'Register now',
                              colorText: Colors.blue,
                              colorButton: Colors.transparent,
                              onPressed: () {})
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
