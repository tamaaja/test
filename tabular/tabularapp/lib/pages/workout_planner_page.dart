import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/workout_controller.dart';

class WorkoutPlannerPage extends StatefulWidget {
  @override
  _WorkoutPlannerPageState createState() => _WorkoutPlannerPageState();
}

class _WorkoutPlannerPageState extends State<WorkoutPlannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Planner'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<WorkoutController>(
          builder: (context, workoutController, child) {
            if (workoutController.workoutList.isEmpty) {
              return Center(child: Text('No workout plans available.'));
            }

            return ListView.builder(
              itemCount: workoutController.workoutList.length,
              itemBuilder: (context, index) {
                var exercise = workoutController.workoutList[index];
                return _buildWorkoutCard(exercise);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(Map<String, dynamic> exercise) {
    String exerciseName = exercise['exercise_name'];
    String exerciseImage = exercise['image']; // Gunakan properti 'image'

    // Ambil detail lainnya
    String maxBpm = exercise['Max_BPM']?.toString() ?? '-';
    String avgBpm = exercise['Avg_BPM']?.toString() ?? '-';
    String restingBpm = exercise['Resting_BPM']?.toString() ?? '-';
    String sessionDuration = exercise['Session_Duration']?.toString() ?? '-';
    String caloriesBurned = exercise['Calories_Burned']?.toString() ?? '-';
    String fatPercentage = exercise['Fat_Percentage']?.toString() ?? '-';
    String waterIntake = exercise['Water_Intake']?.toString() ?? '-';

    return GestureDetector(
      onTap: () {
        print('Card tapped: $exerciseName');
      },
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
              _buildDetailRow('Max BPM', maxBpm),
              _buildDetailRow('Avg BPM', avgBpm),
              _buildDetailRow('Resting BPM', restingBpm),
              _buildDetailRow('Session Duration', '$sessionDuration min'),
              _buildDetailRow('Calories Burned', caloriesBurned),
              _buildDetailRow('Fat Percentage', '$fatPercentage%'),
              _buildDetailRow('Water Intake', '$waterIntake L'),
            ],
          ),
        ),
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
}
