import 'package:flutter/material.dart';

class MayaStyle {
  TextStyle popUpdialogTitle() {
    return const TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none);
  }

  TextStyle popUpdialogBody() {
    return const TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none);
  }

  Decoration popUpDialogDecoration() {
    return BoxDecoration(
        color: Colors.pink[900],
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }

  ButtonStyle dialogButtonStyle(Color? overlayColor) {
    return ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.all(1)),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        side: MaterialStateProperty.all(
            const BorderSide(color: Colors.white, width: 1)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
        overlayColor: MaterialStateProperty.all(overlayColor));
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
