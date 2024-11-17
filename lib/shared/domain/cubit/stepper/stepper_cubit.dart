import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit() : super(const StepperInitial());

  void next() {
    if (state.currentStep < 3) {
      emit(StepperNext(state.currentStep + 1));
    } else {
      emit(const StepperComplete());
    }
  }

  void previous() {
    if (state.currentStep > 0) {
      emit(StepperPrevious(state.currentStep - 1));
    }
  }

  void cancel() {
    emit(const StepperCancel());
  }
}
