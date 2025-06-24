import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final String email; 

  const Homepage({super.key, required this.email}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title')),
      body: Center(
        child: Text('Merhaba $email'),
      ), 
    );
  }
}
