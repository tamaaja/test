import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionProvider with ChangeNotifier {
  List<double> inputData = [0.0, 0.0, 0.0, 0.0];
  String? predictionMessage;

  final TextEditingController sepalLengthController = TextEditingController();
  final TextEditingController sepalWidthController = TextEditingController();
  final TextEditingController petalLengthController = TextEditingController();
  final TextEditingController petalWidthController = TextEditingController();

  // Fungsi untuk mengupdate input data
  void updateInputData(int index, double value) {
    inputData[index] = value.toDouble();
    notifyListeners();
  }

  // Fungsi untuk mengirim data ke API dan mendapatkan respons
  Future<void> predict() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/predict'); // Ganti dengan URL API kamu
    final body = jsonEncode({
      'data': inputData,
    });
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int classPrediction = data['prediction'][0];
        predictionMessage = _mapClassToSpecies(classPrediction);
      } else {
        predictionMessage = 'Failed to get prediction';
      }
      clearInputData();
      clearControllers();
    } catch (e) {
      predictionMessage = 'Error: $e';
    }
    notifyListeners();
  }

  String _mapClassToSpecies(int classPrediction) {
    switch (classPrediction) {
      case 0:
        return 'Setosa';
      case 1:
        return 'Versicolor';
      case 2:
        return 'Virginica';
      default:
        return 'Unknown species';
    }
  }

  void clearInputData() {
    inputData = [0.0, 0.0, 0.0, 0.0];
    notifyListeners();
  }

  // Fungsi untuk mengosongkan semua controller input
  void clearControllers() {
    sepalLengthController.clear();
    sepalWidthController.clear();
    petalLengthController.clear();
    petalWidthController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller ketika provider tidak lagi digunakan
    sepalLengthController.dispose();
    sepalWidthController.dispose();
    petalLengthController.dispose();
    petalWidthController.dispose();
    super.dispose();
  }
}
