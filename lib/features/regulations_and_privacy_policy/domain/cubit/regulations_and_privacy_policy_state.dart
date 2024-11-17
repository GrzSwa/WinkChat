part of 'regulations_and_privacy_policy_cubit.dart';

abstract class RegulationsAndPrivacyPolicyState extends Equatable {
  const RegulationsAndPrivacyPolicyState();

  @override
  List<Object?> get props => [];
}

class RegulationsAndPrivacyPolicyInitial
    extends RegulationsAndPrivacyPolicyState {
  @override
  List<Object?> get props => [];
}

class RegulationsAndPrivacyPolicyLoading
    extends RegulationsAndPrivacyPolicyState {
  @override
  List<Object?> get props => [];
}

class RegulationsAndPrivacyPolicyLoaded
    extends RegulationsAndPrivacyPolicyState {
  final List<RegulationsAndPrivacyPolicyModel> data;

  RegulationsAndPrivacyPolicyLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class RegulationsAndPrivacyPolicyError
    extends RegulationsAndPrivacyPolicyState {
  @override
  List<Object?> get props => [];
}
