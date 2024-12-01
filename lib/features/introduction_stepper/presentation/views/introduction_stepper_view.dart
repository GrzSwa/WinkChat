import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

import '../../domain/cubit/stepper_cubit.dart';

class IntroductionStepperView extends StatelessWidget {
  final List<Widget> children;
  const IntroductionStepperView({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              flex: 3,
              child: CarouselSlider(
                items: children,
                carouselController: state.stepperController,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    viewportFraction: 1.0,
                    height: double.infinity),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff161616),
                border: Border.all(color: Colors.transparent),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GhostButtonWidget(
                      text: "Anuluj",
                      onPressed: () => context.read<StepperCubit>().cancel()),
                  PrimaryButtonWidget(
                      text: "Zatwierdź",
                      onPressed: () => context.read<StepperCubit>().next()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
