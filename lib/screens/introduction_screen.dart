import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/features/introduction_stepper/introduction_stepper.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/regulations_and_privacy_policy.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MultiBlocProvider(
            providers: [
          BlocProvider<StepperCubit>(
            create: (context) => StepperCubit(),
          ),
          BlocProvider<RAPPCubit>(
            create: (context) => RAPPCubit(
                RegulationsAndPrivacyPolicyRepository(
                    GetRegulationsAndPrivacyPolicy())),
          ),
        ],
            child: const IntroductionStepperView(children: [
              RegulationsAndPrivacyPolicyView(),
              Center(child: Text("dane2")),
            ])));
  }
}
