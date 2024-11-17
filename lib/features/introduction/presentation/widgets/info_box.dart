import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final Widget header;
  final String describe;
  const InfoBox({Key? key, required this.header, required this.describe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        const SizedBox(height: 10),
        Text(
          describe,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
