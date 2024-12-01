part of 'stepper_cubit.dart';

sealed class StepperState extends Equatable {
  const StepperState();

  @override
  List<Object> get props => [];
}

final class StepperInitial extends StepperState {
  const StepperInitial() : super();
}

final class StepperUpdated extends StepperState {
  final int step;
  const StepperUpdated(this.step) : super();

  @override
  List<Object> get props => [step];
}
