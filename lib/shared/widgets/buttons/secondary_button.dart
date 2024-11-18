import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const SecondaryButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: WidgetStateProperty.all<Size>(const Size(200, 45)),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Color.fromARGB(255, 255, 103, 103)),
            ))),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 103, 103),
              fontWeight: FontWeight.normal,
              fontSize: 14),
        ));
  }
}
