
import 'package:flutter/material.dart';

import '/data/account_data.dart';
import '/data/text_field_controller.dart';
import '/includes/custom_button.dart';
import '/includes/custom_text_field.dart';
import 'forgot_password.dart';
import '../home.dart';
import 'signup.dart';

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
    loginButton() {
      setState(() {
        usernameNotify = Controller.username.text.isEmpty;
        passwordNotify = Controller.password.text.isEmpty;
      });
      if (Authen.username == Controller.username.text &&
          Authen.password == Controller.password.text) {
        Controller.clearController();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    }

    routeSignUp() {
      Controller.clearController();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignupPage()));
    }

    routeForgotPassword() {
      Controller.clearController();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
    }

    return scaffold(context, [
      const SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
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
                Visibility(
                    visible: Controller.password.text != Authen.password &&
                        Controller.confirmPassword.text.isNotEmpty,
                    child: const Text('Password does not match!'))
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child:
            CustomButton(name: 'Login', center: true, onPressed: loginButton),
      ),
      CustomButton(
          text: 'Do not have an account? ',
          name: 'Register now',
          center: true,
          color: Colors.white,
          colorButton: Colors.transparent,
          onPressed: routeSignUp),
      CustomButton(
          text: 'Forgot password? ',
          name: 'Click here',
          center: true,
          color: Colors.white,
          colorButton: Colors.transparent,
          onPressed: routeForgotPassword),
      const SizedBox(height: 20.0),
    ]);
  }
}

scaffold(context, List<Widget> widgets) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 176, 231, 255),
    body: SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        const FlutterLogo(size: 100),
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Ink(
            decoration: BoxDecoration(
                color: const Color.fromARGB(204, 0, 89, 255),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blue)),
            child: Column(
              children: widgets,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 5),
      ]),
    ),
  );
}
