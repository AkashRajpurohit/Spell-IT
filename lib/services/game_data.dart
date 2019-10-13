class GameData {
  String levelName;
  List<String> questions;

  GameData({ this.levelName });

  void getQuestions() {
    // TODO: Fetch data from API based on level
    List<String> questions = ["doormat", "mobile", "apple", "horse", "aeroplane", "singer"];

    this.questions = questions;
  }
}