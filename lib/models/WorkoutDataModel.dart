import 'package:flutter/material.dart';

enum SliderType { work, rest, exercise, rounds, reset }

class WorkoutDataModel with ChangeNotifier {
  int work = 1;
  int rest = 1;
  int exercise = 1;
  int rounds = 1;
  int reset = 1;

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
