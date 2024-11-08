int getNahual(double angle) {
  int nahual;
  if (angle <= 360) {
    nahual = angle ~/ (360 / 20);
  } else {
    nahual = 0;
  }
  return nahual;
}
