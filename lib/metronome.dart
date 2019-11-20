//////////////////////////////////////////////////////////////////////// Imports
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'dart:async';
import 'package:quiver/async.dart';

/////////////////////////////////////////////////////////////// Class: Metronome
class MetronomeWidget extends StatefulWidget {
  //============================================================ Behaviour <
  @override
  State<StatefulWidget> createState() => _MetronomeWidgetState();
}

////////////////////////////////////////////////////////// Class: MetronomeState
class _MetronomeWidgetState extends State<MetronomeWidget> {
  //================================================================= Data <
  Color color = Colors.white;

  Metronome timer;

  //============================================================ Behaviour <
  //------------------------------------------------------ Constructors <<
  static List<AudioPlayer> playerAudio = [
    new AudioPlayer(mode: PlayerMode.LOW_LATENCY)
  ];
  static List<AudioCache> player = [
    new AudioCache(fixedPlayer: playerAudio[0])
  ];
  int currentPlayer = 0;

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

  Future<void> playAudio() async {
//    player[currentPlayer].play(alarmAudioPath);
    await player[0].play(alarmAudioPath);
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
      for (var i in playerAudio) {
        i.setReleaseMode(ReleaseMode.STOP);
      }
//      for (var i in player) {
////      i.play(alarmAudioPath);
//      }
      player[0].load(alarmAudioPath).whenComplete((){
        timer = new Metronome.epoch(
            Duration(microseconds: (1000.0 * 1.0 / (100 / 60000.0)).round()));
        timer.listen((d) {
          playAudio();
          setState(() {
            if (color == Colors.white)
              color = Colors.black;
            else
              color = Colors.white;
          });
        });
      });
    }

    final Color backgroundColor = Colors.white12;

    final TextStyle textStyle = new TextStyle(
      color: Color(0xffe3e8e6),
      fontSize: 40.0,
    );
  }

