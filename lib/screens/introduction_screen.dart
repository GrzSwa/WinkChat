import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wink_chat/features/introduction/presentation/views/get_started_view.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/presentation/views/regulation_and_privacy_policy_view.dart';
import 'package:wink_chat/shared/domain/cubit/stepper/stepper_cubit.dart';
import 'package:wink_chat/shared/widgets/images/app_logo.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    return BlocProvider(
      create: (_) => StepperCubit(),
      child: Scaffold(
          appBar: AppBar(title: const Center(child: AppLogo())),
          body: BlocConsumer<StepperCubit, StepperState>(
            listener: (context, state) {
              _controller.jumpToPage(state.currentStep);
            },
            builder: (context, state) {
              final stepperCubit = context.read<StepperCubit>();
              return Stack(
                children: [
                  PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GetStartedView(
                        onPressed: () => stepperCubit.next(),
                      ),
                      RegulationAndPrivacyPolicyView(
                        actions: {
                          "accept": () => {stepperCubit.next()},
                          "decline": () => {stepperCubit.cancel()}
                        },
                      ),
                      Container(
                        color: Colors.greenAccent,
                      ),
                      Container(
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                  state.currentStep > 0
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 20),
                          child: AnimatedSmoothIndicator(
                            activeIndex: state.currentStep - 1,
                            count: 3,
                          ),
                        )
                      : Container()
                ],
              );
            },
          )),
    );
  }
}
