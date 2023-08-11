// To parse this JSON data, do
//
//     final subjectNameModel = subjectNameModelFromJson(jsonString);

import 'dart:convert';

List<SubjectNameModel> subjectNameModelFromJson(str) => List<SubjectNameModel>.from(str.map(
      (x) => SubjectNameModel.fromJson(x),
    ));

String subjectNameModelToJson(List<SubjectNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectNameModel {
  String? id;
  String? name;
  String? subjectNameModelId;
  int? orderNumber;
  String? bookId;
  String? bookName;

  SubjectNameModel({
    this.id,
    this.name,
    this.subjectNameModelId,
    this.orderNumber,
    this.bookId,
    this.bookName,
  });

  factory SubjectNameModel.fromJson(Map<String, dynamic> json) => SubjectNameModel(
        id: json['_id'],
        name: json['name'],
        subjectNameModelId: json['id'],
        orderNumber: json['orderNumber'],
        bookId: json['bookId'],
        bookName: json['bookName'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'id': subjectNameModelId,
        'orderNumber': orderNumber,
        'bookId': bookId,
        'bookName': bookName,
      };
}
