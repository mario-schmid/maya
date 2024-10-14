int getDeltaYear(double angle) {
  int dYear = 0;
  if (angle >= -180 / 365) {
    dYear = (angle + 180 / 365) / (360 / 365) ~/ 365;
  } else {
    dYear = -(360 - angle - 180 / 365) / (360 / 365) ~/ 365;
  }
  return dYear;
}
