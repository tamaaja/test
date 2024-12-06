import 'package:flutter/material.dart';
import 'package:tabularapp/main.dart';

class EndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/gyman4.jpg', // Gambar latar belakang
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[700],
                      size: 50,
                    ),
                  ),
                );
              },
            ),
          ),
          // Tombol Kembali
          Positioned(
            top: 24,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Teks selamat datang
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Selamat! Anda telah menyelesaikan langkah ini.",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Tombol 'GET STARTED' untuk memulai aplikasi atau melanjutkan
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aksi ketika tombol diklik, lanjut ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(
                        isDarkMode: false,
                        toggleDarkMode: (value) {},
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                  "GET STARTED",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withOpacity(0.3),
                  elevation: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
