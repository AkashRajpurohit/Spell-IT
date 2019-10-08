import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "This is game screen for ${level.name} Level",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600]
              ),
            )
          ],
        ),
      ),
    );
  }
}