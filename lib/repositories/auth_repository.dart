import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_destroyer/models/user/user.dart';
import 'package:flutter_destroyer/services/auth_services.dart';
import 'package:flutter_destroyer/services/user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      final idToken = await _firebaseAuth.currentUser?.getIdToken();

      await postAuthSignInService(
        data: {"idToken": idToken},
      );

      return await getUserService();
    } catch (e) {
      developer.log(e.toString());
    }

    return null;
  }

  Future<void> signOut() async {
    await postAuthSignOutService();
    await _firebaseAuth.signOut();
  }
}
