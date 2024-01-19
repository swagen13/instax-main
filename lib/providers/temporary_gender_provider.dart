import 'package:flutter/material.dart';

class TemporaryGenderProvider extends ChangeNotifier {
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  String? getGender() {
    return _selectedGender;
  }
}
