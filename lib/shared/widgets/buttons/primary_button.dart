import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Size? size;
  const PrimaryButton(
      {Key? key, required this.label, required this.onPressed, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          minimumSize:
              WidgetStateProperty.all<Size>(size ?? const Size(200, 45)),
          backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 103, 103)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14),
        ));
  }
}
