import 'dart:async';

import 'package:flutter/material.dart';

class Timers with ChangeNotifier {
  int timer = 60;
  bool isResendButtonVisible = false;
  Timer? _timer;

  void startTimer({int? initialSeconds}) {
    // Use the provided initial seconds from the backend if available, otherwise default to 60
    timer = initialSeconds ?? 60;
    isResendButtonVisible = false;
    notifyListeners();

    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer == 0) {
        isResendButtonVisible = true;
        notifyListeners();
        _timer?.cancel();
      } else {
        this.timer--;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
