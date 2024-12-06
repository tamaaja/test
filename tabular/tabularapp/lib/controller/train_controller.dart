import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrainController with ChangeNotifier {
  bool isLoading = false;
  Map<String, dynamic>? workoutPlan;
  bool workoutsGenerated = false;

  final String baseUrl = 'https://gerry.loca.lt/api/predict/';

  final Map<String, String> exerciseImages = {
    'Lari': 'assets/images/lari.png',
    'Sepeda': 'assets/images/sepeda.png',
    'Ski Erg': 'assets/images/ski_erg.png',
    'Berjalan Cepat': 'assets/images/lari_cepat.png',
    'Jumping Jack': 'assets/images/jumping_jack.png',
    'Mountain Climbers': 'assets/images/mountain_climber.png',
    'Forward Scissor': 'assets/images/forward_scissor.png',
    'Burpees': 'assets/images/burpees.png',
    'Jump Squats': 'assets/images/jump_squats.png',
    'Push-ups': 'assets/images/push_up.png',
    'Plank': 'assets/images/plank.png',
    'Jumping Lunges': 'assets/images/jumping_lunges.png',
    'Box Jumps': 'assets/images/box_jumps.png',
    'Tuck Jumps': 'assets/images/tuck_jumps.png',
    'Squats': 'assets/images/squad.png',
    'Deadlifts': 'assets/images/deadlifts.png',
    'Lunges': 'assets/images/tuck_jumps.png',
    'Pull-ups': 'assets/images/plank.png',
    'Bicep Curls': 'assets/images/bicep_curls.png',
    'Chest Press': 'assets/images/chest_press.png',
    'Downward Dog': 'assets/images/downward_dog.png',
    'Child\'s Pose': 'assets/images/child_pose.png',
    'Warrior One': 'assets/images/warrior_one.png',
    'Tree Pose': 'assets/images/tree_pose.png',
    'Cobra Pose': 'assets/images/cobra_pose.png',
    'Crescew Moon Pose': 'assets/images/crescew_moon_pose.png',
    'Pyramid Pose': 'assets/images/crescew_moon_pose.png',
  };


  Future<void> generateWorkoutPlan(int calories, int workoutType) async {
    workoutsGenerated = false;
    isLoading = true;
    notifyListeners();

    try {
      print("Sending request to: $baseUrl");
      final response = await _sendRequest(calories, workoutType);

      if (response.statusCode == 200) {
        _handleResponse(response);
      } else {
        print("Server error: ${response.statusCode}, ${response.body}");
        throw WorkoutGenerationException(
            'Server error: ${response.statusCode}, ${response.body}');
      }
    } on TimeoutException catch (e) {
      print("Request timeout: $e");
      throw WorkoutGenerationException('Request timeout: $e');
    } on http.ClientException catch (e) {
      print("Client error: $e");
      throw WorkoutGenerationException('Network error: $e');
    } catch (e) {
      print("Unexpected error: $e");
      throw WorkoutGenerationException('Unexpected error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _sendRequest(int calories, int workoutType) async {
    final headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'FlutterApp', // User-Agent header
      'bypass-tunnel-reminder': 'true', // Bypass tunnel reminder
    };

    final body = json.encode({
      'calories_burned': calories,
      'workout_type': workoutType,
    });

    return await http
        .post(Uri.parse(baseUrl), headers: headers, body: body)
        .timeout(const Duration(seconds: 15));
  }

  void _handleResponse(http.Response response) {
    try {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic>) {
        workoutPlan = data;
        workoutsGenerated = true;
      } else {
        throw DataParsingException('Invalid response format');
      }
    } catch (e) {
      print("Parsing error: $e");
      throw DataParsingException('Parsing error: $e');
    }
  }

  String getExerciseImage(String exerciseName) {
    return exerciseImages[exerciseName] ?? 'assets/images/default.png';
  }
}

class WorkoutGenerationException implements Exception {
  final String message;
  WorkoutGenerationException(this.message);

  @override
  String toString() => message;
}

class DataParsingException implements Exception {
  final String message;
  DataParsingException(this.message);

  @override
  String toString() => message;
}
