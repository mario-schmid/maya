import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maya/globals.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:maya/providers/ischecked.dart';
import 'package:maya/providers/yeardata.dart';
import 'package:provider/provider.dart';

import 'data/event.dart';
import 'data/task.dart';
import 'database_handler.dart';
import 'event_dialog.dart';
import 'main.dart';
import 'methods/set_index.dart';
import 'note_dialog.dart';
import 'task_dialog.dart';

Dismissible eventItem(int yearIndex, int dayIndex, String begin, String end,
    String title, String description, bool newListItem, int index) {
  Size size = MediaQuery.of(navigatorKey.currentContext!).size;

  arrayIndex[yearIndex][dayIndex][0]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);
  arrayIndex[yearIndex][dayIndex][1]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);

  arrayIndex[yearIndex][dayIndex][2].add(0);

  int a = arrayIndex[yearIndex][dayIndex][0].last;

  int eventIndex = 0;
  if (newListItem) {
    arrayIndex[yearIndex][dayIndex][3]
        .add(YearData().yearData[yearIndex][dayIndex].eventList.length);

    eventIndex = YearData().yearData[yearIndex][dayIndex].eventList.length;

    arrayIndex[yearIndex][dayIndex][4].add(0);
    setIndex(yearIndex, dayIndex);
/* ========================================================================== */
    int elementIndex = 0;
    for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
      if (arrayIndex[yearIndex][dayIndex][2][i] == 0) {
        elementIndex++;
      }
    }

    // TODO: check if necessary!
    /*int elementIndex = arrayIndex[yearIndex][dayIndex][2]
        .where((element) => element == 0)
        .length;*/

    DatabaseHandlerEvents().insertEvent(
        yearIndex, dayIndex, elementIndex - 1, begin, end, title, description);

    if (arrayIndex[yearIndex][dayIndex][2].length > 1) {
      DatabaseHandlerArrangements().updateArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    } else {
      DatabaseHandlerArrangements().insertArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    }
/* ========================================================================== */
    // TODO: move to selection_dialog
    YearData()
        .yearData[yearIndex][dayIndex]
        .eventList
        .add(Event([begin, end, title, description]));
  } else {
    arrayIndex[yearIndex][dayIndex][3].add(index);
    arrayIndex[yearIndex][dayIndex][4].add(index);
    eventIndex = index;
  }

  return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        for (int k = 0; k < arrayIndex[yearIndex][dayIndex][1].length; k++) {
          if (a == arrayIndex[yearIndex][dayIndex][1][k]) {
            YearData()
                .yearData[yearIndex][dayIndex]
                .eventList[arrayIndex[yearIndex][dayIndex][3][k]]
                .event = null;

            Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                .removeAt(
                    yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][1]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][2]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][3]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][4]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][0].removeLast();
            setIndex(yearIndex, dayIndex);

            DatabaseHandlerEvents().deleteEvents(yearIndex, dayIndex);
            int elementIndexEvent = 0;
            List<Map<String, dynamic>> listMapEvents = [];
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
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
            if (listMapEvents.isNotEmpty) {
              DatabaseHandlerEvents().insertEventList(listMapEvents);
            }

            if (arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
              DatabaseHandlerArrangements().updateArrangement(yearIndex,
                  dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
            } else {
              DatabaseHandlerArrangements()
                  .deleteArrangement(yearIndex, dayIndex);
            }
            break;
          }
        }
      },
      child: GestureDetector(
          onTap: () async {
            final List<String> val = await showDialog(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return EventDialog(
                      yearIndex: yearIndex,
                      dayIndex: dayIndex,
                      begin: YearData()
                          .yearData[yearIndex][dayIndex]
                          .eventList[eventIndex]
                          .event[0],
                      end: YearData()
                          .yearData[yearIndex][dayIndex]
                          .eventList[eventIndex]
                          .event[1],
                      title: YearData()
                          .yearData[yearIndex][dayIndex]
                          .eventList[eventIndex]
                          .event[2],
                      description: YearData()
                          .yearData[yearIndex][dayIndex]
                          .eventList[eventIndex]
                          .event[3],
                      flagCreateChange: false);
                });

            Provider.of<YearData>(navigatorKey.currentContext!, listen: false)
                .setEvent(yearIndex, dayIndex, eventIndex, val[0], val[1],
                    val[2], val[3]);

            int elementIndex = 0;
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
              if (arrayIndex[yearIndex][dayIndex][2][i] == 0 &&
                  arrayIndex[yearIndex][dayIndex][3][i] == eventIndex) {
                elementIndex = arrayIndex[yearIndex][dayIndex][4][i];
              }
            }
            DatabaseHandlerEvents().updateEvent(yearIndex, dayIndex,
                elementIndex, val[0], val[1], val[2], val[3]);
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.013888889,
                  size.width * 0.013888889,
                  size.width * 0.013888889,
                  size.width * 0.013888889),
              child: Container(
                  height: 70,
                  width: size.width * 0.972222222,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/orange.jpg'),
                          fit: BoxFit.cover),
                      //color: Colors.amber[700],
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle),
                  child: Consumer<YearData>(builder: (context, data, child) {
                    return Column(children: [
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: size.width * 0.013888889),
                          child: Text(
                              '${'from'.tr} ${data.yearData[yearIndex][dayIndex].eventList[eventIndex].event[0]} ${'to'.tr} ${data.yearData[yearIndex][dayIndex].eventList[eventIndex].event[1]}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        )
                      ]),
                      Column(children: [
                        Center(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * 0.013888889,
                                    5,
                                    size.width * 0.013888889,
                                    5),
                                child: Text(
                                    data.yearData[yearIndex][dayIndex]
                                        .eventList[eventIndex].event[2],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18))))
                      ])
                    ]);
                  })))));
}

Dismissible noteItem(
    int yearIndex, int dayIndex, String note, bool newListItem, int index) {
  Size size = MediaQuery.of(navigatorKey.currentContext!).size;

  arrayIndex[yearIndex][dayIndex][0]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);
  arrayIndex[yearIndex][dayIndex][1]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);

  arrayIndex[yearIndex][dayIndex][2].add(1);

  int a = arrayIndex[yearIndex][dayIndex][0].last;

  int noteIndex = 0;
  if (newListItem) {
    arrayIndex[yearIndex][dayIndex][3]
        .add(YearData().yearData[yearIndex][dayIndex].noteList.length);

    noteIndex = YearData().yearData[yearIndex][dayIndex].noteList.length;

    arrayIndex[yearIndex][dayIndex][4].add(0);
    setIndex(yearIndex, dayIndex);
/* ========================================================================== */
    int elementIndex = 0;
    for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
      if (arrayIndex[yearIndex][dayIndex][2][i] == 1) {
        elementIndex++;
      }
    }

    // TODO: check if necessary!
    /*int elementIndex = arrayIndex[yearIndex][dayIndex][2]
        .where((element) => element == 1)
        .length;*/

    DatabaseHandlerNotes()
        .insertNote(yearIndex, dayIndex, elementIndex - 1, note);

    if (arrayIndex[yearIndex][dayIndex][2].length > 1) {
      DatabaseHandlerArrangements().updateArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    } else {
      DatabaseHandlerArrangements().insertArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    }
/* ========================================================================== */
    // TODO: move to selection_dialog
    YearData().yearData[yearIndex][dayIndex].noteList.add(note);
  } else {
    arrayIndex[yearIndex][dayIndex][3].add(index);
    arrayIndex[yearIndex][dayIndex][4].add(index);
    noteIndex = index;
  }

  return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        for (int k = 0; k < arrayIndex[yearIndex][dayIndex][1].length; k++) {
          if (a == arrayIndex[yearIndex][dayIndex][1][k]) {
            YearData()
                .yearData[yearIndex][dayIndex]
                .noteList[arrayIndex[yearIndex][dayIndex][3][k]] = null;

            Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                .removeAt(
                    yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][1]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][2]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][3]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][4]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][0].removeLast();
            setIndex(yearIndex, dayIndex);

            DatabaseHandlerNotes().deleteNotes(yearIndex, dayIndex);
            int elementIndexNote = 0;
            List<Map<String, dynamic>> listMapNotes = [];
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
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
            if (listMapNotes.isNotEmpty) {
              DatabaseHandlerNotes().insertNoteList(listMapNotes);
            }

            if (arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
              DatabaseHandlerArrangements().updateArrangement(yearIndex,
                  dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
            } else {
              DatabaseHandlerArrangements()
                  .deleteArrangement(yearIndex, dayIndex);
            }
            break;
          }
        }
      },
      child: GestureDetector(
          onTap: () async {
            final String val = await showDialog(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return NoteDialog(
                      yearIndex: yearIndex,
                      dayIndex: dayIndex,
                      note: YearData()
                          .yearData[yearIndex][dayIndex]
                          .noteList[noteIndex],
                      flagCreateChange: false);
                });

            Provider.of<YearData>(navigatorKey.currentContext!, listen: false)
                .setNote(yearIndex, dayIndex, noteIndex, val);

            int elementIndex = 0;
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
              if (arrayIndex[yearIndex][dayIndex][2][i] == 1 &&
                  arrayIndex[yearIndex][dayIndex][3][i] == noteIndex) {
                elementIndex = arrayIndex[yearIndex][dayIndex][4][i];
              }
            }
            DatabaseHandlerNotes()
                .updateNote(yearIndex, dayIndex, elementIndex, val);
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.013888889, 5, size.width * 0.013888889, 5),
              child: Container(
                  constraints: const BoxConstraints(minHeight: 70),
                  width: size.width * 0.972222222,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/green.jpg'),
                          fit: BoxFit.cover),
                      //color: Colors.green[700],
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.013888889, 5,
                          size.width * 0.013888889, 5),
                      child:
                          Consumer<YearData>(builder: (context, data, child) {
                        return Text(
                            data.yearData[yearIndex][dayIndex]
                                .noteList[noteIndex]!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14));
                      }))))));
}

Dismissible taskItem(int yearIndex, int dayIndex, String task, bool isChecked,
    bool newListItem, int index) {
  Size size = MediaQuery.of(navigatorKey.currentContext!).size;

  arrayIndex[yearIndex][dayIndex][0]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);
  arrayIndex[yearIndex][dayIndex][1]
      .add(DayItems().dayItems[yearIndex][dayIndex].length);

  arrayIndex[yearIndex][dayIndex][2].add(2);

  int a = arrayIndex[yearIndex][dayIndex][0].last;

  int taskIndex = 0;
  if (newListItem) {
    arrayIndex[yearIndex][dayIndex][3]
        .add(YearData().yearData[yearIndex][dayIndex].taskList.length);

    taskIndex = YearData().yearData[yearIndex][dayIndex].taskList.length;

    arrayIndex[yearIndex][dayIndex][4].add(0);
    setIndex(yearIndex, dayIndex);
/* ========================================================================== */
    int elementIndex = 0;
    for (int i = 0; i < arrayIndex[yearIndex][dayIndex][2].length; i++) {
      if (arrayIndex[yearIndex][dayIndex][2][i] == 2) {
        elementIndex++;
      }
    }

    // TODO: check if necessary!
    /*int elementIndex = arrayIndex[yearIndex][dayIndex][2]
        .where((element) => element == 2)
        .length;*/

    DatabaseHandlerTasks()
        .insertTask(yearIndex, dayIndex, elementIndex - 1, task, false);

    if (arrayIndex[yearIndex][dayIndex][2].length > 1) {
      DatabaseHandlerArrangements().updateArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    } else {
      DatabaseHandlerArrangements().insertArrangement(
          yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
    }
/* ========================================================================== */
    // TODO: move to selection_dialog
    YearData()
        .yearData[yearIndex][dayIndex]
        .taskList
        .add(Task(task, isChecked));

    IsChecked().add(yearIndex, dayIndex);
  } else {
    arrayIndex[yearIndex][dayIndex][3].add(index);
    arrayIndex[yearIndex][dayIndex][4].add(index);
    taskIndex = index;
  }

  return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        for (int k = 0; k < arrayIndex[yearIndex][dayIndex][1].length; k++) {
          if (a == arrayIndex[yearIndex][dayIndex][1][k]) {
            YearData()
                .yearData[yearIndex][dayIndex]
                .taskList[arrayIndex[yearIndex][dayIndex][3][k]]
                .text = null;
            YearData()
                .yearData[yearIndex][dayIndex]
                .taskList[arrayIndex[yearIndex][dayIndex][3][k]]
                .isChecked = true;

            Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                .removeAt(
                    yearIndex, dayIndex, arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][1]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][2]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][3]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][4]
                .removeAt(arrayIndex[yearIndex][dayIndex][0][k]);
            arrayIndex[yearIndex][dayIndex][0].removeLast();
            setIndex(yearIndex, dayIndex);

            DatabaseHandlerTasks().deleteTasks(yearIndex, dayIndex);
            int elementIndexTask = 0;
            List<Map<String, dynamic>> listMapTasks = [];
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
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
            if (listMapTasks.isNotEmpty) {
              DatabaseHandlerTasks().insertTaskList(listMapTasks);
            }

            if (arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
              DatabaseHandlerArrangements().updateArrangement(yearIndex,
                  dayIndex, arrayIndex[yearIndex][dayIndex][2].toString());
            } else {
              DatabaseHandlerArrangements()
                  .deleteArrangement(yearIndex, dayIndex);
            }
            break;
          }
        }
      },
      child: GestureDetector(
          onTap: () async {
            final String val = await showDialog(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return TaskDialog(
                      yearIndex: yearIndex,
                      dayIndex: dayIndex,
                      task: YearData()
                          .yearData[yearIndex][dayIndex]
                          .taskList[taskIndex]
                          .text,
                      flagCreateChange: false);
                });

            Provider.of<YearData>(navigatorKey.currentContext!, listen: false)
                .setTask(yearIndex, dayIndex, taskIndex, val);

            int elementIndex = 0;
            for (int i = 0;
                i < arrayIndex[yearIndex][dayIndex][2].length;
                i++) {
              if (arrayIndex[yearIndex][dayIndex][2][i] == 2 &&
                  arrayIndex[yearIndex][dayIndex][3][i] == taskIndex) {
                elementIndex = arrayIndex[yearIndex][dayIndex][4][i];
              }
            }
            DatabaseHandlerTasks()
                .updateTaskText(yearIndex, dayIndex, elementIndex, val);
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                  height: 70,
                  width: size.width * 0.972222222,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/blue.jpg'),
                          fit: BoxFit.cover),
                      //color: Colors.indigo[700],
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle),
                  child: Row(children: [
                    SizedBox(
                        width: size.width * 0.75,
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * 0.013888889,
                                    5,
                                    size.width * 0.013888889,
                                    5),
                                child: Consumer<YearData>(
                                    builder: (context, data, child) {
                                  return Text(
                                      data.yearData[yearIndex][dayIndex]
                                          .taskList[taskIndex].text!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14));
                                })))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(size.width * 0.013888889,
                            5, size.width * 0.013888889, 5),
                        child: Transform.scale(
                            scale: 2,
                            child: Consumer<IsChecked>(
                                builder: (context, data, child) {
                              return Checkbox(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(color: Colors.white),
                                  activeColor: Colors.blue,
                                  checkColor: Colors.white,
                                  value: data.isChecked[yearIndex][dayIndex]
                                      [taskIndex],
                                  onChanged: (bool? value) {
                                    Provider.of<IsChecked>(context,
                                            listen: false)
                                        .change(yearIndex, dayIndex, taskIndex,
                                            value);
                                    Provider.of<YearData>(context,
                                            listen: false)
                                        .setIsChecked(yearIndex, dayIndex,
                                            taskIndex, value);

                                    int elementIndex = 0;
                                    for (int i = 0;
                                        i <
                                            arrayIndex[yearIndex][dayIndex][2]
                                                .length;
                                        i++) {
                                      if (arrayIndex[yearIndex][dayIndex][2]
                                                  [i] ==
                                              2 &&
                                          arrayIndex[yearIndex][dayIndex][3]
                                                  [i] ==
                                              taskIndex) {
                                        elementIndex = arrayIndex[yearIndex]
                                            [dayIndex][4][i];
                                      }
                                    }
                                    DatabaseHandlerTasks().updateTaskIsChecked(
                                        yearIndex,
                                        dayIndex,
                                        elementIndex,
                                        value!);
                                  });
                            })))
                  ])))));
}
