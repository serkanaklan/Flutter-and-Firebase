import 'package:flutter/material.dart';
import 'package:flutter_app349/controller/login_controller.dart';
import 'package:flutter_app349/views/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  void _login() async {
    final result = await loginController.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (result.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(email: emailController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.errorMessage ?? 'Bir hata oluştu')),
      );
    }
  }
  void restPass (String mail) async{
    final result = await loginController.newpass(mail);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                FlutterLogo(size: 178, style: FlutterLogoStyle.horizontal),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.abc),
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
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Giriş Yap'),
                ),

                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        loginController.googleSignIn();
                      },
                      label: Text('Google ile giriş yapın'),
                      icon: Image.asset(
                        'asset/google.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        restPass(emailController.text);
                      },
                      child: Text('Şifremi unuttum'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
