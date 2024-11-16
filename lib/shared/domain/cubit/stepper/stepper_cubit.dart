import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit() : super(const StepperInitial());

  void next() {
    if (state.currentStep < 3) {
      print("NEXT: ${state.currentStep}");
      emit(StepperNext(state.currentStep + 1));
    } else {
      print(state.currentStep);
      emit(const StepperComplete());
    }
  }

  void previous() {
    print("PREVIOUS: ${state.currentStep}");
    if (state.currentStep > 0) {
      emit(StepperPrevious(state.currentStep - 1));
    }
  }

  void cancel() {
    print("CANCEL: ${state.currentStep}");
    emit(const StepperCancel());
  }
}
