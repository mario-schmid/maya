import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:maya/data/maya_day.dart';

class MayaData extends ChangeNotifier {
  static final Map<int, Map<int, Day>> _mayaData = {};

  get mayaData => _mayaData;

  void setEvent(int yearIndex, int dayIndex, int eventIndex, String begin,
      String end, String title, String description) {
    _mayaData[yearIndex]![dayIndex]!.eventList[eventIndex].event = [
      begin,
      end,
      title,
      description
    ];
    notifyListeners();
  }

  void setNote(int yearIndex, int dayIndex, int noteIndex, String note) {
    _mayaData[yearIndex]![dayIndex]!.noteList[noteIndex] = note;
    notifyListeners();
  }

  void setTask(int yearIndex, int dayIndex, int taskIndex, String task) {
    _mayaData[yearIndex]![dayIndex]!.taskList[taskIndex].text = task;
    notifyListeners();
  }

  void setAlarm(int yearIndex, int dayIndex, int alarmIndex,
      AlarmSettings alarmSettings) {
    _mayaData[yearIndex]![dayIndex]!.alarmList[alarmIndex].alarmSettings =
        alarmSettings;
    notifyListeners();
  }

  void setIsChecked(int yearIndex, int dayIndex, int taskIndex, bool? value) {
    _mayaData[yearIndex]![dayIndex]!.taskList[taskIndex].isChecked = value!;
    notifyListeners();
  }

  void setIsActive(int yearIndex, int dayIndex, int alarmIndex, bool? value) {
    _mayaData[yearIndex]![dayIndex]!.alarmList[alarmIndex].isActive = value!;
    notifyListeners();
  }
}
