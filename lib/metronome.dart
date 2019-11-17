//////////////////////////////////////////////////////////////////////// Imports
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

/////////////////////////////////////////////////////////////// Class: Metronome
class Metronome extends StatefulWidget {
  //============================================================ Behaviour <
  @override
  State<StatefulWidget> createState() => _MetronomeState();
}

////////////////////////////////////////////////////////// Class: MetronomeState
class _MetronomeState extends State<Metronome> {
  //================================================================= Data <
  Color color = Colors.white;

  Timer timer;

  //============================================================ Behaviour <
  //------------------------------------------------------ Constructors <<
  static AudioCache player = new AudioCache();

  _MetronomeState() {
    player.load(alarmAudioPath);
    player.
    timer = new Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        if (color == Colors.white)
          color = Colors.black;
        else
          color = Colors.white;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Metronom',
                style: TextStyle(color: color),
              ),
              TextField(
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'BPM',
                  labelStyle: textStyle,
                ),
                maxLength: 3,
                onSubmitted: (string) {
                  calculateBeatsPerMinute(int.parse(string));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  var alarmAudioPath = "1.wav";

  void calculateBeatsPerMinute(int bpm) {
    setState(() {
      timer.cancel();
      timer = new Timer.periodic(
          Duration(milliseconds: (0.5 / (bpm / 60000)).round()), (timer) {
        setState(() {
          player.play(alarmAudioPath);
          if (color == Colors.white)
            color = Colors.black;
          else
            color = Colors.white;
        });
      });
    });
  }

  final Color backgroundColor = Color(0xff171c1a);

  final TextStyle textStyle = new TextStyle(
    color: Color(0xffe3e8e6),
    fontSize: 40.0,
  );
}
