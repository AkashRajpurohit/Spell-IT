import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spell_it/services/level.dart';

class Score {
  Level level;

  Score({ @required this.level });

  Future<List<String>> getScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String scoresString = prefs.getString(this.level.toString());

    if(scoresString == null) {
      scoresString = "[]";
    }

    return json.decode(scoresString);
  }

  Future<void> addScore(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> scoreList = await getScore();

    scoreList.add(value);

    String updatedScoreString = json.encode(scoreList);

    prefs.setString(this.level.toString(), updatedScoreString);
  }
}