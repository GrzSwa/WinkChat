import 'dart:convert';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/models/regulations_and_privacy_policy_model.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/provider/regulations_and_privacy_policy_provider.dart';

class RegulationsAndPrivacyPolicyRepository {
  final RegulationsAndPrivacyPolicyProvider
      _regulationsAndPrivacyPolicyProvider;

  RegulationsAndPrivacyPolicyRepository(
      this._regulationsAndPrivacyPolicyProvider);

  Future<List<RegulationsAndPrivacyPolicyModel>>
      loadRegulationsAndPrivacyPolicy() async {
    final response = await _regulationsAndPrivacyPolicyProvider.fetchData();
    final data = json.decode(response) as List;

    return data
        .map((item) => RegulationsAndPrivacyPolicyModel.fromJson(item))
        .toList();
  }
}
