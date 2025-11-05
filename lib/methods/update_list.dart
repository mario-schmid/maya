import 'dart:convert';

import 'package:maya/data/maya_day.dart';
import 'package:maya/providers/mayadata.dart';

import '../data/maya_alarm.dart';
import '../data/maya_event.dart';
import '../data/maya_location.dart';
import '../data/maya_note.dart';
import '../data/maya_task.dart';
import '../database_handler.dart';

void updateList(
  int oldIndex,
  int newIndex,
  int yearIndex,
  int dayIndex,
  MayaData data,
) {
  final DatabaseHandlerEvents dbHandlerEvents = DatabaseHandlerEvents();
  final DatabaseHandlerNotes dbHandlerNotes = DatabaseHandlerNotes();
  final DatabaseHandlerTasks dbHandlerTasks = DatabaseHandlerTasks();
  final DatabaseHandlerAlarms dbHandlerAlarms = DatabaseHandlerAlarms();
  final DatabaseHandlerArrangements dbHandlerArrangements =
      DatabaseHandlerArrangements();

  if (newIndex > oldIndex) {
    newIndex -= 1;
  }

  Day dayData = data.mayaData[yearIndex]![dayIndex]!;

  Location location = dayData.arrangement.removeAt(oldIndex);
  dayData.arrangement.insert(newIndex, location);

  List<Location> arrangement = dayData.arrangement;

  int elementIndex = 0;

  switch (location.type) {
    case 'event':
      dbHandlerEvents.deleteEvents(yearIndex, dayIndex);
      List<Event> eventList = [];
      List<Map<String, dynamic>> listMapEvents = [];
      for (int i = 0; i < arrangement.length; i++) {
        if (arrangement[i].type == 'event') {
          eventList.add(dayData.eventList[arrangement[i].elementIndex]);
          arrangement[i].elementIndex = elementIndex;
          listMapEvents.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndex,
            'uuid': dayData.eventList[elementIndex].uuid,
            'begin': dayData.eventList[elementIndex].begin,
            'end': dayData.eventList[elementIndex].end,
            'title': dayData.eventList[elementIndex].title,
            'description': dayData.eventList[elementIndex].description,
          });
          elementIndex++;
        }
      }
      data.updateEventList(yearIndex, dayIndex, eventList);
      dbHandlerEvents.insertEventList(listMapEvents);
      break;
    case 'note':
      dbHandlerNotes.deleteNotes(yearIndex, dayIndex);
      List<Note> noteList = [];
      List<Map<String, dynamic>> listMapNotes = [];
      for (int i = 0; i < arrangement.length; i++) {
        if (arrangement[i].type == 'note') {
          noteList.add(dayData.noteList[arrangement[i].elementIndex]);
          arrangement[i].elementIndex = elementIndex;
          listMapNotes.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndex,
            'uuid': dayData.noteList[elementIndex].uuid,
            'entry': dayData.noteList[elementIndex].entry,
          });
          elementIndex++;
        }
      }
      data.updateNoteList(yearIndex, dayIndex, noteList);
      dbHandlerNotes.insertNoteList(listMapNotes);
      break;
    case 'task':
      dbHandlerTasks.deleteTasks(yearIndex, dayIndex);
      List<Task> taskList = [];
      List<Map<String, dynamic>> listMapTasks = [];
      for (int i = 0; i < arrangement.length; i++) {
        if (arrangement[i].type == 'task') {
          taskList.add(dayData.taskList[arrangement[i].elementIndex]);
          arrangement[i].elementIndex = elementIndex;
          listMapTasks.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndex,
            'uuid': dayData.taskList[elementIndex].uuid,
            'description': dayData.taskList[elementIndex].description,
            'isChecked': dayData.taskList[elementIndex].isChecked ? 1 : 0,
          });
          elementIndex++;
        }
      }
      data.updateTaskList(yearIndex, dayIndex, taskList);
      dbHandlerTasks.insertTaskList(listMapTasks);
      break;
    case 'alarm':
      dbHandlerAlarms.deleteAlarms(yearIndex, dayIndex);
      List<MayaAlarm> alarmList = [];
      List<Map<String, dynamic>> listMapAlarms = [];
      for (int i = 0; i < arrangement.length; i++) {
        if (arrangement[i].type == 'alarm') {
          alarmList.add(dayData.alarmList[arrangement[i].elementIndex]);
          arrangement[i].elementIndex = elementIndex;
          listMapAlarms.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndex,
            'uuid': dayData.alarmList[elementIndex].uuid,
            'alarmSettings': dayData.alarmList[elementIndex].alarmSettings,
            'isActive': dayData.alarmList[elementIndex].isActive ? 1 : 0,
          });
          elementIndex++;
        }
      }
      data.updateAlarmList(yearIndex, dayIndex, alarmList);
      dbHandlerAlarms.insertAlarmList(listMapAlarms);
      break;
  }

  List<Map<String, dynamic>> arrangementMaps = dayData.arrangement
      .map((arrangement) => arrangement.toJson())
      .toList();

  dbHandlerArrangements.updateArrangement(
    yearIndex,
    dayIndex,
    jsonEncode(arrangementMaps),
  );
}
