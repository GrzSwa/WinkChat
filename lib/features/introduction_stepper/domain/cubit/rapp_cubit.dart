import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wink_chat/features/introduction_stepper/data/repository/regulations_and_privacy_policy_repository.dart';

import '../../data/models/regulations_and_privacy_policy_model.dart';

part 'rapp_state.dart';

class RAPPCubit extends Cubit<RAPPState> {
  final RegulationsAndPrivacyPolicyRepository
      _regulationsAndPrivacyPolicyRepository;
  RAPPCubit(this._regulationsAndPrivacyPolicyRepository)
      : super(RAPPLoading()) {
    _getRAPP();
  }

  Future<void> _getRAPP() async {
    emit(RAPPLoading());
    try {
      final data = await _regulationsAndPrivacyPolicyRepository
          .getRegulationsAndPrivacyPolicy();
      emit(RAPPLoaded(data));
    } catch (e) {
      emit(RAPPError());
      print(e);
    }
  }
}
