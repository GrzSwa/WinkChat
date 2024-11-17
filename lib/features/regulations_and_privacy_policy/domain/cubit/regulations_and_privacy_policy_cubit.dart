import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/models/regulations_and_privacy_policy_model.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/repository/regulations_and_privacy_policy_repository.dart';

part 'regulations_and_privacy_policy_state.dart';

class RegulationsAndPrivacyPolicyCubit
    extends Cubit<RegulationsAndPrivacyPolicyState> {
  final RegulationsAndPrivacyPolicyRepository
      _regulationsAndPrivacyPolicyRepository;

  RegulationsAndPrivacyPolicyCubit(this._regulationsAndPrivacyPolicyRepository)
      : super(RegulationsAndPrivacyPolicyInitial());

  Future<void> getParagraphs() async {
    emit(RegulationsAndPrivacyPolicyLoading());
    try {
      final paragraphs = await _regulationsAndPrivacyPolicyRepository
          .loadRegulationsAndPrivacyPolicy();
      emit(RegulationsAndPrivacyPolicyLoaded(paragraphs));
    } catch (e) {
      print("Error loading paragraphs: $e");
      emit(RegulationsAndPrivacyPolicyError());
    }
  }
}
