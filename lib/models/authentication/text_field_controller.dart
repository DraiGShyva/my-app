import 'package:flutter/material.dart';

class Controller {
  static TextEditingController email = TextEditingController();
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController confirmPassword = TextEditingController();

  static void clearController() {
    email.clear();
    username.clear();
    password.clear();
    confirmPassword.clear();
  }
}
