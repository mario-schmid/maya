import 'package:flutter/material.dart';
import '../helper/maya_image.dart';

class MayaBase {
  static Image getNahual(String themeNahuales, int index) {
    if (themeNahuales == 'plasma') {
      return MayaImage.signNahualPlasma[index];
    } else {
      return MayaImage.signNahual[index];
    }
  }
}
