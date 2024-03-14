import 'dart:async';

import 'package:flutter/widgets.dart';

class TemporaryOTPProvider with ChangeNotifier {
  List<String> _otpDigits =
      List.filled(6, ''); // Initialize with 6 empty strings
  late List<FocusNode> focusNodes;

  TemporaryOTPProvider() {
    focusNodes = List.generate(6, (index) => FocusNode());
  }

  List<String> get otpDigits => _otpDigits;

  void setOTPText(String value, int index) {
    if (index >= 0 && index < _otpDigits.length) {
      _otpDigits[index] = value;
      notifyListeners();
    }
  }

  String get otpText =>
      _otpDigits.join(); // Join the digits into a single string

  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

class TemporaryCounterProvider with ChangeNotifier {
  int _countdown = 5;
  late Timer _timer;

  CounterProvider() {
    startCountdown();
  }

  int get countdown => _countdown;

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
        } else {
          _countdown--;
          notifyListeners(); // Notify listeners when the countdown changes
        }
      },
    );
  }

  void resetCountdown() {
    _countdown = 5;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
