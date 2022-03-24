import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/WorkoutDataModel.dart';
// Notification Method

class CustomSliderValueChangeNotification extends Notification {
  final SliderType type;
  final int value;

  CustomSliderValueChangeNotification(this.type, this.value);
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => CustomSliderState();
}

Column sliderWidget(WorkoutDataModel model, String labelText,
    SliderType sliderType, int min, int max) {
  var givenValue = 0;

  switch (sliderType) {
    case SliderType.exercise:
      givenValue = model.exercise;
      break;

    case SliderType.work:
      givenValue = model.work;

      break;
    case SliderType.rest:
      givenValue = model.rest;

      break;
    case SliderType.rounds:
      givenValue = model.rounds;
      break;
    case SliderType.reset:
      givenValue = model.reset;

      break;
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Semantics(
          label: labelText,
          child: SizedBox(
            width: 64,
            height: 48,
            child: TextField(
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                final newValue = double.tryParse(value);
                if (newValue != null && newValue != givenValue) {
                  model.changeValue(
                      sliderType, newValue.clamp(min, max).toInt());
                }
              },
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                text: givenValue.toStringAsFixed(0),
              ),
            ),
          ),
        ),
        Text(labelText)
      ]),
      Slider(
        value: givenValue.toDouble(),
        min: min.toDouble(),
        max: max.toDouble(),
        onChanged: (value) {
          model.changeValue(sliderType, value.toInt());
        },
      ),
    ],
  );
}

class CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    // Assign model values to slider???

    return Consumer<WorkoutDataModel>(
        builder: (context, model, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                sliderWidget(model, 'Work', SliderType.work, 1, 300),
                sliderWidget(model, 'Rest', SliderType.rest, 1, 300),
                sliderWidget(model, 'Exercise', SliderType.exercise, 1, 30),
                sliderWidget(model, 'Rounds', SliderType.rounds, 1, 30),
                sliderWidget(model, 'Reset', SliderType.reset, 1, 300),
              ],
            )
            //
            ));
  }
}
