import 'package:flutter/material.dart';
import '../controller/workout_controller.dart';

// Provider class (optional) if you want to manage state separately
class WorkoutProvider with ChangeNotifier {
  WorkoutController _workoutController = WorkoutController();

  WorkoutController get workoutController => _workoutController;
}
