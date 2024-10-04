int getTone(double angle) {
  int tone;
  if (angle <= 360 - (180 / 13)) {
    tone = angle ~/ (360 / 13);
  } else {
    tone = 0;
  }
  return tone;
}
