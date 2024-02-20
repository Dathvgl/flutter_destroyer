import 'package:flutter_destroyer/models/user/user_role.dart';

class UserModel {
  final String id;
  final String uid;
  final String? name;
  final String? email;
  final String? thumnail;
  final String? gender;
  final int? birth;
  final List<UserRoleModel>? roles;

  static const empty = UserModel(id: "", uid: "");
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  const UserModel({
    required this.id,
    required this.uid,
    this.email,
    this.name,
    this.thumnail,
    this.gender,
    this.birth,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] as String,
      uid: json["uid"] as String,
      name: json["name"] as String?,
      thumnail: json["thumnail"] as String?,
      gender: json["gender"] as String?,
      birth: json["birth"] as int?,
      roles: (json["roles"] as List)
          .map((item) => UserRoleModel.fromJson(item))
          .toList(),
    );
  }
}
