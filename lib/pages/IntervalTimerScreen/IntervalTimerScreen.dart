import 'package:first/pages/WorkoutScreen/WorkoutScreen.dart';
import 'package:first/tools/Time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/WorkoutDataModel.dart';
import 'CustomSlider.dart';

class IntervalTimerScreen extends StatelessWidget {
  const IntervalTimerScreen({Key? key}) : super(key: key);
  final customSlider = const CustomSlider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
          child: Consumer<WorkoutDataModel>(
            builder: (context, model, child) => Text(
              '${secondsToClockTime(calculateTotalTime(model))}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          // Text(
          //   // Total Time Display
          //   '28:XX',
          //   style: theme.textTheme.headline1,
          // )
        ),
        RawMaterialButton(
          // Play Button
          onPressed: () {
            // Start Workout.

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkoutScreen()),
            );
          },
          elevation: 2.0,
          fillColor: Colors.red,
          child: Icon(
            Icons.play_circle_outlined,
            color: Colors.white,
            size: 35.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        Expanded(child: ListView(children: <Widget>[CustomSlider()])),
      ],
    ));
  }
}
