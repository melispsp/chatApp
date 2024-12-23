// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form için GlobalKey tanımlandı
  bool _isPasswordVisible = false; // Şifre görünürlük kontrolü
  bool _isConfirmPasswordVisible = false; // Şifre tekrar görünürlük kontrolü

  // Kayıt işlemi fonksiyonu
  void _register() {
    if (_formKey.currentState!.validate()) {
      // Eğer tüm validasyonlardan geçerse
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt başarılı!')),
      );
      Navigator.pop(context); // Login sayfasına geri döner
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Form'u GlobalKey ile ilişkilendiriyoruz
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kayıt Formu Alanı
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 12, 10, 30),
                          const Color.fromARGB(255, 9, 9, 81)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),

                        // İsim Alanı
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Ad Soyad',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 46, 46, 46),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.person,
                                color: Colors.white), // İkon ekledim
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen ad soyad girin';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Mail Alanı
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Mail',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 46, 46, 46),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.email,
                                color: Colors.white), // İkon ekledim
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen mail adresinizi girin';
                            }
                            // E-posta doğrulama
                            if (!RegExp(r"^[0-9]+@ogrenci\.amasya\.edu\.tr$")
                                .hasMatch(value)) {
                              return 'Geçersiz e-posta adresi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Şifre Alanı
                        TextFormField(
                          controller: _passwordController,
                          obscureText:
                              !_isPasswordVisible, // Şifre görünürlük kontrolü
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 46, 46, 46),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.white), // İkon ekledim
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lütfen şifrenizi girin';
                            }
                            if (value.length < 6) {
                              return 'Şifre en az 6 karakter olmalıdır';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Şifre Tekrar Alanı
                        TextFormField(
                          controller: _passwordConfirmController,
                          obscureText:
                              !_isConfirmPasswordVisible, // Şifre tekrar görünürlük kontrolü
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Şifre Tekrar',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 46, 46, 46),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.white), // İkon ekledim
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Şifreler eşleşmiyor';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),

                        // Kayıt Ol Butonu
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),

                        // Geri Dön Butonu
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Geri Dön',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
