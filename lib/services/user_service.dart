import 'package:flutter_destroyer/models/fetch_handle.dart';
import 'package:flutter_destroyer/models/user/user.dart';

Future<UserModel?> getUserService() async {
  final response = await FetchHandle().get("/api/user/once");
  if (response == null) return null;
  return UserModel.fromJson(response.data);
}
