import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
// local
import 'package:first/pages/IntervalTimerScreen/IntervalTimerScreen.dart';
import 'package:first/tools/Time.dart';
import 'RadialProgress.dart';
// models
import '../../models/WorkoutDataModel.dart';

// Access Model data here and begin workout.

enum Status {
  preWorkout,
  workout,
  breakTime,
  reset,
  finished,
}
enum AudioType { lightWeightBaby, restUp, threeTwoOne, hooray, countDown }

const int timeBeforeStart = 5;

class ProgressModel with ChangeNotifier {
  bool timerPaused = false;
  bool timerStarted = false;
  late Timer timer;

  Status status = Status.preWorkout;
  int currentRound = 1;
  int currentExerciseRest = 1; // odd is exercise, odd is rest.
  int secondValue = 0;
  int totalTime = 0;

  // Needs to know exercise times and stuff too?
  int workTime = 1;
  int restTime = 1;
  int exerciseRest = 1;
  int rounds = 1;
  int resetTime = 1;

  static AudioCache playerCache = AudioCache();
  static AudioPlayer player = AudioPlayer();

  playAudio(AudioType t) async {
    String fileName = 'sounds/levelUp.mp3';
    switch (t) {
      case AudioType.lightWeightBaby:
        fileName = ('sounds/lightweight.m4a');
        break;

      case AudioType.restUp:
        fileName = ('sounds/restUp.m4a');
        break;

      case AudioType.countDown:
        fileName = ('sounds/countDown.m4a');
        break;

      case AudioType.hooray:
        fileName = ('sounds/finished.m4a');
        break;

      default:
        fileName = ('sounds/levelUp.mp3');
    }

    player = await playerCache.play(fileName);
  }

  void initValues(int work, int rest, int exercises, int rounds, int reset) {
    workTime = work;
    restTime = rest;
    exerciseRest = exercises * 2 - 1;
    this.rounds = rounds;
    resetTime = reset;
  }

  void startTimer() {
    // Check if Timer is on.
    if (!timerStarted) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // Manage time here.
        if (!timerPaused) incrementSecond();
      });

      timerStarted = true;
    }
  }

  void pausePlayTimer() {
    timerPaused = !timerPaused;

    if (timerPaused) {
      player.pause();
    } else {
      player.resume();
    }
    notifyListeners();
  }

  void cancelTimer() {
    timer.cancel();
    player.pause();
    notifyListeners();
  }

  void changeStatus(Status s) {
    switch (s) {
      case Status.workout:
        playAudio(AudioType.lightWeightBaby);
        status = Status.workout;
        secondValue = 0;
        break;
      case Status.breakTime:
        playAudio(AudioType.restUp);

        status = Status.breakTime;
        secondValue = 0;
        break;
      case Status.reset:
        playAudio(AudioType.restUp);

        status = Status.reset;
        secondValue = 0;
        break;
      case Status.finished:
        playAudio(AudioType.hooray);
        status = Status.finished;
        cancelTimer();
        break;
    }
  }

  void incrementSecond() {
    secondValue++;
    totalTime++;

    if (status == Status.preWorkout) {
      // countdown
      if (timeBeforeStart > 3 && timeBeforeStart - secondValue == 3) {
        playAudio(AudioType.countDown);
      }

      if (secondValue == timeBeforeStart) {
        changeStatus(Status.workout);
      }
    } else if (status == Status.workout) {
      // countdown
      if (workTime > 3 && workTime - secondValue == 3) {
        playAudio(AudioType.countDown);
      }

      if (secondValue == workTime) {
        // if last exercise
        if (currentExerciseRest == exerciseRest) {
          // If last round finsih
          if (currentRound == rounds) {
            changeStatus(Status.finished);
          } else {
            currentRound++;
            currentExerciseRest = 1;
            changeStatus(Status.reset);
          }
        } else {
          // move to rest mode
          currentExerciseRest++;
          changeStatus(Status.breakTime);
        }
      }
    } else if (status == Status.breakTime) {
      // countdown
      if (restTime > 3 && restTime - secondValue == 3) {
        playAudio(AudioType.countDown);
      }

      if (secondValue == restTime) {
        changeStatus(Status.workout);
        currentExerciseRest++;
      }
    } else if (status == Status.reset) {
      // countdown
      if (resetTime > 3 && resetTime - secondValue == 3) {
        playAudio(AudioType.countDown);
      }

      if (resetTime == secondValue) {
        changeStatus(Status.workout);
      }
    }

    notifyListeners();
  }
}

MaterialColor getBackgroundColor(Status s) {
  var bg = Colors.amber;
  switch (s) {
    case Status.workout:
      bg = Colors.green;
      break;

    case Status.breakTime:
      bg = Colors.red;
      break;

    case Status.finished:
      bg = Colors.pink;
      break;

    default:
      break;
  }

  return bg;
}

int getRemainingTime(ProgressModel m) {
  switch (m.status) {
    case Status.workout:
      return m.workTime;
    case Status.breakTime:
      return m.restTime;
    case Status.preWorkout:
      return timeBeforeStart;
    case Status.reset:
      return m.resetTime;
    default:
      return 0;
  }
}

Icon getPlayPauseButton(ProgressModel m) {
  return m.timerPaused
      ? const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 35.0,
        )
      : const Icon(
          Icons.pause,
          color: Colors.white,
          size: 35.0,
        );
}

String getDisplayString(ProgressModel m) {
  switch (m.status) {
    case Status.workout:
      return "Working!";
    case Status.breakTime:
      return "Rest Up!";
    case Status.preWorkout:
      return "Get Ready!";
    case Status.reset:
      return "Rest Up!";
    default:
      return "Finished!";
  }
}

Column _finishedDisplay(BuildContext context, ProgressModel model) {
  return (Column(children: [
    Text(
      getDisplayString(model),
      style: Theme.of(context).textTheme.headline2,
    ),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RawMaterialButton(
        // Play Button
        onPressed: () {
          model.cancelTimer();
          // naviage off
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const IntervalTimerScreen()),
          );
        },
        elevation: 2.0,
        fillColor: Colors.red,
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    ])
  ]));
}

Center radialProgressWithNumber(BuildContext context, ProgressModel model) {
  var col = model.status == Status.breakTime ? Colors.green : Colors.red;
  var remainingTime = getRemainingTime(model) - model.secondValue;

  var wTime = 100.0;
  switch (model.status) {
    case Status.preWorkout:
      wTime = timeBeforeStart.toDouble();
      break;
    case Status.workout:
      wTime = model.workTime.toDouble();
      break;
    case Status.breakTime:
      wTime = model.restTime.toDouble();
      break;
    case Status.reset:
      wTime = model.resetTime.toDouble();
      break;
    case Status.finished:
      break;
  }
  var filledRad = model.secondValue / wTime * 360;
  return Center(
    child: Container(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: MyPainter(filledRad, col),
        child: Container(
            child: Center(
                child: Text(
          '$remainingTime',
          style: remainingTime > 99
              ? Theme.of(context).textTheme.headline3
              : Theme.of(context).textTheme.headline1,
        ))),
      ),
    ),
  );
}

Column _ongoingDisplay(
    BuildContext context, ProgressModel model, WorkoutDataModel wOModel) {
  return (Column(children: [
    const SizedBox(height: 80),

    Text(
      getDisplayString(model),
      style: Theme.of(context).textTheme.headline2,
    ),
    const SizedBox(height: 100),
    radialProgressWithNumber(context, model),

    const SizedBox(height: 100),
    Text(
      '${secondsToClockTime(calculateTotalTime(wOModel) + timeBeforeStart - model.totalTime)} remaining',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    const SizedBox(height: 50),

    // Button Row
    _buttonRow(context, model)
  ]));
}

Row _buttonRow(BuildContext context, ProgressModel model) {
  return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RawMaterialButton(
          // Play Button
          onPressed: () {
            model.pausePlayTimer();
          },
          elevation: 2.0,
          fillColor: Colors.red,
          child: Icon(
            (model.timerPaused ? Icons.play_arrow : Icons.pause),
            color: Colors.white,
            size: 35.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          // Play Button
          onPressed: () {
            model.cancelTimer();
            // naviage off
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IntervalTimerScreen()),
            );
          },
          elevation: 2.0,
          fillColor: Colors.red,
          child: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 35.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
      ]);
}

// Local Model needed
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgressModel progressModel = ProgressModel();

    var wOModel = Provider.of<WorkoutDataModel>(context, listen: false);
    progressModel.initValues(wOModel.work, wOModel.rest, wOModel.exercise,
        wOModel.rounds, wOModel.reset);

    progressModel.startTimer();
    return ChangeNotifierProvider(
        create: (context) => progressModel,
        child: Consumer<ProgressModel>(
            builder: (context, model, child) => Scaffold(
                backgroundColor: getBackgroundColor(model.status),
                body: model.status == Status.finished
                    ? _finishedDisplay(context, model)
                    : _ongoingDisplay(context, model, wOModel))));
  }
}
