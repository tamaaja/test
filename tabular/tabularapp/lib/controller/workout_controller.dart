import 'package:flutter/material.dart';

class WorkoutController with ChangeNotifier {
  List<Map<String, dynamic>> workoutList = []; // Daftar latihan yang sudah ditambahkan

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

  void addToWorkout(Map<String, dynamic> exercise) {
    // Tambahkan informasi gambar ke exercise sebelum menambahkannya
    exercise['image'] = exerciseImages[exercise['exercise_name']] ?? 'assets/images/default.png';

    // Pastikan semua detail latihan (workout details) ada di exercise
    workoutList.add(exercise);
    notifyListeners();
  }


  void removeFromWorkout(Map<String, dynamic> exercise) {
    workoutList.remove(exercise);
    notifyListeners();
  }
}
