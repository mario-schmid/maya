import 'package:flutter/material.dart';

class MayaStyle {
  // Text Field TextStyle
  TextStyle textFieldStyle() {
    return TextStyle(color: Colors.white);
  }

// Text Field InputDecoration
  InputDecoration textFieldInputDecoration(Color mainColor, String labelText) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        // Set border for focused state
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: mainColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white));
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
}
