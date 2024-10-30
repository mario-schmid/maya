import 'package:flutter/material.dart';

class MayaStyle {
  static const TextStyle popUpDialogTitle = TextStyle(
      fontFamily: 'Robot',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  static const TextStyle popUpDialogBody = TextStyle(
      fontFamily: 'Robot',
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  BoxDecoration popUpDialogDecoration(Color mainColor) {
    return BoxDecoration(
        color: mainColor,
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  // EvaluatedButton
  ButtonStyle mainButtonStyle(Color? color) {
    return ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStateProperty.all(color?.withOpacity(0.5)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(
            const BorderSide(color: Colors.white, width: 1)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
        overlayColor: WidgetStateProperty.all(color));
  }

  // EvaluatedButton
  ButtonStyle transparentButtonStyle(Color? overlayColor) {
    return ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(1)),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(
            const BorderSide(color: Colors.white, width: 1)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
        overlayColor: WidgetStateProperty.all(overlayColor));
  }

  //TODO: implement dialogPadding
  double dialogPadding(Size size) {
    return size.width * 0.028;
  }

  //TODO: implement dialogButtonSize
  Size dialogButtonSize(Size size) {
    return Size(size.width * 0.3, size.width * 0.1);
  }
}
