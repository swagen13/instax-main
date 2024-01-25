import 'package:flutter/material.dart';

class TemporaryUsernameProvider extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void resetUsername() {
    _username = '';
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TemporaryPasswordProvider with ChangeNotifier {
  String _password = '';

  String get password => _password;

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void resetPassword() {
    _password = '';
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
