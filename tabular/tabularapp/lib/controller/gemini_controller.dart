import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiController with ChangeNotifier {
  final List<String> generatedSteps = [];
  bool isLoading = false;

  Future<void> generateSteps(List<Map<String, dynamic>> selectedExercises) async {
    isLoading = true;
    notifyListeners();

    const apiKey = 'AIzaSyA-hBGz21vnXwIxTartdBKDRKVKhPgZEkc';
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    try {
      // Membuat prompt dengan menyertakan nama latihan dan detail workout lengkap
      String prompt = "Berikut adalah latihan yang akan dijelaskan langkah-langkahnya:\n";
      for (var exercise in selectedExercises) {
        String exerciseName = exercise['exercise_name'];
        
        // Ambil semua detail workout dan tambahkan ke prompt
        String workoutDetails = """
        Max BPM: ${exercise['Max_BPM']}, 
        Avg BPM: ${exercise['Avg_BPM']}, 
        Resting BPM: ${exercise['Resting_BPM']}, 
        Session Duration: ${exercise['Session_Duration']} minutes, 
        Calories Burned: ${exercise['Calories_Burned']}, 
        Fat Percentage: ${exercise['Fat_Percentage']}%, 
        Water Intake: ${exercise['Water_Intake']} L
        """;

        prompt += "1. $exerciseName - $workoutDetails\n";
      }

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        generatedSteps.clear();
        generatedSteps.addAll(response.text!.split('\n').where((line) => line.isNotEmpty));
      }
    } catch (e) {
      generatedSteps.clear();
      generatedSteps.add("Error generating steps: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
