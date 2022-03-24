import 'package:flutter/material.dart';
import '../IntervalTimerScreen/IntervalTimerScreen.dart';

class EntryPointScreen extends StatelessWidget {
  const EntryPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IntervalTimerScreen()),
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
    )));
  }
}
