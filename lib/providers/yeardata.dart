import 'package:flutter/material.dart';

class YearData extends ChangeNotifier {
  static final _yearData = List.empty(growable: true);

  get yearData => _yearData;

  void setEvent(int yearIndex, int dayIndex, int eventIndex, String begin,
      String end, String title, String description) {
    _yearData[yearIndex][dayIndex].eventList[eventIndex].event = [
      begin,
      end,
      title,
      description
    ];
    notifyListeners();
  }

  void setNote(int yearIndex, int dayIndex, int noteIndex, String note) {
    _yearData[yearIndex][dayIndex].noteList[noteIndex] = note;
    notifyListeners();
  }

  void setTask(int yearIndex, int dayIndex, int taskIndex, String task) {
    _yearData[yearIndex][dayIndex].taskList[taskIndex].text = task;
    notifyListeners();
  }

  void setIsChecked(int yearIndex, int dayIndex, int taskIndex, bool? value) {
    _yearData[yearIndex][dayIndex].taskList[taskIndex].isChecked = value!;
    notifyListeners();
  }
}
