class GameData {
  String levelName;
  List<String> questions;

  GameData({ this.levelName });

  void getQuestions() {
    // TODO: Fetch data from API based on level
    List<String> questions = ["rat", "cat", "mouse", "horse", "aeroplane", "turtle", "doormat"];

    this.questions = questions;
  }
}