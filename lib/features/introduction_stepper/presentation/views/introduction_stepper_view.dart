import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroductionStepperView extends StatelessWidget {
  final List<Widget> children;
  const IntroductionStepperView({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: CarouselSlider(
            items: children,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                // scrollPhysics: NeverScrollableScrollPhysics(),
                viewportFraction: 1.0,
                height: double.infinity),
          ),
        ),
        Container(
          color: Colors.green,
          height: 50,
          child: const Text("Przyciski"),
        )
      ],
    );
  }
}
