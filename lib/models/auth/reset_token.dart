class ResetToken {
  ResetToken({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory ResetToken.fromJson(Map<String, dynamic> json) => ResetToken(
        status: json['status'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
      };
}

class Data {
  Data({
    required this.resetToken,
  });

  String resetToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        resetToken: json['resetToken'],
      );

  Map<String, dynamic> toJson() => {
        'resetToken': resetToken,
      };
}
