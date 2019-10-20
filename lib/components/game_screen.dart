import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:spell_it/components/alert.dart';
import 'package:spell_it/services/score.dart';

class GameScreen extends StatefulWidget {

  final String question;
  final String level;
  final List<dynamic> gameScoreList;
  final Score gameScore;

  GameScreen({
    @required this.question,
    @required this.level,
    @required this.gameScoreList,
    @required this.gameScore
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

enum TtsState { playing, stopped }

class _GameScreenState extends State<GameScreen> {
  String question;

  FlutterTts flutterTts;

  List<dynamic> gameScoreList;

  bool isSolved = false;

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

  getGameScoreList() {
    if(widget.gameScoreList.contains(widget.question)) {
      isSolved = true;
    }
  }

  void initGame() {
    getGameScoreList();
    question = widget.question;
    int times = (question.length ~/ 2) - 1;
    question = question.replaceRange(1, (question.length ~/ 2), "_" * times);
    question = question.replaceRange((question.length ~/ 2) + 1, question.length % 2 == 0 ? question.length : question.length - 1, "_" * times);
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

    String imageUrl = isSolved ? 'correct.gif' : 'warning.png';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/$imageUrl'),
            radius: 50,
          ),
          SizedBox(height: 10.0),
          Text(
            "$question",
            style: TextStyle(
              fontSize: 45.0,
              letterSpacing: 2.0
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
            child: TextField(
              maxLength: widget.question.length,
              onSubmitted: (value) async {
                if(value.toLowerCase() == widget.question.toLowerCase()) {
                  await widget.gameScore.addScore(value);
                  setState(() {
                    isSolved = true;
                  });
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
            margin: EdgeInsets.only(top: 50.0),
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