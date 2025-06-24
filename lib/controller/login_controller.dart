import 'package:flutter_app349/model/AuthModel.dart';
import 'package:flutter_app349/services/auth.dart';

class LoginController {
  final Auth _auth = Auth();

  Future<AuthModel> login(String email, String password) {
    return _auth.login(email: email.trim(), password: password.trim());
  }

  Future<AuthModel> googleSignIn() async {
    final result = await _auth.signInWithGoogle();
    if (result == null) {
      throw Exception('Google sign-in başarısız oldu.');
    }
    return result;
  }

  Future<AuthModel?> newpass(String email) async {
    return await _auth.resetPassword(email: email);
    // if (result == null) {
    //   throw Exception("resetPassword() null döndü, işlem başarısız!");
    // }
    // return result;
  }
}
