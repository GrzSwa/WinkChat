part of 'stepper_cubit.dart';

sealed class StepperState extends Equatable {
  final CarouselSliderController stepperController;
  const StepperState(this.stepperController);

  @override
  List<Object> get props => [stepperController];
}

final class StepperInitial extends StepperState {
  const StepperInitial(CarouselSliderController stepperController)
      : super(stepperController);
}
