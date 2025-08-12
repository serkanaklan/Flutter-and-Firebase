import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app349/model/AuthModel.dart';
import 'package:flutter_app349/services/auth.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';

class LoginController {
  final Auth _auth = Auth();

  Future<AuthModel> login(String email, String password)async {
   final authModel = await _auth.login(email: email.trim(), password: password.trim());
   final user = FirebaseAuth.instance.currentUser;
  
  if (user != null) {
    final idToken = await user?.getIdToken(); 
    await FlutterSessionJwt.saveToken(idToken!);
  } else  {
    throw Exception("JWT not found");
  }
  return authModel;

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

