import 'package:flutter/material.dart';
import 'package:spell_it/services/game_data.dart';
import 'package:spell_it/services/level.dart';
import 'package:spell_it/services/score.dart';
import 'package:spell_it/components/alert.dart';

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

  bool isLoading = false;

  Future<dynamic> canGoToNextLevel(int currentLevelNumber) async {
    if(currentLevelNumber == 1) {
      return true;
    }

    Level prevLevel = levels[currentLevelNumber - 2];
    
    GameData prevData = GameData(levelName: prevLevel.name);

    await prevData.getQuestions();

    if(prevData.questions[0] == -1) {
      setState(() {
        isLoading = false;
      });
      return Alert().showAlert(context, "Error!", "Please ensure you have an active internet connection!");
    } else if(prevData.questions[0] == -2) {
      setState(() {
        isLoading = false;
      });
      return Alert().showAlert(context, "Error!", "Something went wrong. Please try again later");
    }

    Score gameScore = Score(level: prevLevel.name);

    List<dynamic> gameScoreList = await gameScore.getScore();

    int totalQuestions = prevData.questions.length;
    int totalSolved = gameScoreList.length;

    // If user has solved more than 60% of questions from previous level then only allow to go for next level
    if((totalSolved / totalQuestions) * 100 > 60.0) {
      return true;
    }

    return false;
  }

  dynamic _goToGame(Level level) async {
    setState(() {
      isLoading = true;
    });

    if(await canGoToNextLevel(level.number)) {
      GameData instance = GameData(levelName: level.name);

      await instance.getQuestions();

      print(instance.questions);

      if(instance.questions[0] == -1) {
        Alert().showAlert(context, "Error!", "Please ensure you have an active internet connection!");
        setState(() {
          isLoading = false;
        });
        return;
      } else if(instance.questions[0] == -2) {
        Alert().showAlert(context, "Error!", "Something went wrong. Please try again later");
        setState(() {
          isLoading = false;
        });
        return;
      }

      Score gameScore = Score(level: level.name);

      List<dynamic> gameScoreList = await gameScore.getScore();

      Navigator.pushNamed(context, '/game', arguments: {
        'level': level,
        'questions': instance.questions,
        'gameScoreList': gameScoreList,
        'gameScore': gameScore
      });
    } else {
      Alert().showAlert(context, "Oops!", "Please finish 60% of questions from ${levels[level.number - 2].name} level to unlock ${level.name} level!");
    }

    setState(() {
      isLoading = false;
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
            !isLoading ? Expanded(
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
            ) : Center(
              heightFactor: 10.0,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              )
            )
          ],
        ),
      )
    );
  }
}