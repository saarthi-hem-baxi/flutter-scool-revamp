class User {
  User({
    this.id,
    this.status,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.thumb,
    this.school,
    this.isDrawCode,
    this.drawCode,
    this.userClass,
    this.section,
    this.contact,
    this.rollNo,
    this.updatedAt,
  });

  String? id;
  String? status;
  String? name;
  String? firstName;
  String? lastName;
  bool? isDrawCode;
  dynamic drawCode;
  String? email;
  String? avatar;
  String? thumb;
  School? school;
  Class? userClass;
  Section? section;
  String? contact;
  String? rollNo;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic>? json) => User(
        id: json?['_id'],
        status: json?['status'],
        name: json?['name'],
        firstName: json?['firstName'],
        lastName: json?['lastName'],
        email: json?['email'],
        isDrawCode: json?['isDrawCode'],
        avatar: json?['avatar'],
        thumb: json?['thumb'],
        school: School.fromJson(json?['school']),
        drawCode: json?['drawCode'],
        userClass: Class.fromJson(json?['class']),
        section: Section.fromJson(json?['section']),
        contact: json?['contact'],
        rollNo: json?['rollNo'] != null ? json!['rollNo'] : json?['rollNumber'],
        updatedAt: json?['updatedAt'] == null ? null : DateTime.parse(json?['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'status': status,
        'name': name,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'avatar': avatar,
        'thumb': thumb,
        'school': school?.toJson() ?? '',
        'class': userClass?.toJson() ?? '',
        'section': section?.toJson() ?? '',
        'contact': contact,
        'rollNo': rollNo,
        'updatedAt': updatedAt?.toIso8601String() ?? '',
      };
}

class Class {
  Class({
    this.id,
    this.name,
    this.classId,
  });

  String? id;
  String? name;
  String? classId;

  factory Class.fromJson(Map<String, dynamic>? json) => Class(
        id: json?['_id'],
        name: json?['name'],
        classId: json?['id'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'id': classId,
      };
}

class Section {
  Section({
    this.id,
    this.name,
    this.classId,
  });

  String? id;
  String? name;
  String? classId;

  factory Section.fromJson(Map<String, dynamic>? json) => Section(
        id: json?['_id'],
        name: json?['name'],
        classId: json?['id'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'id': classId,
      };
}

class School {
  School({
    this.id,
    this.name,
    this.logoThumb,
    this.board,
    this.medium,
    this.schoolId,
  });

  String? id;
  String? name;
  String? logoThumb;
  SchoolBoard? board;
  SchoolMedium? medium;
  String? schoolId;

  factory School.fromJson(Map<String, dynamic>? json) => School(
        id: json?['_id'],
        name: json?['name'],
        schoolId: json?['id'],
        board: SchoolBoard.fromJson(json?['board']),
        medium: SchoolMedium.fromJson(json?['medium']),
        logoThumb: json?['logoThumb'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'id': schoolId,
        'board': board,
        'medium': medium,
        'logoThumb': logoThumb,
      };
}

class SchoolBoard {
  SchoolBoard({
    this.id,
    this.shortName,
  });

  String? id;
  String? shortName;

  factory SchoolBoard.fromJson(Map<String, dynamic>? json) => SchoolBoard(
        id: json?['_id'],
        shortName: json?['shortName'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'shortName': shortName,
      };
}

class SchoolMedium {
  SchoolMedium({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory SchoolMedium.fromJson(Map<String, dynamic>? json) => SchoolMedium(
        id: json?['_id'],
        name: json?['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
