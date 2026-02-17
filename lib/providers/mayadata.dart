import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

import '../data/maya_day.dart';
import '../data/maya_alarm.dart';
import '../data/maya_event.dart';
import '../data/maya_note.dart';
import '../data/maya_task.dart';

class MayaData extends ChangeNotifier {
  static final Map<int, Map<int, Day>> _mayaData = {};

  Map<int, Map<int, Day>> get mayaData => _mayaData;

  void addEvent(
    int yearIndex,
    int dayIndex,
    String uuid,
    String begin,
    String end,
    String title,
    String description,
  ) {
    _mayaData[yearIndex]![dayIndex]!.eventList.add(
      Event(uuid, begin, end, title, description),
    );
    notifyListeners();
  }

  void updateEvent(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String begin,
    String end,
    String title,
    String description,
  ) {
    Event? event = _mayaData[yearIndex]![dayIndex]!.eventList[elementIndex];
    event.begin = begin;
    event.end = end;
    event.title = title;
    event.description = description;
    notifyListeners();
  }

  void updateEventList(int yearIndex, int dayIndex, List<Event> eventList) {
    _mayaData[yearIndex]![dayIndex]!.eventList = eventList;
    notifyListeners();
  }

  void removeEvent(int yearIndex, int dayIndex, int elementIndex) {
    _mayaData[yearIndex]![dayIndex]!.eventList.removeAt(elementIndex);
    notifyListeners();
  }

  void addNote(int yearIndex, int dayIndex, String uuid, String entry) {
    _mayaData[yearIndex]![dayIndex]!.noteList.add(Note(uuid, entry));
    notifyListeners();
  }

  void updateNote(int yearIndex, int dayIndex, int elementIndex, String entry) {
    _mayaData[yearIndex]![dayIndex]!.noteList[elementIndex].entry = entry;
    notifyListeners();
  }

  void updateNoteList(int yearIndex, int dayIndex, List<Note> noteList) {
    _mayaData[yearIndex]![dayIndex]!.noteList = noteList;
    notifyListeners();
  }

  void removeNote(int yearIndex, int dayIndex, int elementIndex) {
    _mayaData[yearIndex]![dayIndex]!.noteList.removeAt(elementIndex);
    notifyListeners();
  }

  void addTask(int yearIndex, int dayIndex, String uuid, String description) {
    _mayaData[yearIndex]![dayIndex]!.taskList.add(
      Task(uuid, description, false),
    );
    notifyListeners();
  }

  void updateTask(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String description,
  ) {
    _mayaData[yearIndex]![dayIndex]!.taskList[elementIndex].description =
        description;
    notifyListeners();
  }

  void updateTaskList(int yearIndex, int dayIndex, List<Task> taskList) {
    _mayaData[yearIndex]![dayIndex]!.taskList = taskList;
    notifyListeners();
  }

  void removeTask(int yearIndex, int dayIndex, int elementIndex) {
    _mayaData[yearIndex]![dayIndex]!.taskList.removeAt(elementIndex);
    notifyListeners();
  }

  void setIsChecked(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    bool? value,
  ) {
    _mayaData[yearIndex]![dayIndex]!.taskList[elementIndex].isChecked = value!;
    notifyListeners();
  }

  void addAlarm(
    int yearIndex,
    int dayIndex,
    String uuid,
    AlarmSettings alarmSettings,
  ) {
    _mayaData[yearIndex]![dayIndex]!.alarmList.add(
      MayaAlarm(uuid, alarmSettings, true),
    );
    notifyListeners();
  }

  void updateAlarm(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    AlarmSettings alarmSettings,
  ) {
    _mayaData[yearIndex]![dayIndex]!.alarmList[elementIndex].alarmSettings =
        alarmSettings;
    notifyListeners();
  }

  void updateAlarmList(int yearIndex, int dayIndex, List<MayaAlarm> alarmList) {
    _mayaData[yearIndex]![dayIndex]!.alarmList = alarmList;
    notifyListeners();
  }

  void removeAlarm(int yearIndex, int dayIndex, int elementIndex) {
    _mayaData[yearIndex]![dayIndex]!.alarmList.removeAt(elementIndex);
    notifyListeners();
  }

  void setIsActive(int yearIndex, int dayIndex, int elementIndex, bool? value) {
    _mayaData[yearIndex]![dayIndex]!.alarmList[elementIndex].isActive = value!;
    notifyListeners();
  }

  void clearAllData() {
    _mayaData.clear();
    notifyListeners();
  }
}
