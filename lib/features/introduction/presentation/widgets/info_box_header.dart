import 'package:flutter/material.dart';

class InfoBoxHeader extends StatelessWidget {
  final Icon icon;
  final String label;
  const InfoBoxHeader({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 103, 103),
                shape: BoxShape.circle),
            child: icon),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
