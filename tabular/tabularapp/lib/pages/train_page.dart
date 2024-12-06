import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../controller/train_controller.dart';
import '../controller/workout_controller.dart';

class TrainPage extends StatefulWidget {
  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _workoutTypeController = TextEditingController();
  String _displayText = '';
  String _textToType = 'Go TO GYM! Start Your Exercises Here!';
  int _currentCharIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTypingEffect();
  }

  void _startTypingEffect() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        _displayText += _textToType[_currentCharIndex];
        _currentCharIndex++;
        if (_currentCharIndex == _textToType.length) {
          _currentCharIndex = 0;
          _displayText = '';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header dengan Efek Mengetik
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Susunan Cards (1 besar di atas, 2 kecil di bawah)
              Column(
                children: [
                  // Card Panjang
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple[400]!, Colors.deepPurple[900]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.fitness_center, size: 50, color: Colors.white),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Track your progress with detailed metrics!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dua Card Sebelah
                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallCard(
                          icon: Icons.local_drink,
                          label: 'Hydration',
                          value: '2L/day',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildSmallCard(
                          icon: Icons.access_time,
                          label: 'Best Time',
                          value: 'Morning',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Input Kalori
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Input Calories Burned:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              TextField(
                controller: _calorieController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter calories burned',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),

              // Input untuk jenis latihan
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Input Workout Type (0 - 3):',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              TextField(
                controller: _workoutTypeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter workout type (0-3)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),

              // Tombol untuk Generate Latihan
              ElevatedButton(
                onPressed: _generateWorkout,
                child: Text('Generate Workout Plan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[600],
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 20),

              // Workout List
              Consumer<TrainController>(
                builder: (context, trainController, child) {
                  if (trainController.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (trainController.workoutPlan == null) {
                    return Center(child: Text('No workout plan generated.'));
                  }

                  // Filter dan tampilkan latihan
                  List<Map<String, dynamic>> existingExercises =
                      Provider.of<WorkoutController>(context).workoutList;
                  var filteredExercises = trainController.workoutPlan!['workout_details'].where((exercise) {
                    return !existingExercises.any((existing) => existing['exercise_name'] == exercise['exercise_name']);
                  }).toList();

                  return Column(
                    children: filteredExercises.map<Widget>((exercise) {
                      return _buildWorkoutCard(exercise, trainController);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(var exercise, TrainController trainController) {
    String exerciseName = exercise['exercise_name'];
    String exerciseImage = trainController.exerciseImages[exerciseName] ?? 'assets/images/default.png';

    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  exerciseImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 12),
              Text(exerciseName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildDetailRow('Max BPM', exercise['Max_BPM'].toString()),
              _buildDetailRow('Avg BPM', exercise['Avg_BPM'].toString()),
              _buildDetailRow('Resting BPM', exercise['Resting_BPM'].toString()),
              _buildDetailRow('Session Duration', '${exercise['Session_Duration']} min'),
              _buildDetailRow('Calories Burned', exercise['Calories_Burned'].toString()),
              _buildDetailRow('Fat Percentage', '${exercise['Fat_Percentage']}%'),
              _buildDetailRow('Water Intake', '${exercise['Water_Intake']} L'),
              ElevatedButton(
                onPressed: () {
                  final workoutController = Provider.of<WorkoutController>(context, listen: false);
                  workoutController.addToWorkout(exercise);
                },
                child: Text('Add to Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCard({required IconData icon, required String label, required String value}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.deepPurple[600]),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Future<void> _generateWorkout() async {
    final calorie = int.tryParse(_calorieController.text);
    final workoutType = int.tryParse(_workoutTypeController.text);

    if (calorie == null || workoutType == null || calorie <= 0 || workoutType < 0 || workoutType > 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Input tidak valid! Harap masukkan kalori dan jenis latihan yang benar.'))
      );
      return;
    }

    final trainController = Provider.of<TrainController>(context, listen: false);
    try {
      await trainController.generateWorkoutPlan(calorie, workoutType);  
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate workout: $e')),
      );
    }
  }
}
