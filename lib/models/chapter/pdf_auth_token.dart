// To parse this JSON data, do
//
//     final pdfAuthToken = pdfAuthTokenFromJson(jsonString);

import 'dart:convert';

PdfAuthToken pdfAuthTokenFromJson(str) => PdfAuthToken.fromJson(str);

String pdfAuthTokenToJson(PdfAuthToken data) => json.encode(data.toJson());

class PdfAuthToken {
  String? status;
  Data? data;

  PdfAuthToken({
    this.status,
    this.data,
  });

  factory PdfAuthToken.fromJson(Map<String, dynamic> json) => PdfAuthToken(
        status: json['status'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

class Data {
  String? token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
