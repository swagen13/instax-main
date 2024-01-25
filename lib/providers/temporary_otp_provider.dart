import 'dart:async';

import 'package:flutter/widgets.dart';

class TemporaryOTPProvider with ChangeNotifier {
  String _otpText = '';
  late List<FocusNode> focusNodes;

  TemporaryOTPProvider() {
    focusNodes = List.generate(6, (index) => FocusNode());
  }

  String get otpText => _otpText;

  void setOTPText(String value) {
    _otpText = value;
    notifyListeners();
  }

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
