import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final String email; // email burada String olarak tutulacak

  const Homepage({super.key, required this.email}); // this.email olarak ata

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title')),
      body: Center(
        child: Text('Merhaba $email'),
      ), // email.text değil, direkt email
    );
  }
}
