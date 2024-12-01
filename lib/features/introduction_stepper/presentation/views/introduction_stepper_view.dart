import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/features/introduction_stepper/presentation/widgets/stepper_action_widget.dart';

import '../../domain/cubit/stepper_cubit.dart';

class IntroductionStepperView extends StatelessWidget {
  final List<Widget> children;
  const IntroductionStepperView({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        final _stepperCubit = context.read<StepperCubit>();
        int _currentStep = 0;
        if (state is StepperUpdated) {
          _currentStep = state.step;
        }
        return Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: children,
                carouselController: _stepperCubit.stepperController,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    viewportFraction: 1.0,
                    height: double.infinity),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: const Color(0xff161616),
                border: Border.all(color: Colors.transparent),
              ),
              child: StepperActionWidget(
                stepperController: _stepperCubit,
                currentStep: _currentStep,
              ),
            ),
          ],
        );
      },
    );
  }
}
