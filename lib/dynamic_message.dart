import 'package:snakegame/share_pref.dart';

class Score {
  static getDynamicMessage(int score) async {
    int oldScore = await SharedPref.getScore();

    if (score == 0) {
      return "Opps๐ญ๐ญ๐ญ better luck next time";
    }
    if (score > oldScore) {
      return "You get highest score๐๐๐";
    }
    if (score == oldScore) {
      return "๐๐keep it up, you get same score";
    }
    return "โบโบ keep playing";
  }

  static saveScore(int score) async {
    if (score != 0) {
      int oldScore = await SharedPref.getScore();
      if (oldScore < score) {
        SharedPref.setScore(score);
      }
    }
  }
}
