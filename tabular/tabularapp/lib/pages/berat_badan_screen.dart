import 'package:flutter/material.dart';
import 'tinggi_badan_screen.dart';

class BeratBadanScreen extends StatelessWidget {
  final TextEditingController beratController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/gyman8.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Centered text at the top
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Masukkan Berat Badan Anda (kg)",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Weight input field at the bottom left
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6, // Adjust width
                child: TextField(
                  controller: beratController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Berat Badan",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // "Next" button at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (beratController.text.isEmpty ||
                      double.tryParse(beratController.text) == null) {
                    // Menampilkan snackbar jika input tidak valid
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Masukkan berat badan yang valid sebelum melanjutkan."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Swipe-to-right transition to TinggiBadanScreen
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TinggiBadanScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Start off to the right
                          const end =
                              Offset.zero; // End at the current position
                          const curve = Curves
                              .easeInOut; // Smooth curve for the transition

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  }
                },
                label: Text("NEXT", style: TextStyle(color: Colors.white)),
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
