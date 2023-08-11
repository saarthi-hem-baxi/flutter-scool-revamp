import 'dart:convert';

import 'package:students/models/auth/user.dart';

UsersModal usersModalFromJson(String str) => UsersModal.fromJson(json.decode(str));

String usersModalToJson(UsersModal data) => json.encode(data.toJson());

class UsersModal {
  UsersModal({
    this.users,
    this.token,
  });

  List<User>? users;
  String? token;

  factory UsersModal.fromJson(Map<String, dynamic>? json) => UsersModal(
        users: List<User>.from(json?['users'].map((x) => User.fromJson(x))),
        token: json?['token'],
      );

  Map<String, dynamic> toJson() => {
        'users': List<dynamic>.from(users?.map((x) => x.toJson()) ?? []),
        'token': token,
      };
}
