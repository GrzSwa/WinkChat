import 'package:equatable/equatable.dart';

class RegulationsAndPrivacyPolicyModel extends Equatable {
  final String body;

  const RegulationsAndPrivacyPolicyModel({required this.body});

  factory RegulationsAndPrivacyPolicyModel.fromHtml(String htmlCode) {
    return RegulationsAndPrivacyPolicyModel(body: htmlCode);
  }

  @override
  List<Object?> get props => [body];
}
