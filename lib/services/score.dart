import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score {
  String level;

  Score({ @required this.level });

  Future<List<dynamic>> getScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String scoresString = prefs.getString(this.level);

    if(scoresString == null) {
      scoresString = "[]";
    }

    return json.decode(scoresString);
  }

  Future<void> addScore(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<dynamic> scoreList = await getScore();

    if(!scoreList.contains(value)) {
      scoreList.add(value);
    }

    String updatedScoreString = json.encode(scoreList);

    prefs.setString(this.level, updatedScoreString);
  }
}