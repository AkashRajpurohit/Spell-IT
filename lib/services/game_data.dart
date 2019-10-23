import 'dart:convert';

import 'package:http/http.dart';

class GameData {
  String levelName;
  List<dynamic> questions;

  GameData({ this.levelName });

  Future<void> getQuestions() async {

    try {
      Response response = await get('https://spell-it-akash.firebaseapp.com/level/$levelName');

      Map data = json.decode(response.body);

      this.questions = data['data'];
    } catch(e) {
      print(e);
      this.questions = ["mango", "kitten", "sound", "tonight", "super", "singer"];
    }
  }
}