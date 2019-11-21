//////////////////////////////////////////////////////////////////////// Imports
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'dart:async';
import 'package:quiver/async.dart';

/////////////////////////////////////////////////////////////// Class: Metronome
class MetronomeWidget extends StatefulWidget {
  final Duration duration;
  final int bpm;
  bool enabled;
  final int number;
  final bool completed;
  Function(int) markAsCompleted;

  MetronomeWidget({
    this.duration,
    this.bpm,
    this.enabled,
    this.number,
    this.markAsCompleted,
    this.completed,
  });

  //============================================================ Behaviour <
  @override
  State<StatefulWidget> createState() => _MetronomeWidgetState();
}

////////////////////////////////////////////////////////// Class: MetronomeState
class _MetronomeWidgetState extends State<MetronomeWidget>
    with SingleTickerProviderStateMixin {
  //================================================================= Data <
  bool color = false;

  Metronome timer;

  List<AudioPlayer> playerAudio;
  List<AudioCache> player;

  StreamSubscription<DateTime> sub;

  double animvalueWhenEntered = 0.0;

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  //============================================================ Behaviour <
  //------------------------------------------------------ Constructors <<
  int currentPlayer = 0;

  AnimationController animcontr;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      animcontr.stop(canceled: false);
      if (sub != null && !sub.isPaused) {
        sub?.pause();
      }
    } else {
      animcontr.forward();
      if (sub != null) {
        if (sub.isPaused) {
          sub?.resume();
          animvalueWhenEntered = animcontr.value;
        }
      }
    }
    Duration left = widget.duration * (1.0 - animcontr.value);
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: <Widget>[
              CircularPercentIndicator(
                  radius: 250,
                  animation: false,
                  animationDuration: 0,
                  lineWidth: 15,
                  percent: animcontr.value,
                  center: !widget.completed
                      ? Text(
                          (left +
                                  (animcontr.value != 0.0
                                      ? Duration(seconds: 1)
                                      : Duration.zero))
                              .toString()
                              .substring(2, 7),
                          style: new TextStyle(
                              color: Colors.black54,
                              fontSize: 36.0,
                              fontWeight:
                                  color ? FontWeight.bold : FontWeight.normal),
                        )
                      : Icon(
                          Icons.done_outline,
                          size: 50,
                          color: Colors.greenAccent,
                        ),
                  circularStrokeCap: CircularStrokeCap.round,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.lightGreenAccent,
                      Colors.greenAccent,
                    ],
                  ),
                  fillColor: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.01)
//                progressColor:
//                    widget.completed ? Colors.greenAccent : Colors.black54,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  var alarmAudioPath = "1.wav";

  Future<void> playAudio() async {
//    player[currentPlayer].play(alarmAudioPath);
    if (widget.duration * (animcontr.value - animvalueWhenEntered) >
        Duration(milliseconds: 250)) {
      player[0].play(
        alarmAudioPath,
        volume: widget.enabled ? 1.0 : 0.0,
        mode: PlayerMode.LOW_LATENCY,
      );
    }
//    currentPlayer = (currentPlayer + 1) % 6;
  }

  void calculateBeatsPerMinute(int bpm) {
//    timer.cancel();
//    print(bpm);
//    timer = new Timer.periodic(
//        Duration(microseconds: (1000.0 * 0.5 / (bpm / 60000.0)).round()),
//        (timer) {
//          playAudio();
//      setState(() {
//        if (color == Colors.white)
//          color = Colors.black;
//        else
//          color = Colors.white;
//      });
//    });
  }

  @override
  void initState() {
    super.initState();

    sub?.cancel();
    sub = null;

    widget.enabled = false;

    timer = new Metronome.periodic(Duration(
        microseconds:
            (1000.0 * 1.0 / (widget.bpm.toDouble() / 60000.0)).round()));

    animcontr = AnimationController(vsync: this, duration: widget.duration);
    animcontr.addListener(() => setState(() {}));
    animcontr.forward();
    animcontr.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.markAsCompleted(widget.number);
      }
    });

    playerAudio = [new AudioPlayer(mode: PlayerMode.LOW_LATENCY)];
    player = [new AudioCache(fixedPlayer: playerAudio[0])];

    for (var i in playerAudio) {
      i.setReleaseMode(ReleaseMode.STOP);
    }
//      for (var i in player) {
////      i.play(alarmAudioPath);
//      }
    player[0].load(alarmAudioPath).whenComplete(() {
      if (sub == null) {
        sub = timer.listen(
          (d) async {
            playAudio();
            setState(() {
              if (widget.completed ||
                  !widget.enabled ||
                  widget.duration * (animcontr.value - animvalueWhenEntered) <
                      Duration(milliseconds: 250)) {
                color = false;
              } else {
                color = !color;
              }
            });
          },
        );
      }
    });
  }

  final Color backgroundColor = Colors.white;

  final TextStyle textStyle = new TextStyle(
    color: Color(0xffe3e8e6),
    fontSize: 24,
  );
}
