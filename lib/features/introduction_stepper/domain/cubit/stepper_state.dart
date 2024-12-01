part of 'stepper_cubit.dart';

sealed class StepperState extends Equatable {
  const StepperState();

  @override
  List<Object> get props => [];
}

final class StepperInitial extends StepperState {}
