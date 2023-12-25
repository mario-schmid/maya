import 'package:flutter/material.dart';

class DayItems extends ChangeNotifier {
  static final _dayItems = List.empty(growable: true);

  get dayItems => _dayItems;

  void add(int yearIndex, int dayIndex, Dismissible item) {
    _dayItems[yearIndex][dayIndex].add(item);
    notifyListeners();
  }

  void removeAt(int yearIndex, int dayIndex, int itemIndex) {
    _dayItems[yearIndex][dayIndex].removeAt(itemIndex);
    notifyListeners();
  }
}
