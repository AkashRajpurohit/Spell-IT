import 'dart:convert';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spell_it/components/alert.dart';

class GameData {
  String levelName;
  List<dynamic> questions;

  GameData({ this.levelName });

  Future<void> getQuestions() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String cachedQuestions = prefs.getString('level-$levelName');

    if(cachedQuestions != null) {
      // Return cached questions
      this.questions = json.decode(cachedQuestions);
    } else {
      // Make API call
      try {
        Response response = await get('https://spell-it-akash.firebaseapp.com/level/$levelName');

        Map data = json.decode(response.body);

        this.questions = data['data'];

        prefs.setString('level-$levelName', json.encode(data['data']));
      } on SocketException catch(e) {
        this.questions = [-1];
      } catch(e) {
        this.questions = [-2];
      }
    }
  }
}