// ////////////////////////////////////////////////////////////////// Imports //
import 'package:flutter/material.dart';
import 'package:inconcinnity/metronome.dart';
import 'dart:ui';

// ////////////////////////////////////////////////////////////////////////// //
class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() => HomeTabState();
}

// ////////////////////////////////////////////////////////////////////////// //
class HomeTabState extends State<HomeTab> {
  List<Exercise> exercises = [
    Exercise('Alternate picking 1', false, Duration(seconds: 10), 100, false),
    Exercise('D#maj7 arpeggio (11th position)', false, Duration(seconds: 15),
        85, false),
    Exercise('A minor arpeggio (5th position)', false, Duration(minutes: 2), 60,
        false),
    Exercise('Alternate picking 2', false, Duration(seconds: 30), 120, false),
    Exercise('Eb phrygian mode', false, Duration(seconds: 45), 80, false)
  ];

  static final _pageController = PageController();

  void markAsCompleted(int i) {
    setState(() {
      exercises[i].completed = true;
      changeMetronomeState(false, i);
    });
  }

  void changeMetronomeState(bool state, int i) {
    setState(() {
      for (int x = 0; x < exercises.length; x++) {
        exercises[x].metronomeEnabled = false;
      }
      exercises[i].metronomeEnabled = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ExerciseView> exer = [];
    for (int i = 0; i < exercises.length; i++) {
      exer.add(ExerciseView(
        title: exercises[i].name,
        tabulature: AssetImage('assets/tab.png'),
        completed: exercises[i].completed,
        duration: exercises[i].duration,
        bpm: exercises[i].bpm,
        metronomeEnabled: exercises[i].metronomeEnabled,
        changeMetronomeState: changeMetronomeState,
        markAsCompleted: markAsCompleted,
        number: i,
      ));
    }
    final pageView = PageView(
      controller: _pageController,
      children: exer,
    );
    return GestureDetector(
        onVerticalDragUpdate: (_) async {
          _pageController.jumpToPage(await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExerciseSelector(
                            exercises: exercises,
                          ))) ??
              _pageController.page);
        },
        child: Scaffold(
          body: pageView,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            height: 60,
            alignment: Alignment.center,
            child: Material(
              child: InkWell(
                child: ProgressPageIndicator(
                  pageController: _pageController,
                  pageCount: exercises.length,
                  primaryColor: Colors.black12,
                  secondaryColor: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}

class ProgressPageIndicator extends AnimatedWidget {
  final PageController pageController;
  final int pageCount;
  final Color primaryColor;
  final Color secondaryColor;
  final num height;

  ProgressPageIndicator({
    @required this.pageController,
    @required this.pageCount,
    @required this.primaryColor,
    @required this.secondaryColor,
    this.height = 40.0,
  }) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (int i = 0; i < pageCount; i++) {
      dots.add(
        new Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          child: Center(
            child: Icon(Icons.lens,
                size: IntTween(begin: 13, end: 12)
                    .lerp(((pageController.page ?? pageController.initialPage)
                                .toDouble() -
                            i)
                        .abs()
                        .clamp(0.0, 1.0))
                    .toDouble(),
                color: ColorTween(begin: Colors.black54, end: Colors.black12)
                    .lerp(((pageController.page ?? pageController.initialPage)
                                .toDouble() -
                            i)
                        .abs()
                        .clamp(0.0, 1.0))),
          ),
        ),
      );
    }
    return Container(
        height: height,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        )
//      child: LinearProgressIndicator(
//        backgroundColor: secondaryColor,
//        valueColor: Tween(begin: primaryColor, end: primaryColor)
//            .animate(kAlwaysCompleteAnimation),
//        value: (pageController.page + 1 ?? pageController.initialPage) /
//            (pageCount - 0),
//      ),
        );
  }
}

class Exercise {
  String name;
  bool completed;
  Duration duration;
  int bpm;
  bool metronomeEnabled = false;

  Exercise(String n, bool b, Duration d, int m, bool metr) {
    name = n;
    completed = b;
    duration = d;
    bpm = m;
    metronomeEnabled = metr;
  }
}

class ExerciseSelector extends StatelessWidget {
  final List<Exercise> exercises;

  ExerciseSelector({this.exercises});

  @override
  Widget build(BuildContext context) {
//    Widget button = Material(child: InkWell(onTap: () => Navigator.pop(context)));
    List<Widget> cards = [];
    for (int i = 0; i < exercises.length; i++) {
      cards.add(
        exercises[i].completed
            ? Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: ListTile(
                  title: Text(
                    exercises[i].name,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  onTap: () => Navigator.pop(context, i),
                  leading: Icon(Icons.done, size: 24, color: Colors.green),
                ),
                color: Colors.greenAccent,
              )
            : Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: ListTile(
                  title: Text(exercises[i].name),
                  onTap: () => Navigator.pop(context, i),
                  leading: Icon(Icons.keyboard_arrow_right,
                      size: 24, color: Colors.black54),
                ),
                color: Colors.white.withOpacity(0.9),
              ),
      );
    }
    return GestureDetector(
      onHorizontalDragEnd: (_) => Navigator.pop(context, null),
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cards,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseView extends StatefulWidget {
  final String title;
  final ImageProvider tabulature;
  final bool completed;
  final Duration duration;
  final int bpm;
  bool metronomeEnabled;
  final int number;

  Function(bool, int) changeMetronomeState;
  Function(int) markAsCompleted;

  ExerciseView({
    @required this.title,
    @required this.tabulature,
    @required this.completed,
    @required this.duration,
    @required this.bpm,
    @required this.metronomeEnabled,
    @required this.changeMetronomeState,
    @required this.markAsCompleted,
    @required this.number,
  });

  @override
  ExerciseViewState createState() => ExerciseViewState();
}

class ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      widget.completed
                          ? Icons.done
                          : Icons.keyboard_arrow_right,
                      color: widget.completed
                          ? Colors.greenAccent
                          : Colors.black87,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ],
              ),
              Divider(
                  height: 25,
                  thickness: 1,
                  color: Colors.black.withOpacity(0.05)),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 200,
                    width: 850,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: widget.tabulature,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                  height: 25,
                  thickness: 1,
                  color: Colors.black.withOpacity(0.05)),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: MetronomeWidget(
                    duration: widget.duration,
                    bpm: widget.bpm,
                    enabled: widget.metronomeEnabled,
                    number: widget.number,
                    markAsCompleted: widget.markAsCompleted,
                    completed: widget.completed,
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 85,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.bpm.toString() + ' bpm',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 75,
                        height: 75,
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: widget.number.toString(),
                            onPressed: () {
                              if (!widget.completed) {
                                setState(() {
                                  widget.changeMetronomeState(
                                    !widget.metronomeEnabled,
                                    widget.number,
                                  );
                                });
                              }
                            },
                            child: Icon(widget.metronomeEnabled
                                ? Icons.pause
                                : Icons.play_arrow),
                            shape: CircleBorder(),
                            elevation: 0,
                            backgroundColor: widget.completed
                                ? Colors.black.withOpacity(0.25)
                                : Colors.black.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.black.withOpacity(0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
