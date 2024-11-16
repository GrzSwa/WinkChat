import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/shared/domain/cubit/stepper/stepper_cubit.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StepperCubit(),
      child: Scaffold(body: BlocBuilder<StepperCubit, StepperState>(
        builder: (context, state) {
          final stepperCubit = context.read<StepperCubit>();
          return Stepper(
            type: StepperType.horizontal,
            currentStep: state.currentStep,
            onStepCancel: () => stepperCubit.previous(),
            onStepContinue: () => stepperCubit.next(),
            onStepTapped: (step) => {
              step < state.currentStep
                  ? stepperCubit.previous()
                  : stepperCubit.next()
            },
            steps: [
              Step(
                title: const Text('Step 1'),
                content: const Text('This is the first step'),
                isActive: state.currentStep >= 0,
                state: state.currentStep > 0
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: const Text('Step 2'),
                content: const Text('This is the second step'),
                isActive: state.currentStep >= 1,
                state: state.currentStep > 1
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: const Text('Step 3'),
                content: const Text('This is the third step'),
                isActive: state.currentStep >= 2,
                state: state.currentStep > 2
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: const Text('Step 4'),
                content: const Text('This is the four step'),
                isActive: state.currentStep >= 3,
                state: StepState.indexed,
              ),
            ],
          );
        },
      )),
    );
  }
}
