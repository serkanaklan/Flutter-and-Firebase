import 'package:flutter_app349/model/AuthModel.dart';
import 'package:flutter_app349/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';

class RegisterController {
  final Auth _auth = Auth();

  Future<AuthModel> createUser(String email, String password) async {
    final registerModel = await _auth.createUser(
      email: email.trim(),
      password: password.trim(),
    );

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final jwtToken = await user.getIdToken();
      await FlutterSessionJwt.saveToken(jwtToken!);
    } else {
      throw Exception("JWT not found");
    }
    return registerModel;
  }

  Future<AuthModel> googleSignIn() async {
    final result = await _auth.signInWithGoogle();
    if (result == null) {
      throw Exception('Google sign-in başarısız oldu.');
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final jwtGoogleToken = await user.getIdToken();
      await FlutterSessionJwt.saveToken(jwtGoogleToken!);
    } else {
      throw Exception("JWT not found");
    }
    return result;
  }
}
