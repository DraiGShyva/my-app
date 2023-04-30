import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String labelText;
  final String hintText;
  final double radius;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      this.isPassword = false,
      this.labelText = '',
      required this.controller,
      this.hintText = '',
      this.radius = 10.0});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool _isObscure = true;
IconData _off = Icons.visibility_off;
IconData _on = Icons.visibility;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                )
              ]),
          child: widget.isPassword == true
              ? TextField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(widget.radius))),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => _isObscure = !_isObscure);
                          },
                          icon: Icon(_isObscure == true ? _off : _on))),
                  controller: widget.controller,
                )
              : TextField(
                  decoration: InputDecoration(
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.radius)))),
                  controller: widget.controller,
                )),
    );
  }
}
