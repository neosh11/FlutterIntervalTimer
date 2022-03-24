import 'package:flutter/material.dart';

enum SliderType { work, rest, exercise, rounds, reset }

class WorkoutDataModel with ChangeNotifier {
  int work = 20;
  int rest = 20;
  int exercise = 10;
  int rounds = 4;
  int reset = 60;

  void changeValue(SliderType t, int v) {
    switch (t) {
      case SliderType.work:
        work = v;
        break;
      case SliderType.rest:
        rest = v;
        break;
      case SliderType.exercise:
        exercise = v;
        break;
      case SliderType.rounds:
        rounds = v;
        break;
      case SliderType.reset:
        reset = v;
        break;
      default:
    }

    notifyListeners();
  }
}
