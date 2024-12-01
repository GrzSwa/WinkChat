import '../data_source/get_regulations_and_privacy_policy.dart';
import '../models/regulations_and_privacy_policy_model.dart';

class RegulationsAndPrivacyPolicyRepository {
  final GetRegulationsAndPrivacyPolicy _getRegulationsAndPrivacyPolicy;

  RegulationsAndPrivacyPolicyRepository(this._getRegulationsAndPrivacyPolicy);

  Future<RegulationsAndPrivacyPolicyModel>
      getRegulationsAndPrivacyPolicy() async {
    final data = await _getRegulationsAndPrivacyPolicy
        .fetchRegulationsAndPrivacyPolicy();

    if (data.isNotEmpty) {
      print(data);
      return RegulationsAndPrivacyPolicyModel.fromHtml(data);
    } else {
      throw Exception('Failed to load regulations and privacy policy');
    }
  }
}
