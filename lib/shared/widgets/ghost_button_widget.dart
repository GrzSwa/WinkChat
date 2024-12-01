import 'package:flutter/material.dart';

class GhostButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const GhostButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Color(0xffde676c)),
      ),
    );
  }
}
