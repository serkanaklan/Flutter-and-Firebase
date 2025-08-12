import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app349/firebase_options.dart';
import 'package:flutter_app349/views/homepage.dart';
import 'package:flutter_app349/views/login_page.dart';
import 'package:flutter_app349/views/tabbar_views.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Uygulama da daha önce jwt token var mı kontrolunu sağlar.
  String? hastoken = await FlutterSessionJwt.retrieveToken();
  bool expired = true;
  // eğer varsa isTokenExpired ile jwt nin kullanım gününe bakılır
  if (hastoken != null && hastoken.isNotEmpty) {
    expired = await FlutterSessionJwt.isTokenExpired();
  }
  // başlangıçta hiç giriş yapılmadığı için kayıt ve giriş sayfalarına yönlendirme
  String initialRoute = '/TabbarViews';
  String email = '';
  // eğer jwt token varsa payload ile mail çekilir email sayfasına gönderilir.
  if (hastoken != null && hastoken.isNotEmpty && !expired) {
    final payload = await FlutterSessionJwt.getPayload();
    email = payload['email'] ?? '';
    initialRoute = '/Homepage';
  }
  runApp(MyApp(initialRoute: initialRoute, email: email));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String email;
  const MyApp({super.key, required this.initialRoute, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: initialRoute,
      routes: {
        '/TabbarViews': (context) => TabbarViews(),
        '/Homepage': (context) => Homepage(email: email),
      },
    );
  }
}
