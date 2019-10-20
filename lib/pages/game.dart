import 'package:flutter/material.dart';
import 'package:spell_it/components/game_screen.dart';
import 'package:spell_it/services/level.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  dynamic data;
  Level level;
  List<String> questions;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    level = data['level'];
    questions = data['questions'];

    return Scaffold(
      appBar: AppBar(
        title: Text('${level.name} Level'),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return GameScreen(question: questions[index], level: level.number.toString());
        },
      ),
    );
  }
}