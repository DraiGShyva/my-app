import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color colorButton;
  final Color color;
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
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double widgetSize = screenSize.width < screenSize.height
        ? screenSize.width
        : screenSize.height / 2;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: Row(
        children: [
          Visibility(visible: center, child: Expanded(child: Container())),
          Visibility(
              visible: text != '',
              child: Text(text, style: TextStyle(fontSize: widgetSize * 0.04))),
          InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: onPressed,
              child: Ink(
                  decoration: BoxDecoration(
                      color: colorButton,
                      borderRadius: BorderRadius.circular(radius)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 13.0, top: 7.0, bottom: 7.0),
                    child: Text(
                      name,
                      style:
                          TextStyle(color: color, fontSize: widgetSize * 0.04),
                    ),
                  ))),
          Visibility(visible: center, child: Expanded(child: Container())),
        ],
      ),
    );
  }
}
