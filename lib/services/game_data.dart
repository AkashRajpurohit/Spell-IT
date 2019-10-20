class GameData {
  String levelName;
  List<String> questions;

  GameData({ this.levelName });

  void getQuestions() {
    if(levelName == "Easy") {
      this.questions = ["dog", "kitten", "sound", "this", "super", "singer"];
    } else if(levelName == "Medium") {
      this.questions = ["doormat", "telephone", "apple", "tomorrow", "aeroplane", "savage"];
    } else if(levelName == "Hard") {
      this.questions = ["penguin", "squirrel", "choir", "colonel", "isthmus", "phenomenon"];
    } else if(levelName == "Extreme") {
      this.questions = ["anathema", "anemone", "defibrillator", "ignominious", "massachusetts", "onomatopoeia"];
    }
  }
}