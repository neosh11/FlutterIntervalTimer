import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'slider.dart';

void main() {
  runApp(const MyApp());
}

ThemeData theme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.red,
  // backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,

  // Define the default font family.
  // fontFamily: 'Georgia',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0),
  ),
);

RawMaterialButton HomeButton(BuildContext context) {
  return RawMaterialButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FirstRoute()),
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
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NeoMan Program', theme: theme, home: const EntryPointScreen());
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      }),
    );
  }
}

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
          MaterialPageRoute(builder: (context) => const IntervalTimer()),
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

List<HomeOption> homeOptions = [
  HomeOption(title: 'Leg Day', hint: 'hint', link: 'link'),
  HomeOption(title: 'Pull Day', hint: 'hint', link: 'link'),
  HomeOption(title: 'Push Day', hint: 'hint', link: 'link'),
];

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          restorationId: 'cards_demo_list_view',
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            for (final destination in homeOptions)
              Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TappableCard(homeOption: destination)),
          ],
        ),
      ),
    );
  }
}

class HomeOption {
  const HomeOption({
    required this.title,
    required this.hint,
    required this.link,
  })  : assert(title != null),
        assert(hint != null),
        assert(link != null);

  final String title;
  final String hint;
  final String link;
}

class TappableCard extends StatelessWidget {
  const TappableCard(
      {Key? key, required this.homeOption, this.shape, this.onTapFunction})
      : assert(homeOption != null),
        super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 100.0;
  final HomeOption homeOption;
  final ShapeBorder? shape;
  final void Function()? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: onTapFunction,
          // Generally, material cards use onSurface with 12% opacity for the pressed state.
          splashColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          // Generally, material cards do not have a highlight overlay.
          highlightColor: Colors.red,

          child: SizedBox(
            height: height,
            child: Row(children: [
              Icon(
                Icons.play_circle_outlined,
                color: Colors.white,
                size: 35.0,
              ),
              Text(homeOption.title)
            ]),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => Custom_SliderState();
}

class Custom_SliderState extends State<CustomSlider> with RestorationMixin {
  final RestorableDouble _workValue = RestorableDouble(25);
  final RestorableDouble _restValue = RestorableDouble(25);
  final RestorableDouble _exerciseValue = RestorableDouble(5);
  final RestorableDouble _roundsValue = RestorableDouble(2);
  final RestorableDouble _roundResetValue = RestorableDouble(60);

  @override
  String get restorationId => 'sliders';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_workValue, 'work_value');
    registerForRestoration(_restValue, 'rest_value');
    registerForRestoration(_exerciseValue, 'exercise_value');
    registerForRestoration(_roundsValue, 'rounds_value');
    registerForRestoration(_roundResetValue, 'round_reset_value');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: 'Work',
                  child: SizedBox(
                    width: 64,
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        final newValue = double.tryParse(value);
                        if (newValue != null && newValue != _workValue.value) {
                          setState(() {
                            _workValue.value = newValue.clamp(0, 300) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _workValue.value.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _workValue.value,
                  min: 0,
                  max: 300,
                  onChanged: (value) {
                    setState(() {
                      _workValue.value = value;
                    });
                  },
                ),
                const Text('Work'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: 'Rest',
                  child: SizedBox(
                    width: 64,
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        final newValue = double.tryParse(value);
                        if (newValue != null && newValue != _restValue.value) {
                          setState(() {
                            _restValue.value = newValue.clamp(0, 300) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _restValue.value.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _restValue.value,
                  min: 0,
                  max: 300,
                  onChanged: (value) {
                    setState(() {
                      _restValue.value = value;
                    });
                  },
                ),
                const Text('Rest'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                            newValue != _exerciseValue.value) {
                          setState(() {
                            _exerciseValue.value =
                                newValue.clamp(0, 30) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _exerciseValue.value.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _exerciseValue.value,
                  min: 0,
                  max: 30,
                  onChanged: (value) {
                    setState(() {
                      _exerciseValue.value = value;
                    });
                  },
                ),
                const Text('Exercise'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                            newValue != _roundsValue.value) {
                          setState(() {
                            _roundsValue.value =
                                newValue.clamp(0, 30) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _roundsValue.value.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _roundsValue.value,
                  min: 0,
                  max: 30,
                  onChanged: (value) {
                    setState(() {
                      _roundsValue.value = value;
                    });
                  },
                ),
                const Text('Rounds'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: 'Reset',
                  child: SizedBox(
                    width: 64,
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        final newValue = double.tryParse(value);
                        if (newValue != null &&
                            newValue != _roundResetValue.value) {
                          setState(() {
                            _roundResetValue.value =
                                newValue.clamp(0, 300) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _roundResetValue.value.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider(
                  value: _roundResetValue.value,
                  min: 0,
                  max: 300,
                  onChanged: (value) {
                    setState(() {
                      _roundResetValue.value = value;
                    });
                  },
                ),
                const Text('Reset'),
              ],
            ),
          ],
        )
        //
        );
  }
}

class IntervalTimer extends StatelessWidget {
  const IntervalTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
              child: Text(
                // Total Time Display
                '28:XX',
                style: theme.textTheme.headline1,
              )),
          RawMaterialButton(
            // Play Button
            onPressed: () {},
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
      ),
    );
  }
}
