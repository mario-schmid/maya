import 'package:flutter/material.dart';

class IsChecked extends ChangeNotifier {
  static final _isChecked = List.empty(growable: true);

  //final List<List<bool>> _isChecked =
  //    List.generate(365, (index) => List.empty(growable: true));

  get isChecked => _isChecked;

  void add(int yearIndex, int dayIndex) {
    _isChecked[yearIndex][dayIndex].add(false);
  }

  void change(int yearIndex, int dayIndex, int itemIndex, bool? value) {
    _isChecked[yearIndex][dayIndex][itemIndex] = value!;
    notifyListeners();
  }
}
