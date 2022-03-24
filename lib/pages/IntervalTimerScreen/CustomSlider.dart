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

class CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    // Assign model values to slider???

    return Consumer<WorkoutDataModel>(
        builder: (context, model, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Semantics(
                        label: 'Work',
                        child: SizedBox(
                          width: 64,
                          height: 48,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              final newValue = double.tryParse(value);
                              if (newValue != null && newValue != model.work) {
                                model.changeValue(SliderType.work,
                                    newValue.clamp(1, 300).toInt());
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: model.work.toStringAsFixed(0),
                            ),
                          ),
                        ),
                      ),
                      const Text('Work')
                    ]),
                    Slider(
                      value: model.work.toDouble(),
                      min: 1,
                      max: 300,
                      onChanged: (value) {
                        model.changeValue(SliderType.work, value.toInt());
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Semantics(
                        label: 'Rest',
                        child: SizedBox(
                          width: 64,
                          height: 48,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              final newValue = double.tryParse(value);
                              if (newValue != null && newValue != model.rest) {
                                model.changeValue(SliderType.rest,
                                    newValue.clamp(1, 300).toInt());
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: model.rest.toStringAsFixed(0),
                            ),
                          ),
                        ),
                      ),
                      const Text('Rest')
                    ]),
                    Slider(
                      value: model.rest.toDouble(),
                      min: 1,
                      max: 300,
                      onChanged: (value) {
                        model.changeValue(SliderType.rest, value.toInt());
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Semantics(
                        label: 'Exercise',
                        child: SizedBox(
                          width: 64,
                          height: 48,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              final newValue = double.tryParse(value);
                              if (newValue != null &&
                                  newValue != model.exercise) {
                                model.changeValue(SliderType.exercise,
                                    newValue.clamp(1, 30).toInt());
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: model.exercise.toStringAsFixed(0),
                            ),
                          ),
                        ),
                      ),
                      const Text('Exercise')
                    ]),
                    Slider(
                      value: model.exercise.toDouble(),
                      min: 1,
                      max: 30,
                      onChanged: (value) {
                        model.changeValue(SliderType.exercise, value.toInt());
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Semantics(
                        label: 'Rounds',
                        child: SizedBox(
                          width: 64,
                          height: 48,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              final newValue = double.tryParse(value);
                              if (newValue != null &&
                                  newValue != model.rounds) {
                                model.changeValue(SliderType.rounds,
                                    newValue.clamp(1, 30).toInt());
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: model.rounds.toStringAsFixed(0),
                            ),
                          ),
                        ),
                      ),
                      const Text('Rounds')
                    ]),
                    Slider(
                      value: model.rounds.toDouble(),
                      min: 1,
                      max: 30,
                      onChanged: (value) {
                        model.changeValue(SliderType.rounds, value.toInt());
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Semantics(
                        label: 'Reset',
                        child: SizedBox(
                          width: 64,
                          height: 48,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              final newValue = double.tryParse(value);
                              if (newValue != null && newValue != model.reset) {
                                model.changeValue(SliderType.reset,
                                    newValue.clamp(1, 300).toInt());
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                              text: model.reset.toStringAsFixed(0),
                            ),
                          ),
                        ),
                      ),
                      const Text('Reset')
                    ]),
                    Slider(
                      value: model.reset.toDouble(),
                      min: 1,
                      max: 300,
                      onChanged: (value) {
                        model.changeValue(SliderType.reset, value.toInt());
                      },
                    ),
                  ],
                ),
              ],
            )
            //
            ));
  }
}
