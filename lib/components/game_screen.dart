import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:spell_it/components/alert.dart';

class GameScreen extends StatefulWidget {

  final String question;

  GameScreen({
    @required this.question,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

enum TtsState { playing, stopped }

class _GameScreenState extends State<GameScreen> {
  String question;

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

  void initGame() {
    question = widget.question;
    question = question.replaceRange(0, 1, "_");
    question = question.replaceRange(question.length ~/ 2, question.length ~/ 2 + 1, "_");
    question = question.replaceRange(question.length - 1, question.length, "_");
  }

  @override
  void initState() {
    super.initState();
    initGame();
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$question",
            style: TextStyle(
              fontSize: 45.0,
              letterSpacing: 5.0
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
            child: TextField(
              maxLength: widget.question.length,
              onSubmitted: (value) {
                if(value.toLowerCase() == widget.question.toLowerCase()) {
                  return Alert().showAlert(context, "Correct!", "You got it right!");
                } else {
                  return Alert().showAlert(context, "Wrong!", "Try again!");
                }
              },
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100.0),
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  _speak("${widget.question}");
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.speaker_phone,
                  size: 35.0,
                ),
              )
            )
          )
        ],
      ),
    );
  }
}