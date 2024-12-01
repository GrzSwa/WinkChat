import 'package:flutter/material.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

import '../../domain/cubit/stepper_cubit.dart';

class StepperActionWidget extends StatelessWidget {
  final StepperCubit stepperController;
  final int currentStep;
  const StepperActionWidget(
      {Key? key, required this.stepperController, required this.currentStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: _actions(context, currentStep, stepperController),
    );
  }
}

Widget _actions(BuildContext context, int step, StepperCubit stepperCubit) {
  if (step == 0) {
    return PrimaryButtonWidget(
      key: ValueKey<int>(step),
      text: "Zaczynajmy",
      onPressed: () => stepperCubit.next(),
    );
  } else if (step == 1) {
    return Row(
      key: ValueKey<int>(step),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GhostButtonWidget(
          text: "Anuluj",
          onPressed: () => stepperCubit.cancel(),
        ),
        PrimaryButtonWidget(
          text: "Akceptuj",
          onPressed: () => stepperCubit.next(),
        ),
      ],
    );
  } else {
    return Row(
      key: ValueKey<int>(step),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GhostButtonWidget(
          text: "Anuluj",
          onPressed: () => stepperCubit.cancel(),
        ),
        PrimaryButtonWidget(
          text: "Dalej",
          onPressed: () => stepperCubit.next(),
        ),
      ],
    );
  }
}
