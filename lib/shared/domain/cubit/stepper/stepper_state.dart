part of 'stepper_cubit.dart';

sealed class StepperState extends Equatable {
  final int currentStep;

  const StepperState(this.currentStep);

  @override
  List<Object> get props => [];
}

final class StepperInitial extends StepperState {
  const StepperInitial() : super(0);
}

final class StepperNext extends StepperState {
  const StepperNext(super.step);
}

final class StepperPrevious extends StepperState {
  const StepperPrevious(super.step);
}

final class StepperCancel extends StepperState {
  const StepperCancel() : super(0);
}

final class StepperComplete extends StepperState {
  const StepperComplete() : super(3);
}
