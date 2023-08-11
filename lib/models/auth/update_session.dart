import 'dart:convert';

import 'package:students/models/auth/user.dart';

UpdateSessionModal updateSessionFromJson(String str) => UpdateSessionModal.fromJson(json.decode(str));

String updateSessionToJson(UpdateSessionModal data) => json.encode(data.toJson());

class UpdateSessionModal {
  UpdateSessionModal({
    this.users,
    this.user,
    this.token,
  });

  List<User>? users;
  User? user;
  String? token;

  factory UpdateSessionModal.fromJson(Map<String, dynamic>? json) => UpdateSessionModal(
        users: List<User>.from(json?['users']?.map((x) => User.fromJson(x)) ?? []),
        user: User.fromJson(json?['user']),
        token: json?['token'],
      );

  Map<String, dynamic> toJson() => {
        'users': List<User>.from(users?.map((x) => x.toJson()) ?? []),
        'user': user?.toJson(),
        'token': token,
      };
}
