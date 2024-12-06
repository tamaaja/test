import 'dart:convert'; // untuk encoding/decoding data JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin.dart'; // Pastikan ada halaman SignInPage

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage; // Menyimpan pesan error

  // Fungsi untuk menyimpan beberapa akun
  Future<void> _saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> accounts = prefs.getStringList('accounts') ?? [];

    // Cek apakah email sudah terdaftar
    bool isEmailTaken = accounts.any((account) {
      Map<String, String> accountMap = Map<String, String>.from(json.decode(account));
      return accountMap['email'] == email;
    });

    if (isEmailTaken) {
      setState(() {
        _errorMessage = 'Email telah digunakan'; // Set error message jika email sudah ada
      });
      return; // Jangan lanjutkan jika email sudah terdaftar
    }

    // Simpan akun baru dalam format JSON (email dan password)
    Map<String, String> newAccount = {
      'email': email,
      'password': password,
    };
    accounts.add(json.encode(newAccount)); // Convert Map ke JSON string

    // Simpan daftar akun yang sudah di-update
    await prefs.setStringList('accounts', accounts);

    setState(() {
      _errorMessage = null; // Menghapus error message setelah akun berhasil disimpan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Daftar Akun")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/gym1.jpeg', height: 100.0),
              SizedBox(height: 40.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Buat Akun Anda",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z]+\.[a-zA-Z]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata sandi tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Kata sandi harus minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Kata Sandi',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi kata sandi tidak boleh kosong';
                  }
                  if (value != passwordController.text) {
                    return 'Kata sandi tidak cocok';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              // Tampilkan pesan error jika ada
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Simpan akun baru
                    await _saveCredentials(
                      emailController.text.trim(),
                      passwordController.text,
                    );

                    // Jika email tidak terdaftar sebelumnya, lanjutkan ke halaman login
                    if (_errorMessage == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    }
                  }
                },
                child: Text("Daftar", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 40.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text("Sudah punya akun? Masuk", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}