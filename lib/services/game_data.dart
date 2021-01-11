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

    String cachedData = prefs.getString('level-$levelName');

    if(cachedData != null) {
      // Check for expiry in cache
      Map cache = json.decode(cachedData);

      var now = new DateTime.now();
      var expiry = DateTime.parse(cache['expiry']);
      var difference = now.difference(expiry);

      // Save cache for only 1 day
      if(difference.inDays > 1) {
        // remove this cache
        prefs.remove('level-$levelName');
        // make api call for new questions
        await makeAPIRequest();
      } else {
        // serve from cache
        this.questions = cache['questions'];
      }
    } else {
      // Make API call
      await makeAPIRequest();
    }
  }

  Future<void> makeAPIRequest() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      Response response = await get('https://mock-server-akash.vercel.app/api/spell-it/level/$levelName');

      Map data = json.decode(response.body);

      this.questions = data['data'];

      Map cacheData = {
        'questions': data['data'],
        'expiry': new DateTime.now().toString()
      };

      prefs.setString('level-$levelName', json.encode(cacheData));
    } on SocketException catch(e) {
      this.questions = [-1];
    } catch(e) {
      print(e);
      this.questions = [-2];
    }
  }
}
