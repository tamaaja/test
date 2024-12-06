import 'dart:convert'; // untuk decoding data JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nama_screen.dart'; // Ganti dengan halaman tujuan setelah login
import 'signup.dart'; // Ganti dengan halaman SignUpPage jika perlu

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, String>> accounts = []; // Menyimpan daftar akun yang disimpan

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  // Memuat daftar akun yang disimpan di SharedPreferences
  Future<void> _loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> accountsData = prefs.getStringList('accounts') ?? [];
    setState(() {
      accounts = accountsData.map((account) {
        return Map<String, String>.from(json.decode(account));
      }).toList();
    });
  }

  // Fungsi untuk menangani login
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      // Cari akun yang cocok dengan email yang dimasukkan
      final account = accounts.firstWhere(
        (account) => account['email'] == email,
        orElse: () => {},
      );

      // Verifikasi password jika akun ditemukan
      if (account.isNotEmpty && account['password'] == password) {
        // Simpan email pengguna yang berhasil login ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', email); // Simpan email ke SharedPreferences

        // Navigasi ke halaman utama jika login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NamaScreen()),
        );
      } else {
        // Tampilkan pesan jika email atau password salah
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email atau kata sandi salah')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Masuk")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/gym1.jpeg', height: 200.0),
              SizedBox(height: 40.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Masuk ke Akun Anda",
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
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: _signIn,
                child: Text("Masuk", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  "Belum punya akun? Daftar",
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}