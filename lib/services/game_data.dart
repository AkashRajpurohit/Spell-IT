import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:spell_it/components/alert.dart';

class GameData {
  String levelName;
  List<dynamic> questions;

  GameData({ this.levelName });

  Future<void> getQuestions() async {

    try {
      Response response = await get('https://spell-it-akash.firebaseapp.com/level/$levelName');

      Map data = json.decode(response.body);

      this.questions = data['data'];
    } on SocketException catch(e) {
      this.questions = [-1];
    } catch(e) {
      this.questions = [-2];
    }
  }
}