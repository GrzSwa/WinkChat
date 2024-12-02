import 'package:flutter/material.dart';
import 'package:wink_chat/shared/enums/enums.dart';

class TwoImagesWidget extends StatelessWidget {
  final TwoImagePosition positioned;
  final List<String> images;
  const TwoImagesWidget(
      {Key? key,
      required this.images,
      this.positioned = TwoImagePosition.topLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double _width = constraints.maxWidth;
        final positions = _getPositions();
        return Stack(
          children: [
            Positioned(
              top: positions[0]['top'],
              left: positions[0]['left'],
              bottom: positions[0]['bottom'],
              right: positions[0]['right'],
              child: Image.asset(
                images[0],
                width: _width / 2,
              ),
            ),
            Positioned(
              top: positions[1]['top'],
              left: positions[1]['left'],
              bottom: positions[1]['bottom'],
              right: positions[1]['right'],
              child: Image.asset(
                images[1],
                width: _width / 2,
              ),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, double?>> _getPositions() {
    switch (positioned) {
      case TwoImagePosition.topLeft:
        return [
          {'top': 10, 'left': 10, 'bottom': null, 'right': null},
          {'top': null, 'left': null, 'bottom': 10, 'right': 10},
        ];
      case TwoImagePosition.topRight:
        return [
          {'top': 10, 'left': null, 'bottom': null, 'right': 10},
          {'top': null, 'left': 10, 'bottom': 10, 'right': null},
        ];
      case TwoImagePosition.left:
        return [
          {'top': 10, 'left': 10, 'bottom': null, 'right': null},
          {'top': null, 'left': 10, 'bottom': 10, 'right': null},
        ];
      case TwoImagePosition.right:
        return [
          {'top': 10, 'left': null, 'bottom': null, 'right': 10},
          {'top': null, 'left': null, 'bottom': 10, 'right': 10},
        ];
      case TwoImagePosition.top:
        return [
          {'top': 10, 'left': 10, 'bottom': null, 'right': null},
          {'top': 10, 'left': null, 'bottom': null, 'right': 10},
        ];
      case TwoImagePosition.bottom:
        return [
          {'top': null, 'left': 10, 'bottom': 10, 'right': null},
          {'top': null, 'left': null, 'bottom': 10, 'right': 10},
        ];
      default:
        return [
          {'top': 10, 'left': 10, 'bottom': null, 'right': null},
          {'top': null, 'left': null, 'bottom': 10, 'right': 10},
        ];
    }
  }
}
