import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  static setScore(int score) async {
    final instance = await SharedPreferences.getInstance();

    instance.setInt("score", score);
  }

  static Future<int> getScore() async {
    final instance = await SharedPreferences.getInstance();

    int score = instance.getInt("score") ?? 0;
    return  score;
  }
}
