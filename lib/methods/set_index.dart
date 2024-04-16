import '../globals.dart';

setIndex(int yearIndex, int dayIndex) {
  int l = 0;
  int n = 0;
  int m = 0;
  int o = 0;
  for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
    switch (arrayIndex[yearIndex][dayIndex][2][i]) {
      case 0:
        arrayIndex[yearIndex][dayIndex][4][i] = l;
        l++;
        break;
      case 1:
        arrayIndex[yearIndex][dayIndex][4][i] = n;
        n++;
        break;
      case 2:
        arrayIndex[yearIndex][dayIndex][4][i] = m;
        m++;
        break;
      case 3:
        arrayIndex[yearIndex][dayIndex][4][i] = o;
        o++;
        break;
    }
  }
}
