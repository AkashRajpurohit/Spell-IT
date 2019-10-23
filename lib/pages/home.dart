import 'package:flutter/material.dart';
import 'package:spell_it/services/game_data.dart';
import 'package:spell_it/services/level.dart';
import 'package:spell_it/services/score.dart';

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

  void _goToGame(Level level) async {
    GameData instance = GameData(levelName: level.name);
    await instance.getQuestions();

    Score gameScore = Score(level: level.name);

    List<dynamic> gameScoreList = await gameScore.getScore();

    Navigator.pushNamed(context, '/game', arguments: {
      'level': level,
      'questions': instance.questions,
      'gameScoreList': gameScoreList,
      'gameScore': gameScore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spell-IT"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 0.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                radius: 100.0,
              ),
            ),
            Expanded(
                child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return Center(
                    child: Card(
                      color: levels[index].color,
                      child: ListTile(
                        onTap: () {
                          _goToGame(levels[index]);
                        },
                        title: Center(
                          child: Text(
                            "${levels[index].name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              letterSpacing: 5.0
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0)
                      ),
                    )
                  );
                }),
              ),
            ),
          ],
        ),
      )
    );
  }
}