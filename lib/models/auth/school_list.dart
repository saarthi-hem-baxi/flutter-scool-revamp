// To parse this JSON data, do
//
//     final schoolListModel = schoolListModelFromJson(jsonString);

import 'dart:convert';

List<SchoolListModel> schoolListModelFromJson(str) => List<SchoolListModel>.from(str.map((x) => SchoolListModel.fromJson(x)));

String schoolListModelToJson(List<SchoolListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolListModel {
  SchoolListModel({
    this.address,
    this.id,
    this.name,
    this.logoThumb,
    this.logo,
    this.schoolListModelId,
  });

  Address? address;
  String? id;
  String? name;
  String? logoThumb;
  String? logo;
  String? schoolListModelId;

  factory SchoolListModel.fromJson(Map<String, dynamic> json) => SchoolListModel(
        address: json['address'] == null ? null : Address.fromJson(json['address']),
        id: json['_id'],
        name: json['name'],
        logoThumb: json['logoThumb'],
        logo: json['logo'],
        schoolListModelId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'address': address?.toJson(),
        '_id': id,
        'name': name,
        'logoThumb': logoThumb,
        'logo': logo,
        'id': schoolListModelId,
      };
}

class Address {
  Address({
    this.city,
  });

  City? city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json['city'] == null ? null : City.fromJson(json['city']),
      );

  Map<String, dynamic> toJson() => {
        'city': city?.toJson(),
      };
}

class City {
  City({
    this.id,
    this.name,
    this.cityId,
  });

  String? id;
  String? name;
  String? cityId;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['_id'],
        name: json['name'],
        cityId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'id': cityId,
      };
}
