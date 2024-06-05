import 'package:maya/globals.dart';

setIndex(int yearIndex, int dayIndex) {
  int l = 0;
  int n = 0;
  int m = 0;
  int o = 0;
  for (int i = 0;
      i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
      i++) {
    switch (Globals().arrayIndex[yearIndex][dayIndex][2][i]) {
      case 0:
        Globals().arrayIndex[yearIndex][dayIndex][4][i] = l;
        l++;
        break;
      case 1:
        Globals().arrayIndex[yearIndex][dayIndex][4][i] = n;
        n++;
        break;
      case 2:
        Globals().arrayIndex[yearIndex][dayIndex][4][i] = m;
        m++;
        break;
      case 3:
        Globals().arrayIndex[yearIndex][dayIndex][4][i] = o;
        o++;
        break;
    }
  }
}
