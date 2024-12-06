import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/gemini_controller.dart';
import '../controller/workout_controller.dart';

class GeminiPredictPage extends StatefulWidget {
  @override
  _GeminiPredictPageState createState() => _GeminiPredictPageState();
}

class _GeminiPredictPageState extends State<GeminiPredictPage> {
  TextEditingController _promptController = TextEditingController();
  List<Map<String, dynamic>> selectedExercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini Workout Steps'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<GeminiController>(
          builder: (context, geminiController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol untuk memilih latihan yang akan dijelaskan
                Expanded(
                  child: Consumer<WorkoutController>(
                    builder: (context, workoutController, child) {
                      return ListView.builder(
                        itemCount: workoutController.workoutList.length,
                        itemBuilder: (context, index) {
                          var exercise = workoutController.workoutList[index];
                          return ListTile(
                            title: Text(exercise['exercise_name']),
                            onTap: () {
                              setState(() {
                                if (!selectedExercises.contains(exercise)) {
                                  selectedExercises.add(exercise);
                                }
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ),

                // Menampilkan langkah-langkah yang dihasilkan oleh Gemini
                geminiController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: geminiController.generatedSteps.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(geminiController.generatedSteps[index]),
                            );
                          },
                        ),
                      ),

                // Input prompt untuk chat
                TextField(
                  controller: _promptController,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Prompt untuk Chat',
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                
                // Tombol untuk mengirim data ke Gemini dan mendapatkan langkah-langkah
                ElevatedButton(
                  onPressed: () {
                    geminiController.generateSteps(selectedExercises);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text('Jelaskan Langkah-langkah'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
