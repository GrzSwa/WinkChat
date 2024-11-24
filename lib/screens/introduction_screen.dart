import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wink_chat/features/introduction/presentation/views/get_started_view.dart';
import 'package:wink_chat/features/introduction/presentation/views/username_and_sex_view.dart';
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
      child:
          BlocConsumer<StepperCubit, StepperState>(listener: (context, state) {
        _controller.jumpToPage(state.currentStep);
      }, builder: (context, state) {
        final stepperCubit = context.read<StepperCubit>();
        return Scaffold(
            appBar: AppBar(title: const Center(child: AppLogo())),
            bottomNavigationBar: SizedBox(
              height: 60,
              child: Center(
                  child: state.currentStep > 0
                      ? Column(
                          children: [
                            AnimatedSmoothIndicator(
                              activeIndex: state.currentStep - 1,
                              count: 3,
                              effect: const SwapEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor:
                                      Color.fromARGB(255, 255, 103, 103)),
                            ),
                            const SizedBox(height: 15),
                            Text("© 2024 - winkchat.com",
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12))
                          ],
                        )
                      : Container()),
            ),
            body: PageView(
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
                UsernameAndSexView(
                  actions: {
                    "accept": () => {stepperCubit.next()},
                    "decline": () => {stepperCubit.cancel()}
                  },
                ),
                Container(
                  color: Colors.redAccent,
                ),
              ],
            ));
      }),
    );
  }
}
