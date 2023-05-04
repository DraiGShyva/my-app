import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: Row(
        children: [
          Visibility(
              visible: widget.center, child: Expanded(child: Container())),
          Visibility(
              visible: widget.text != '',
              child:
                  Text(widget.text, style: TextStyle(fontSize: widget.size))),
          InkWell(
              borderRadius: BorderRadius.circular(widget.radius),
              onTap: widget.onPressed,
              child: Ink(
                decoration: BoxDecoration(
                    color: widget.colorButton,
                    borderRadius: BorderRadius.circular(widget.radius)),
                child: widget.name != ''
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, right: 13.0, top: 7.0, bottom: 7.0),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: widget.color, fontSize: widget.size),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          widget.icon,
                          color: widget.color,
                          size: widget.size + 10,
                        ),
                      ),
              )),
          Visibility(
              visible: widget.center, child: Expanded(child: Container())),
        ],
      ),
    );
  }
}
