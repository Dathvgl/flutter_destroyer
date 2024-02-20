import 'package:flutter_destroyer/models/fetch_handle.dart';

Future<void> postAuthSignInService({
  required Map<String, dynamic> data,
}) async {
  await FetchHandle().post("/api/user/session-signin", data: data);
}

Future<void> postAuthSignOutService() async {
  await FetchHandle().post("/api/user/session-signout");
}
