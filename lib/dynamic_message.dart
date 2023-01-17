import 'package:snakegame/share_pref.dart';

class Score {
  static getDynamicMessage(int score) async {
    int oldScore = await SharedPref.getScore();

    if (score == 0) {
      return "Opps😭😭😭 better luck next time";
    }
    if (score > oldScore) {
      return "You get highest score😍😍😍";
    }
    if (score == oldScore) {
      return "😁😁keep it up, you get same score";
    }
    return "☺☺ keep playing";
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
