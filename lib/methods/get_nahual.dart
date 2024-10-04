int getNahuales(double angle) {
  int nahual;
  if (angle <= 351) {
    nahual = angle ~/ (360 / 20);
  } else {
    nahual = 0;
  }
  return nahual;
}
