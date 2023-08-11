import 'dart:convert';

HelpPageContactModal helpPageContactModalFromJson(String str) => HelpPageContactModal.fromJson(json.decode(str));

String helpPageContactModalToJson(HelpPageContactModal data) => json.encode(data.toJson());

class HelpPageContactModal {
  HelpPageContactModal({
    this.executiveName,
    this.executiveEmail,
    this.executiveContact,
  });

  String? executiveName;
  String? executiveEmail;
  String? executiveContact;

  factory HelpPageContactModal.fromJson(Map<String, dynamic>? json) => HelpPageContactModal(
        executiveName: json?['supportPersonName'],
        executiveEmail: json?['supportPersonEmail'],
        executiveContact: json?['supportPersonContact'],
      );

  Map<String, dynamic> toJson() => {
        'supportPersonName': executiveName,
        'supportPersonEmail': executiveEmail,
        'supportPersonContact': executiveContact,
      };
}
