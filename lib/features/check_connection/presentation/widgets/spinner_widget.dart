import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
