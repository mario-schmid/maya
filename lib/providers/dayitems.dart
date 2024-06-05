import 'package:flutter/material.dart';

class DayItems extends ChangeNotifier {
  static final Map<int, Map<int, List<Dismissible>>> _dayItems =
      <int, Map<int, List<Dismissible>>>{};

  get dayItems => _dayItems;

  void add(int yearIndex, int dayIndex, Dismissible item) {
    _dayItems[yearIndex]![dayIndex]!.add(item);
    notifyListeners();
  }

  void removeAt(int yearIndex, int dayIndex, int itemIndex) {
    _dayItems[yearIndex]![dayIndex]!.removeAt(itemIndex);
    notifyListeners();
  }
}
