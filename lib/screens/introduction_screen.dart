import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/features/introduction_stepper/introduction_stepper.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/regulations_and_privacy_policy.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color(0xff161616),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<StepperCubit>(
                create: (context) => StepperCubit(CarouselSliderController()),
              ),
              BlocProvider<RAPPCubit>(
                create: (context) => RAPPCubit(
                  RegulationsAndPrivacyPolicyRepository(
                      GetRegulationsAndPrivacyPolicy()),
                ),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: IntroductionStepperView(children: [
                AppInfoView(),
                RegulationsAndPrivacyPolicyView(),
                UsernameView()
              ]),
            )));
  }
}
