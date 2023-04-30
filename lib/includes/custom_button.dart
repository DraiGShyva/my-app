import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String name;
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color colorButton;
  final Color colorText;
  final Color colorIcon;
  final double radius;
  const CustomButton({
    super.key,
    this.name = '',
    required this.onPressed,
    this.text = '',
    this.icon,
    this.colorButton = Colors.blue,
    this.radius = 10.0,
    this.colorText = Colors.white,
    this.colorIcon = Colors.white,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Container()),
            Text(widget.text),
            InkWell(
                borderRadius: BorderRadius.circular(widget.radius),
                onTap: widget.onPressed,
                child: Ink(
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: widget.colorButton)],
                        borderRadius: BorderRadius.circular(widget.radius)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 13.0, top: 7.0, bottom: 7.0),
                      child: widget.name != ''
                          ? widget.icon != null
                              ? Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(color: widget.colorText),
                                    ),
                                    Icon(
                                      widget.icon,
                                      color: widget.colorIcon,
                                    )
                                  ],
                                )
                              : Text(
                                  widget.name,
                                  style: TextStyle(color: widget.colorText),
                                )
                          : Icon(
                              widget.icon,
                              color: widget.colorIcon,
                            ),
                    ))),
            Expanded(child: Container()),
          ],
        ));
  }
}
