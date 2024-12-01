import 'package:flutter/material.dart';

class TwoImagesWidget extends StatelessWidget {
  const TwoImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double _width = constraints.maxWidth;
        return Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Image.asset(
                "assets/images/avatar_2.png",
                width: _width / 2,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Image.asset("assets/images/avatar_3.png"),
              width: _width / 2,
            ),
          ],
        );
      },
    );
  }
}
