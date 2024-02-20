class UserRoleModel {
  final String id;
  final String name;

  UserRoleModel({
    required this.id,
    required this.name,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      id: json["_id"] as String,
      name: json["name"] as String,
    );
  }
}
