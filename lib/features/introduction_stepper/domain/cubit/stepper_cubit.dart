import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  final CarouselSliderController _stepperController;
  int step = 0;

  StepperCubit(this._stepperController)
      : super(StepperInitial(_stepperController));

  void next() {
    _stepperController.nextPage();
    step++;
  }

  void cancel() {
    if (step > 0) {
      _stepperController.previousPage();
      step--;
    } else {
      SystemNavigator.pop();
    }
  }
}
