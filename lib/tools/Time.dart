import 'package:first/models/WorkoutDataModel.dart';

int calculateTotalTime(WorkoutDataModel m) {
  return m.rounds * ((m.exercise) * m.work + (m.exercise - 1) * m.rest) +
      (m.rounds - 1) * m.reset;
}

String secondsToClockTime(int s) {
  int hh = 0;
  int mm = 0;

  if (s > 3600) {
    hh = (s ~/ 3600);
    s = s % 3600;
  }
  if (s > 60) {
    mm = (s ~/ 60);
    s = s % 60;
  }

  return '${hh}:${mm}:${s}';
}
