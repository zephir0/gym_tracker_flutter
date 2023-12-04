import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _start = 0;
  int _totalWorkoutTime = 0;

  int get start => _start;
  int get totalWorkoutTime => _totalWorkoutTime;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _start++;
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _totalWorkoutTime = _start;
    _start = 0;
    notifyListeners();
  }
}
