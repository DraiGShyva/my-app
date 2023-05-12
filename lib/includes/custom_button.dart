import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color colorButton;
  final Color color;
  final double size;
  final double radius;
  final bool center;

  const CustomButton({
    super.key,
    this.name = '',
    required this.onPressed,
    this.text = '',
    this.icon,
    this.colorButton = Colors.blue,
    this.radius = 10.0,
    this.color = Colors.white,
    this.center = false,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: Row(
        children: [
          Visibility(visible: center, child: Expanded(child: Container())),
          Visibility(
              visible: text != '',
              child: Text(text, style: TextStyle(fontSize: size))),
          InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onPressed,
              child: Ink(
                decoration: BoxDecoration(
                    color: colorButton,
                    borderRadius: BorderRadius.circular(radius)),
                child: name != ''
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, right: 13.0, top: 7.0, bottom: 7.0),
                        child: Text(
                          name,
                          style: TextStyle(color: color, fontSize: size),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          icon,
                          color: color,
                          size: size + 10,
                        ),
                      ),
              )),
          Visibility(visible: center, child: Expanded(child: Container())),
        ],
      ),
    );
  }
}
