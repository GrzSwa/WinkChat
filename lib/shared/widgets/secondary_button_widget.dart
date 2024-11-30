import 'package:flutter/material.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const SecondaryButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
