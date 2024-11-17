import 'package:equatable/equatable.dart';

class RegulationsAndPrivacyPolicyModel extends Equatable {
  final String title;
  final String describe;

  RegulationsAndPrivacyPolicyModel(
      {required this.title, required this.describe});

  factory RegulationsAndPrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return RegulationsAndPrivacyPolicyModel(
      title: json['title'],
      describe: json['describe'],
    );
  }

  @override
  List<Object?> get props => [title, describe];
}
