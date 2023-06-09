import 'package:flutter/material.dart';

bool _isObscure = true;
Icon _off = const Icon(Icons.visibility_off);
Icon _on = const Icon(Icons.visibility);

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final String? labelText;
  final double radius;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.radius = 10.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 94, 147, 255),
                    offset: Offset(1.5, 2.5))
              ]),
          child: widget.isPassword == true
              ? TextField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(widget.radius))),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => _isObscure = !_isObscure);
                          },
                          icon: _isObscure == true ? _off : _on)),
                  controller: widget.controller,
                )
              : TextField(
                  decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.radius)))),
                  controller: widget.controller,
                )),
    );
  }
}
