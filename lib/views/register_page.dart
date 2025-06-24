import 'package:flutter/material.dart';
import 'package:flutter_app349/controller/login_controller.dart';
import 'package:flutter_app349/controller/register_controller.dart';
import 'package:flutter_app349/views/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegisterController loginController = RegisterController();

  void _register() async {
    final result = await loginController.createUser(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (result.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(email: emailController.text.trim()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.errorMessage ?? 'Kayıt başarısız')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                FlutterLogo(size: 200, style: FlutterLogoStyle.horizontal),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Kayıt Ol'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    loginController.googleSignIn();
                  },
                  label: Text('Google ile kayıt olun'),
                  icon: Image.asset('asset/google.png', width: 24, height: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
