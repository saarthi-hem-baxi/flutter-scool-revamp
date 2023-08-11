import 'dart:convert';

List<TeachingModal> teachingModalFromJson(data) => List<TeachingModal>.from(data.map((x) => TeachingModal.fromJson(x)));

String teachingModalToJson(List<TeachingModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachingModal {
  TeachingModal({
    this.id,
    this.name,
    this.sections,
  });

  String? id;
  String? name;
  List<Sections>? sections;

  factory TeachingModal.fromJson(Map<String, dynamic>? json) => TeachingModal(
        id: json?['_id'],
        name: json?['name'],
        sections: List<Sections>.from(json?['sections']?.map((x) => Sections.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'sections': List<dynamic>.from(sections?.map((x) => x.toJson()) ?? []),
      };
}

class Sections {
  Sections({this.id, this.name, this.isChecked});

  String? id;
  String? name;
  bool? isChecked;

  factory Sections.fromJson(Map<String, dynamic>? json) => Sections(id: json?['_id'], name: json?['name'], isChecked: false);

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
