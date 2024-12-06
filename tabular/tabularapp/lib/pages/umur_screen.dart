import 'package:flutter/material.dart';
import 'gender_screen.dart';

class UmurScreen extends StatelessWidget {
  final TextEditingController umurController = TextEditingController();

  UmurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
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
              'assets/images/gyman7.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Centered text at the top
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Masukkan Umur Anda",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Dashed line indicator (7 steps)
          Positioned(
            top: 80, // Adjust the position of the dashed line
            left: 16,
            right: 16,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 20),
              painter: DashedLinePainter(currentStep: 2), // Example: showing step 2 out of 7
            ),
          ),
          // Age input field at the bottom left
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6, // Adjust width
                child: TextField(
                  controller: umurController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Umur",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
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
                  if (umurController.text.trim().isEmpty || int.tryParse(umurController.text) == null) {
                    // Menampilkan snackbar jika umur belum diisi atau bukan angka
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Umur harus diisi dengan angka"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (int.parse(umurController.text) <= 0) {
                    // Validasi jika umur kurang atau sama dengan 0
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Umur harus lebih dari 0"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Menggunakan PageRouteBuilder untuk animasi swipe
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => GenderScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          // Slide transition from the right (swipe effect)
                          const begin = Offset(1.0, 0.0); // Start from the right
                          const end = Offset.zero; // End at the final screen
                          const curve = Curves.easeInOut; // Curve for smoothness

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(position: offsetAnimation, child: child);
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

class DashedLinePainter extends CustomPainter {
  final int currentStep;
  final int totalSteps = 7;

  DashedLinePainter({required this.currentStep});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 15.0;
    double dashSpace = 10.0;
    double startX = 0.0;

    // Draw dashed line
    for (int i = 0; i < totalSteps; i++) {
      if (i < currentStep) {
        // Draw solid line if it's the current step
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      } else {
        // Draw dashed line if it's not the current step
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      }
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
