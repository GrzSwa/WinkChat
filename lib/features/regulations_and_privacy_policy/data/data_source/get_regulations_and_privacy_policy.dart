import 'package:flutter/services.dart' show rootBundle;

class GetRegulationsAndPrivacyPolicy {
  Future<dynamic> fetchRegulationsAndPrivacyPolicy() async {
    try {
      final String response = await rootBundle
          .loadString('assets/data/regulations_and_privacy_policy.html');
      return response;
    } catch (e) {
      print("error: $e");
    }
  }
}
