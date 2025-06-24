import 'package:flutter/material.dart';
import 'package:flutter_app349/views/login_page.dart';
import 'package:flutter_app349/views/register_page.dart';

class TabbarViews extends StatelessWidget {
  const TabbarViews({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[Tab(text: 'Giriş Yap'), Tab(text: 'Kayıt ol')],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: LoginPage()),
            Center(child: RegisterPage()),
          ],
        ),
      ),
    );
  }
}
