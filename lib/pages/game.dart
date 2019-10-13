import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:spell_it/components/game_screen.dart';
import 'package:spell_it/services/level.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

enum TtsState { playing, stopped }

class _GameState extends State<Game> {
  dynamic data;
  Level level;
  List<String> questions;
  FlutterTts flutterTts;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  Future _speak(String word) async {
    await flutterTts.speak(word);
  }

  initTts() {
    flutterTts = new FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    _setVolume();
  }

  _setVolume() async {
    await flutterTts.setVolume(1.0);
  }

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    level = data['level'];
    questions = data['questions'];

    print(level.name);
    print(questions);

    return Scaffold(
      appBar: AppBar(
        title: Text('${level.name} Level'),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return GameScreen();
        },
      ),
    );
  }
}