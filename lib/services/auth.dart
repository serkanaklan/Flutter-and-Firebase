import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_app349/model/AuthModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthModel> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthModel(isSuccess: true);
    } on FirebaseAuthException catch (e) {
      return AuthModel(isSuccess: false, errorMessage: _ErrorHandle(e));
    } catch (e) {
      return AuthModel(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthModel(isSuccess: true);
    } on FirebaseAuthException catch (e) {
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11');
      print('HATA ${_ErrorHandle(e)}');
      return AuthModel(isSuccess: false, errorMessage: _ErrorHandle(e));
    } catch (e) {
      return AuthModel(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }

  Future resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
       
        print('Google sign-in iptal edildi.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null && googleAuth.idToken == null) {
        
        print('Google accessToken ve idToken boş.');
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
      return null;
    }
  }
}

String _ErrorHandle(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'Geçersiz Email';
    case 'user-not-found':
      return 'Kullanıcı bulunamadı!!';
    case 'email-already-in-use':
      return 'Bu email zaten var';
    case 'wrong-password':
      return 'Girilen şifre yanlış';
    case 'The supplied auth credential is incorrect, malformed or has expired.':
      return '!!!!!!!!!!!!!!!!!!!!!1';
    default:
      return '${e.message}';
  }
}
