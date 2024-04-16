import 'package:alarm/model/alarm_settings.dart';
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

  void setAlarm(int yearIndex, int dayIndex, int alarmIndex,
      AlarmSettings alarmSettings) {
    _yearData[yearIndex][dayIndex].alarmList[alarmIndex].alarmSettings =
        alarmSettings;
    notifyListeners();
  }

  void setIsChecked(int yearIndex, int dayIndex, int taskIndex, bool? value) {
    _yearData[yearIndex][dayIndex].taskList[taskIndex].isChecked = value!;
    notifyListeners();
  }

  void setIsActive(int yearIndex, int dayIndex, int alarmIndex, bool? value) {
    _yearData[yearIndex][dayIndex].alarmList[alarmIndex].isActive = value!;
    notifyListeners();
  }
}
