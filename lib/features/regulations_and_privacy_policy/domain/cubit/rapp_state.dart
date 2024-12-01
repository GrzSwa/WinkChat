part of 'rapp_cubit.dart';

sealed class RAPPState extends Equatable {
  const RAPPState();

  @override
  List<Object> get props => [];
}

final class RAPPLoading extends RAPPState {}

final class RAPPLoaded extends RAPPState {
  final RegulationsAndPrivacyPolicyModel html;

  RAPPLoaded(this.html);

  @override
  List<Object> get props => [html];
}

final class RAPPError extends RAPPState {}
