import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  CarouselSliderController stepperController;
  int _step = 0;

  StepperCubit(this.stepperController) : super(StepperInitial());

  void next() {
    stepperController.nextPage();
    _step++;
    emit(StepperUpdated(_step));
  }

  void cancel() {
    if (_step > 0) {
      stepperController.previousPage();
      _step--;
    } else {
      SystemNavigator.pop();
    }
    emit(StepperUpdated(_step));
  }
}
