import 'package:equatable/equatable.dart';

class RegulationsAndPrivacyPolicyModel extends Equatable {
  final String htmlBody;

  const RegulationsAndPrivacyPolicyModel({required this.htmlBody});

  factory RegulationsAndPrivacyPolicyModel.fromHtml(String html) {
    return RegulationsAndPrivacyPolicyModel(htmlBody: html);
  }

  @override
  List<Object?> get props => [htmlBody];
}
