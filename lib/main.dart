import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Models
import 'models/WorkoutDataModel.dart';

// Screens
import 'pages/IntervalTimerScreen/IntervalTimerScreen.dart';
import 'themes/Theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WorkoutDataModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NeoMan Program',
        theme: theme,
        home: const IntervalTimerScreen());
  }
}
