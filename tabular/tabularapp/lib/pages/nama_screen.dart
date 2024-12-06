import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'umur_screen.dart';
import '../controller/user_controller.dart';

class NamaScreen extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/gyman9.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Masukkan Nama Anda",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: MediaQuery.of(context).size.width * 0.1,
            child: DottedLineIndicator(totalSteps: 7, currentStep: 1),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: "Nama",
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (namaController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Nama harus diisi"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Simpan nama ke UserController
                    Provider.of<UserController>(context, listen: false)
                        .setUserName(namaController.text);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UmurScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

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


class DottedLineIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const DottedLineIndicator(
      {required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (int i = 1; i <= totalSteps; i++) {
      dots.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i <= currentStep
                ? Colors.blue
                : Colors.white.withOpacity(0.5),
          ),
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
  }
}