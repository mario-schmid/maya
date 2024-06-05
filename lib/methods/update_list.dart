import 'package:flutter/material.dart';
import 'package:maya/globals.dart';

import '../database_handler.dart';
import '../methods/set_index.dart';
import '../providers/dayitems.dart';
import '../providers/mayadata.dart';

void updateList(int oldIndex, int newIndex, int yearIndex, int dayIndex) {
  if (newIndex > oldIndex) {
    newIndex -= 1;
  }
  Dismissible item =
      DayItems().dayItems[yearIndex][dayIndex].removeAt(oldIndex);
  DayItems().dayItems[yearIndex][dayIndex].insert(newIndex, item);

  int indexItem =
      Globals().arrayIndex[yearIndex][dayIndex][1].removeAt(oldIndex);
  Globals().arrayIndex[yearIndex][dayIndex][1].insert(newIndex, indexItem);

  int arrangementItem =
      Globals().arrayIndex[yearIndex][dayIndex][2].removeAt(oldIndex);
  Globals()
      .arrayIndex[yearIndex][dayIndex][2]
      .insert(newIndex, arrangementItem);

  int nummberItem =
      Globals().arrayIndex[yearIndex][dayIndex][3].removeAt(oldIndex);
  Globals().arrayIndex[yearIndex][dayIndex][3].insert(newIndex, nummberItem);

  setIndex(yearIndex, dayIndex);

  switch (arrangementItem) {
    case 0:
      DatabaseHandlerEvents().deleteEvents(yearIndex, dayIndex);
      int elementIndexEvent = 0;
      List<Map<String, dynamic>> listMapEvents = [];
      for (int i = 0;
          i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
          i++) {
        if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 0) {
          listMapEvents.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexEvent,
            'begin': MayaData()
                .mayaData[yearIndex][dayIndex]
                .eventList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .event[0],
            'end': MayaData()
                .mayaData[yearIndex][dayIndex]
                .eventList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .event[1],
            'title': MayaData()
                .mayaData[yearIndex][dayIndex]
                .eventList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .event[2],
            'description': MayaData()
                .mayaData[yearIndex][dayIndex]
                .eventList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .event[3]
          });
          elementIndexEvent++;
        }
      }
      DatabaseHandlerEvents().insertEventList(listMapEvents);
      break;
    case 1:
      DatabaseHandlerNotes().deleteNotes(yearIndex, dayIndex);
      int elementIndexNote = 0;
      List<Map<String, dynamic>> listMapNotes = [];
      for (int i = 0;
          i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
          i++) {
        if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 1) {
          listMapNotes.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexNote,
            'note': MayaData()
                .mayaData[yearIndex][dayIndex]
                .noteList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
          });
          elementIndexNote++;
        }
      }
      DatabaseHandlerNotes().insertNoteList(listMapNotes);
      break;
    case 2:
      DatabaseHandlerTasks().deleteTasks(yearIndex, dayIndex);
      int elementIndexTask = 0;
      List<Map<String, dynamic>> listMapTasks = [];
      for (int i = 0;
          i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
          i++) {
        if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 2) {
          listMapTasks.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexTask,
            'text': MayaData()
                .mayaData[yearIndex][dayIndex]
                .taskList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .text,
            'isChecked': MayaData()
                    .mayaData[yearIndex][dayIndex]
                    .taskList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                    .isChecked
                ? 1
                : 0
          });
          elementIndexTask++;
        }
      }
      DatabaseHandlerTasks().insertTaskList(listMapTasks);
      break;
    case 3:
      DatabaseHandlerAlarms().deleteAlarms(yearIndex, dayIndex);
      int elementIndexAlarm = 0;
      List<Map<String, dynamic>> listMapAlarms = [];
      for (int i = 0;
          i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
          i++) {
        if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 3) {
          listMapAlarms.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexAlarm,
            'alarmSettings': MayaData()
                .mayaData[yearIndex][dayIndex]
                .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                .alarmSettings,
            'isActive': MayaData()
                    .mayaData[yearIndex][dayIndex]
                    .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                    .isActive
                ? 1
                : 0
          });
          elementIndexAlarm++;
        }
      }
      DatabaseHandlerAlarms().insertAlarmList(listMapAlarms);
      break;
  }

  DatabaseHandlerArrangements().updateArrangement(yearIndex, dayIndex,
      Globals().arrayIndex[yearIndex][dayIndex][2].toString());
}
