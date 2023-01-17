class Utils{
  static  int roundToNearestTens(int num, int step) {
    int divisor = step;
    int output = (num ~/ divisor) * divisor;
    if (output == 0) {
      output += step;
    }
    return output;
  }
}