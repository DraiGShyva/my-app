import 'package:flutter/material.dart';

import '/data/account_data.dart';

import 'package:app/models/authentication/custom_text_field.dart';
import 'package:app/models/authentication/custom_button.dart';
import 'package:app/models/authentication/text_field_controller.dart';

import 'forgot_password.dart';
import 'signup.dart';
import '../home.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool usernameNotify = false;
  bool passwordNotify = false;

  @override
  void initState() {
    super.initState();
    Authen.getAccount();
  }

  @override
  Widget build(BuildContext context) {
    loginButton() {
      Authen.getAccount();
      setState(() {
        usernameNotify = Controller.username.text.isEmpty;
        passwordNotify = Controller.password.text.isEmpty;
      });
      if (!(usernameNotify && passwordNotify)) {
        for (final key in Authen.account.keys) {
          if (Authen.account[key]['username'] == Controller.username.text &&
              Authen.account[key]['password'] == Controller.password.text) {
            Controller.clearController();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
            break;
          } else if (key == Authen.account.keys.last) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Username or password are incorrect!'),
              ),
            );
          }
        }
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
                    visible: Controller.password.text !=
                            Authen.account['password'] &&
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
    ]);
  }
}

scaffold(context, List<Widget> widgets) {
  final Size screenSize = MediaQuery.of(context).size;
  final double widgetSize = screenSize.width < screenSize.height
      ? screenSize.width
      : screenSize.height;
  return Scaffold(
    body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      ),
      Material(
        color: Colors.transparent,
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.only(
                  left: widgetSize * 0.05, right: widgetSize * 0.05),
              child: Ink(
                padding: EdgeInsets.only(
                    top: widgetSize * 0.1, bottom: widgetSize * 0.02),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(132, 9, 95, 255),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.blue)),
                child: Column(
                  children: widgets,
                ),
              ),
            ),
          ]),
        ),
      ),
    ]),
  );
}
