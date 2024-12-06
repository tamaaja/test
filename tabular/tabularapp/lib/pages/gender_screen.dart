import 'package:flutter/material.dart';
import 'berat_badan_screen.dart';

class GenderScreen extends StatelessWidget {
  final TextEditingController genderController = TextEditingController();

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
              'assets/images/gyman5.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Centered text at the top
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Pilih Gender Anda",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Gender dropdown field at the bottom left
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6, // Adjust width
                child: DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(
                        value: "Laki-laki", child: Text("Laki-laki")),
                    DropdownMenuItem(
                        value: "Perempuan", child: Text("Perempuan")),
                  ],
                  onChanged: (value) {
                    genderController.text = value!;
                  },
                  decoration: InputDecoration(
                    hintText: "Gender",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
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
                  if (genderController.text.isEmpty) {
                    // Menampilkan snackbar jika gender belum dipilih
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pilih gender Anda sebelum melanjutkan."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Swipe-to-right transition to BeratBadanScreen
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BeratBadanScreen(),
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
