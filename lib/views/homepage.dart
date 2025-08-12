import 'package:flutter/material.dart';
import 'package:flutter_app349/services/jwt_delete.dart';
import 'package:flutter_app349/views/tabbar_views.dart';

class Homepage extends StatelessWidget {
  final String email;

  const Homepage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final jwtdelete = Jwtdelete();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Hoşgeldin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              email.isNotEmpty ? 'Merhaba\n $email' : 'Merhaba!',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 200),
            ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Hesabı Sil"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Şifre",
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            try {
                              await jwtdelete.deleteAccount(
                                email,
                                passwordController.text,
                              );

                              // Başarılıysa anasayfadan çık
                              // dialog kapat
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Hesabınız silindi."),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TabbarViews(),
                                ),
                              ); // homepage kapat
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString().replaceFirst(
                                      "Exception: ",
                                      "",
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text("Onayla"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Hesabı SİL', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
