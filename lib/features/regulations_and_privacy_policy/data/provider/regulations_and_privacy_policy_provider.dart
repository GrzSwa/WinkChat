import 'package:flutter/services.dart' show rootBundle;

class RegulationsAndPrivacyPolicyProvider {
  final String _path = 'assets/data/regulations_and_privacy_policy.json';
  RegulationsAndPrivacyPolicyProvider();

  Future<dynamic> fetchData() async {
    final response = await rootBundle.loadString(_path);

    return response;
  }
}
