import 'package:flutter/material.dart';
import 'package:maya/database_handler.dart';
import 'package:maya/globals.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:maya/providers/mayadata.dart';

class Methods {
  int getDeldaYear(double angle) {
    int dYear = 0;
    if (angle >= -180 / 365) {
      dYear = (angle + 180 / 365) / (360 / 365) ~/ 365;
    } else {
      dYear = -(360 - angle - 180 / 365) / (360 / 365) ~/ 365;
    }
    return dYear;
  }

  List<int> getHaabDate(int haabDays) {
    return [haabDays % 20, haabDays ~/ 20];
  }

  int getKinNummber(int tone, int nahual) {
    List<List<int>> array = [
      [0, 0],
      [1, 1],
      [2, 2],
      [3, 3],
      [4, 4],
      [5, 5],
      [6, 6],
      [7, 7],
      [8, 8],
      [9, 9],
      [10, 10],
      [11, 11],
      [12, 12],
      [0, 13],
      [1, 14],
      [2, 15],
      [3, 16],
      [4, 17],
      [5, 18],
      [6, 19],
      [7, 0],
      [8, 1],
      [9, 2],
      [10, 3],
      [11, 4],
      [12, 5],
      [0, 6],
      [1, 7],
      [2, 8],
      [3, 9],
      [4, 10],
      [5, 11],
      [6, 12],
      [7, 13],
      [8, 14],
      [9, 15],
      [10, 16],
      [11, 17],
      [12, 18],
      [0, 19],
      [1, 0],
      [2, 1],
      [3, 2],
      [4, 3],
      [5, 4],
      [6, 5],
      [7, 6],
      [8, 7],
      [9, 8],
      [10, 9],
      [11, 10],
      [12, 11],
      [0, 12],
      [1, 13],
      [2, 14],
      [3, 15],
      [4, 16],
      [5, 17],
      [6, 18],
      [7, 19],
      [8, 0],
      [9, 1],
      [10, 2],
      [11, 3],
      [12, 4],
      [0, 5],
      [1, 6],
      [2, 7],
      [3, 8],
      [4, 9],
      [5, 10],
      [6, 11],
      [7, 12],
      [8, 13],
      [9, 14],
      [10, 15],
      [11, 16],
      [12, 17],
      [0, 18],
      [1, 19],
      [2, 0],
      [3, 1],
      [4, 2],
      [5, 3],
      [6, 4],
      [7, 5],
      [8, 6],
      [9, 7],
      [10, 8],
      [11, 9],
      [12, 10],
      [0, 11],
      [1, 12],
      [2, 13],
      [3, 14],
      [4, 15],
      [5, 16],
      [6, 17],
      [7, 18],
      [8, 19],
      [9, 0],
      [10, 1],
      [11, 2],
      [12, 3],
      [0, 4],
      [1, 5],
      [2, 6],
      [3, 7],
      [4, 8],
      [5, 9],
      [6, 10],
      [7, 11],
      [8, 12],
      [9, 13],
      [10, 14],
      [11, 15],
      [12, 16],
      [0, 17],
      [1, 18],
      [2, 19],
      [3, 0],
      [4, 1],
      [5, 2],
      [6, 3],
      [7, 4],
      [8, 5],
      [9, 6],
      [10, 7],
      [11, 8],
      [12, 9],
      [0, 10],
      [1, 11],
      [2, 12],
      [3, 13],
      [4, 14],
      [5, 15],
      [6, 16],
      [7, 17],
      [8, 18],
      [9, 19],
      [10, 0],
      [11, 1],
      [12, 2],
      [0, 3],
      [1, 4],
      [2, 5],
      [3, 6],
      [4, 7],
      [5, 8],
      [6, 9],
      [7, 10],
      [8, 11],
      [9, 12],
      [10, 13],
      [11, 14],
      [12, 15],
      [0, 16],
      [1, 17],
      [2, 18],
      [3, 19],
      [4, 0],
      [5, 1],
      [6, 2],
      [7, 3],
      [8, 4],
      [9, 5],
      [10, 6],
      [11, 7],
      [12, 8],
      [0, 9],
      [1, 10],
      [2, 11],
      [3, 12],
      [4, 13],
      [5, 14],
      [6, 15],
      [7, 16],
      [8, 17],
      [9, 18],
      [10, 19],
      [11, 0],
      [12, 1],
      [0, 2],
      [1, 3],
      [2, 4],
      [3, 5],
      [4, 6],
      [5, 7],
      [6, 8],
      [7, 9],
      [8, 10],
      [9, 11],
      [10, 12],
      [11, 13],
      [12, 14],
      [0, 15],
      [1, 16],
      [2, 17],
      [3, 18],
      [4, 19],
      [5, 0],
      [6, 1],
      [7, 2],
      [8, 3],
      [9, 4],
      [10, 5],
      [11, 6],
      [12, 7],
      [0, 8],
      [1, 9],
      [2, 10],
      [3, 11],
      [4, 12],
      [5, 13],
      [6, 14],
      [7, 15],
      [8, 16],
      [9, 17],
      [10, 18],
      [11, 19],
      [12, 0],
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 4],
      [4, 5],
      [5, 6],
      [6, 7],
      [7, 8],
      [8, 9],
      [9, 10],
      [10, 11],
      [11, 12],
      [12, 13],
      [0, 14],
      [1, 15],
      [2, 16],
      [3, 17],
      [4, 18],
      [5, 19],
      [6, 0],
      [7, 1],
      [8, 2],
      [9, 3],
      [10, 4],
      [11, 5],
      [12, 6],
      [0, 7],
      [1, 8],
      [2, 9],
      [3, 10],
      [4, 11],
      [5, 12],
      [6, 13],
      [7, 14],
      [8, 15],
      [9, 16],
      [10, 17],
      [11, 18],
      [12, 19]
    ];
    return array
        .indexWhere((element) => element[0] == tone && element[1] == nahual);
  }

  int getNahuales(double angle) {
    int nahual;
    if (angle <= 351) {
      nahual = (angle + 9) ~/ (360 / 20);
    } else {
      nahual = 0;
    }
    return nahual;
  }

  Size getTextSize(String text, TextStyle textStyle) {
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    return textPainter.size;
  }

  List<int> getToneNahual(int kinNr) {
    return [kinNr % 13, kinNr % 20];
  }

  int getTone(double angle) {
    int tone;
    if (angle <= 360 - (180 / 13)) {
      tone = (angle + 180 / 13) ~/ (360 / 13);
    } else {
      tone = 0;
    }
    return tone;
  }

  setIndex(int yearIndex, int dayIndex) {
    int l = 0;
    int n = 0;
    int m = 0;
    int o = 0;
    for (int i = 0;
        i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
        i++) {
      switch (Globals().arrayIndex[yearIndex][dayIndex][2][i]) {
        case 0:
          Globals().arrayIndex[yearIndex][dayIndex][4][i] = l;
          l++;
          break;
        case 1:
          Globals().arrayIndex[yearIndex][dayIndex][4][i] = n;
          n++;
          break;
        case 2:
          Globals().arrayIndex[yearIndex][dayIndex][4][i] = m;
          m++;
          break;
        case 3:
          Globals().arrayIndex[yearIndex][dayIndex][4][i] = o;
          o++;
          break;
      }
    }
  }

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
                      .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3]
                          [i]]
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
}
