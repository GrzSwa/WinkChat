import 'package:flutter/material.dart';

class AvatarsGridList extends StatelessWidget {
  final List<String> avatars;

  const AvatarsGridList({Key? key, required this.avatars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(avatars.length, (index) {
          return Center(
            child: Image.asset(avatars[index]),
          );
        }));
  }
}
