import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';

class Jwtdelete {
  Future<void> deleteAccount(String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("Kullanıcı oturumu bulunamadı.");
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      await user.delete();

      // JWT token temizle ama hata verirse yut
      try {
        await FlutterSessionJwt.deleteToken();
      } catch (_) {
        // jwt yoksa sessizce geç
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw Exception("Şifre yanlış. Lütfen tekrar deneyin.");
      } else if (e.code == 'user-mismatch') {
        throw Exception("Bu e-posta farklı bir kullanıcıya ait.");
      } else if (e.code == 'user-not-found') {
        throw Exception("Kullanıcı bulunamadı.");
      } else {
        throw Exception("Firebase hatası: ${e.message}");
      }
    } catch (e) {
      throw Exception("Hesap silme hatası: $e");
    }
  }
}
