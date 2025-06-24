import 'package:flutter_app349/model/AuthModel.dart';
import 'package:flutter_app349/services/auth.dart';

class RegisterController {
  Auth _auth = Auth();
  Future<AuthModel> createUser(String email, String password) async {
    return await _auth.createUser(
      email: email.trim(),
      password: password.trim(),
    );
  }
    Future<AuthModel> googleSignIn() async {
    final result = await _auth.signInWithGoogle();
    if (result == null) {
  
    throw Exception('Google sign-in başarısız oldu.');
      
    }
    return result;
  }
}
