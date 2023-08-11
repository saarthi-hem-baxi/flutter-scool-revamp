import 'package:students/models/auth/user.dart';

class RenewUserModal {
  RenewUserModal({
    this.expiry,
    this.users,
    this.user,
  });

  DateTime? expiry;
  List<User>? users;
  User? user;

  factory RenewUserModal.fromJson(Map<String, dynamic>? json) => RenewUserModal(
        expiry: DateTime.parse(json?['_expiry']).toLocal(),
        users: List<User>.from(json?['users']?.map((x) => User.fromJson(x)) ?? []),
        user: User.fromJson(json?['user']),
      );

  Map<String, dynamic> toJson() => {
        '_expiry': expiry?.toIso8601String(),
        'users': List<dynamic>.from(users?.map((x) => x.toJson()) ?? []),
        'user': user?.toJson(),
      };
}
