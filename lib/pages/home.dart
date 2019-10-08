import 'package:flutter/material.dart';
import 'package:spell_it/services/game_data.dart';
import 'package:spell_it/services/level.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List <Level> levels = [
    Level(name: "Easy", number: 1, color: Colors.green),
    Level(name: "Medium", number: 2, color: Colors.greenAccent),
    Level(name: "Hard", number: 3, color: Colors.blueAccent),
    Level(name: "Extreme", number: 4, color: Colors.red)
  ];

  void _goToGame(Level level) {
    GameData instance = GameData(levelName: level.name);
    instance.getQuestions();

    Navigator.pushNamed(context, '/game', arguments: {
      'level': level,
      'questions': instance.questions
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spell-IT"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: levels[index].color,
              child: ListTile(
                onTap: () { 
                  _goToGame(levels[index]); 
                },
                title: Text(
                  "${levels[index].name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 5.0
                  ),
                ),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
          );
        },
      )
    );
  }
}