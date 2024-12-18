import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      //firebase için backend kodları
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-posta gönderildi!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifre Sıfırlama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Şifre sıfırlama bağlantısı için E-Postanızı girin:\n(amasya.edu.tr uzantılı olan)',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta Adresi',
                  border: OutlineInputBorder(),
                  hintText: 'E-posta adresinizi girin',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta adresini girmeniz gerekiyor';
                  }
                  // E-posta doğrulama
                  if (!RegExp(r"^[0-9]+@ogrenci\.amasya\.edu\.tr$")
                      .hasMatch(value)) {
                    return 'Geçersiz e-posta adresi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Şifreyi Sıfırla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
