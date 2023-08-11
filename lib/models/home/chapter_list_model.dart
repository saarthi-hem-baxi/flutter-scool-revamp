// To parse this JSON data, do
//
//     final chapterListModel = chapterListModelFromJson(jsonString);

import 'dart:convert';

List<ChapterNameListModel> chapterListModelFromJson(str) =>
    List<ChapterNameListModel>.from(str.map((x) => ChapterNameListModel.fromJson(x)));

String chapterListModelToJson(List<ChapterNameListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterNameListModel {
  String? id;
  String? name;
  int? orderNumber;
  String? bookId;
  String? bookName;
  bool? conceptMap;

  ChapterNameListModel({
    this.id,
    this.name,
    this.orderNumber,
    this.bookId,
    this.bookName,
    this.conceptMap,
  });

  factory ChapterNameListModel.fromJson(Map<String, dynamic> json) => ChapterNameListModel(
        id: json['_id'],
        name: json['name'],
        orderNumber: json['orderNumber'],
        bookId: json['bookId'],
        bookName: json['bookName'],
        conceptMap: json['conceptMap'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'orderNumber': orderNumber,
        'bookId': bookId,
        'bookName': bookName,
        'conceptMap': conceptMap,
      };
}
