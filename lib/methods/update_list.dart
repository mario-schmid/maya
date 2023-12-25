import 'package:flutter/material.dart';

import '../database_handler.dart';
import '../globals.dart';
import '../methods/set_index.dart';
import '../providers/dayitems.dart';
import '../providers/yeardata.dart';

void updateList(int oldIndex, int newIndex, int yearIndex, int dayIndex) {
  if (newIndex > oldIndex) {
    newIndex -= 1;
  }
  Dismissible item =
      DayItems().dayItems[yearIndex][dayIndex].removeAt(oldIndex);
  DayItems().dayItems[yearIndex][dayIndex].insert(newIndex, item);

  int indexItem = arrayIndex[yearIndex][dayIndex][1].removeAt(oldIndex);
  arrayIndex[yearIndex][dayIndex][1].insert(newIndex, indexItem);

  int arrangementItem = arrayIndex[yearIndex][dayIndex][2].removeAt(oldIndex);
  arrayIndex[yearIndex][dayIndex][2].insert(newIndex, arrangementItem);

  int nummberItem = arrayIndex[yearIndex][dayIndex][3].removeAt(oldIndex);
  arrayIndex[yearIndex][dayIndex][3].insert(newIndex, nummberItem);

  setIndex(yearIndex, dayIndex);

  switch (arrangementItem) {
    case 0:
      DatabaseHandlerEvents().deleteEvents(yearIndex, dayIndex);
      int elementIndexEvent = 0;
      List<Map<String, dynamic>> listMapEvents = [];
      for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
        if (arrayIndex[yearIndex][dayIndex][2][i] == 0) {
          listMapEvents.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexEvent,
            'begin': YearData()
                .yearData[yearIndex][dayIndex]
                .eventList[arrayIndex[yearIndex][dayIndex][3][i]]
                .event[0],
            'end': YearData()
                .yearData[yearIndex][dayIndex]
                .eventList[arrayIndex[yearIndex][dayIndex][3][i]]
                .event[1],
            'title': YearData()
                .yearData[yearIndex][dayIndex]
                .eventList[arrayIndex[yearIndex][dayIndex][3][i]]
                .event[2],
            'description': YearData()
                .yearData[yearIndex][dayIndex]
                .eventList[arrayIndex[yearIndex][dayIndex][3][i]]
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
      for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
        if (arrayIndex[yearIndex][dayIndex][2][i] == 1) {
          listMapNotes.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexNote,
            'note': YearData()
                .yearData[yearIndex][dayIndex]
                .noteList[arrayIndex[yearIndex][dayIndex][3][i]]
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
      for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
        if (arrayIndex[yearIndex][dayIndex][2][i] == 2) {
          listMapTasks.add({
            'yearIndex': yearIndex,
            'dayIndex': dayIndex,
            'elementIndex': elementIndexTask,
            'text': YearData()
                .yearData[yearIndex][dayIndex]
                .taskList[arrayIndex[yearIndex][dayIndex][3][i]]
                .text,
            'isChecked': YearData()
                .yearData[yearIndex][dayIndex]
                .taskList[arrayIndex[yearIndex][dayIndex][3][i]]
                .isChecked
          });
          elementIndexTask++;
        }
      }
      DatabaseHandlerTasks().insertTaskList(listMapTasks);
      break;
  }

  DatabaseHandlerArrangements().updateArrangement(
      yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
}
