import 'dart:convert';

List<CityListModal> cityListModalFromJson(str) => List<CityListModal>.from(str.map((x) => CityListModal.fromJson(x)));

String cityListModalToJson(List<CityListModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityListModal {
  CityListModal({
    required this.id,
    required this.state,
    required this.name,
  });

  String? id;
  State? state;
  String? name;

  factory CityListModal.fromJson(Map<String, dynamic>? json) => CityListModal(
        id: json?['_id'],
        state: State.fromJson(json?['state']),
        name: json?['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'state': state?.toJson(),
        'name': name,
      };
}

class State {
  State({
    required this.id,
    required this.name,
  });

  String? id;
  String? name;

  factory State.fromJson(Map<String, dynamic>? json) => State(
        id: json?['_id'],
        name: json?['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
