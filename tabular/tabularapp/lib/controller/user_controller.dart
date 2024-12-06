import 'package:flutter/foundation.dart';

class UserController with ChangeNotifier {
  String _userName = "";
  int _umur = 0;
  double _berat = 0.0;
  String _gender = "";
  double _tinggiBadan = 0.0;

  // Getters
  String get userName => _userName;
  int get umur => _umur;
  double get berat => _berat;
  String get gender => _gender;
  double get tinggiBadan => _tinggiBadan;

  // Setters
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUmur(int age) {
    _umur = age;
    notifyListeners();
  }

  void setBerat(double weight) {
    _berat = weight;
    notifyListeners();
  }

  void setGender(String userGender) {
    _gender = userGender;
    notifyListeners();
  }

  void setTinggiBadan(double height) {
    _tinggiBadan = height;
    notifyListeners();
  }

  // Update Profile
  void updateUserProfile({
    required String name,
    required int age,
    required double weight,
    required String userGender,
    required double height,
  }) {
    _userName = name;
    _umur = age;
    _berat = weight;
    _gender = userGender;
    _tinggiBadan = height;
    notifyListeners();
  }
}