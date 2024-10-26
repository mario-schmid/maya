import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../alarm_dialog.dart';
import '../data/maya_alarm.dart';
import '../data/maya_day.dart';
import '../data/maya_event.dart';
import '../data/maya_task.dart';
import '../database_handler.dart';
import '../event_dialog.dart';
import '../globals.dart';
import '../main.dart';
import '../methods/set_index.dart';
import '../methods/set_stop_alarm.dart';
import '../note_dialog.dart';
import '../providers/dayitems.dart';
import '../providers/mayadata.dart';
import '../task_dialog.dart';
import '../time_format.dart';

class MayaItems {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final bool newListItem;
  final int index;
  MayaItems(
      {required this.mainColor,
      required this.yearIndex,
      required this.dayIndex,
      required this.newListItem,
      required this.index});

  Size size = MediaQuery.of(navigatorKey.currentContext!).size;

  init() {
    if (!Globals().arrayIndex.containsKey(yearIndex)) {
      Globals().arrayIndex[yearIndex] = <int, List<List<int>>>{};
      Globals().arrayIndex[yearIndex]
          [dayIndex] = [<int>[], <int>[], <int>[], <int>[], <int>[]];
    } else if (!Globals().arrayIndex[yearIndex].containsKey(dayIndex)) {
      Globals().arrayIndex[yearIndex]
          [dayIndex] = [<int>[], <int>[], <int>[], <int>[], <int>[]];
    }

    if (!DayItems().dayItems.containsKey(yearIndex)) {
      DayItems().dayItems[yearIndex] = <int, List<Dismissible>>{};
      DayItems().dayItems[yearIndex][dayIndex] = <Dismissible>[];
    } else if (!DayItems().dayItems[yearIndex].containsKey(dayIndex)) {
      DayItems().dayItems[yearIndex][dayIndex] = <Dismissible>[];
    }

    Globals()
        .arrayIndex[yearIndex][dayIndex][0]
        .add(DayItems().dayItems[yearIndex][dayIndex].length);
    Globals()
        .arrayIndex[yearIndex][dayIndex][1]
        .add(DayItems().dayItems[yearIndex][dayIndex].length);
  }

  initMayaData() {
    if (!MayaData().mayaData.containsKey(yearIndex)) {
      MayaData().mayaData[yearIndex] = <int, Day>{};
      MayaData().mayaData[yearIndex][dayIndex] = Day();
    } else if (!MayaData().mayaData[yearIndex].containsKey(dayIndex)) {
      MayaData().mayaData[yearIndex][dayIndex] = Day();
    }
  }

/* -------------------------------------------------------------------------- */
/* ========================================================================== */
/* ========================================================================== */
/* -------------------------------------------------------------------------- */
  Dismissible event(
      String begin, String end, String title, String description) {
    init();

    Globals().arrayIndex[yearIndex][dayIndex][2].add(0);

    int a = Globals().arrayIndex[yearIndex][dayIndex][0].last;

    // FIXME: move to selection_dialog
    int eventIndex = 0;
    if (newListItem) {
      initMayaData();

      Globals()
          .arrayIndex[yearIndex][dayIndex][3]
          .add(MayaData().mayaData[yearIndex][dayIndex].eventList.length);

      eventIndex = MayaData().mayaData[yearIndex][dayIndex].eventList.length;

      Globals().arrayIndex[yearIndex][dayIndex][4].add(0);
      setIndex(yearIndex, dayIndex);
/* ========================================================================== */
      int elementIndex = Globals()
          .arrayIndex[yearIndex][dayIndex][2]
          .where((element) => element == 0)
          .length;

      DatabaseHandlerEvents().insertEvent(yearIndex, dayIndex, elementIndex - 1,
          begin, end, title, description);

      if (Globals().arrayIndex[yearIndex][dayIndex][2].length > 1) {
        DatabaseHandlerArrangements().updateArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      } else {
        DatabaseHandlerArrangements().insertArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      }
/* ========================================================================== */
      // FIXME: move to selection_dialog
      MayaData()
          .mayaData[yearIndex][dayIndex]
          .eventList
          .add(Event([begin, end, title, description]));
    } else {
      Globals().arrayIndex[yearIndex][dayIndex][3].add(index);
      Globals().arrayIndex[yearIndex][dayIndex][4].add(index);
      eventIndex = index;
    }

    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          for (int k = 0;
              k < Globals().arrayIndex[yearIndex][dayIndex][1].length;
              k++) {
            if (a == Globals().arrayIndex[yearIndex][dayIndex][1][k]) {
              MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .eventList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .event = null;

              Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                  .removeAt(yearIndex, dayIndex,
                      Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][1]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][2]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][3]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][4]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals().arrayIndex[yearIndex][dayIndex][0].removeLast();
              setIndex(yearIndex, dayIndex);

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
                        .eventList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .event[0],
                    'end': MayaData()
                        .mayaData[yearIndex][dayIndex]
                        .eventList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .event[1],
                    'title': MayaData()
                        .mayaData[yearIndex][dayIndex]
                        .eventList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .event[2],
                    'description': MayaData()
                        .mayaData[yearIndex][dayIndex]
                        .eventList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .event[3]
                  });
                  elementIndexEvent++;
                }
              }
              if (listMapEvents.isNotEmpty) {
                DatabaseHandlerEvents().insertEventList(listMapEvents);
              }

              if (Globals().arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
                DatabaseHandlerArrangements().updateArrangement(
                    yearIndex,
                    dayIndex,
                    Globals().arrayIndex[yearIndex][dayIndex][2].toString());
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
              final List val = await showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return EventDialog(
                        mainColor: mainColor,
                        yearIndex: yearIndex,
                        dayIndex: dayIndex,
                        begin: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .eventList[eventIndex]
                            .event[0],
                        end: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .eventList[eventIndex]
                            .event[1],
                        title: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .eventList[eventIndex]
                            .event[2],
                        description: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .eventList[eventIndex]
                            .event[3],
                        flagCreateChange: false);
                  });
              if (val[0]) {
                updateEvent(yearIndex, dayIndex, eventIndex, val[1]);
              }
            },
            child: Padding(
                padding: EdgeInsets.all(size.width * 0.014),
                child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.orange, BlendMode.modulate),
                            image:
                                AssetImage('assets/images/bg_pattern_one.jpg'),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Consumer<MayaData>(builder: (context, data, child) {
                      return Column(children: [
                        Align(
                          alignment: const Alignment(-0.95, 0.05),
                          child: Text(
                              '${'from'.tr} ${data.mayaData[yearIndex][dayIndex].eventList[eventIndex].event[0]} ${'to'.tr} ${data.mayaData[yearIndex][dayIndex].eventList[eventIndex].event[1]}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                              data.mayaData[yearIndex][dayIndex]
                                  .eventList[eventIndex].event[2],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        )
                      ]);
                    })))));
  }

  updateEvent(int yearIndex, int dayIndex, int eventIndex, List data) {
    Provider.of<MayaData>(navigatorKey.currentContext!, listen: false).setEvent(
        yearIndex, dayIndex, eventIndex, data[0], data[1], data[2], data[3]);

    int elementIndex = 0;
    for (int i = 0;
        i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
        i++) {
      if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 0 &&
          Globals().arrayIndex[yearIndex][dayIndex][3][i] == eventIndex) {
        elementIndex = Globals().arrayIndex[yearIndex][dayIndex][4][i];
      }
    }
    DatabaseHandlerEvents().updateEvent(
        yearIndex, dayIndex, elementIndex, data[0], data[1], data[2], data[3]);
  }

/* -------------------------------------------------------------------------- */
/* ========================================================================== */
/* ========================================================================== */
/* -------------------------------------------------------------------------- */
  Dismissible note(String note) {
    init();

    Globals().arrayIndex[yearIndex][dayIndex][2].add(1);

    int a = Globals().arrayIndex[yearIndex][dayIndex][0].last;

    // FIXME: move to selection_dialog
    int noteIndex = 0;
    if (newListItem) {
      initMayaData();

      Globals()
          .arrayIndex[yearIndex][dayIndex][3]
          .add(MayaData().mayaData[yearIndex][dayIndex].noteList.length);

      noteIndex = MayaData().mayaData[yearIndex][dayIndex].noteList.length;

      Globals().arrayIndex[yearIndex][dayIndex][4].add(0);
      setIndex(yearIndex, dayIndex);
/* ========================================================================== */
      int elementIndex = Globals()
          .arrayIndex[yearIndex][dayIndex][2]
          .where((element) => element == 1)
          .length;

      DatabaseHandlerNotes()
          .insertNote(yearIndex, dayIndex, elementIndex - 1, note);

      if (Globals().arrayIndex[yearIndex][dayIndex][2].length > 1) {
        DatabaseHandlerArrangements().updateArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      } else {
        DatabaseHandlerArrangements().insertArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      }
/* ========================================================================== */
      // FIXME: move to selection_dialog
      MayaData().mayaData[yearIndex][dayIndex].noteList.add(note);
    } else {
      Globals().arrayIndex[yearIndex][dayIndex][3].add(index);
      Globals().arrayIndex[yearIndex][dayIndex][4].add(index);
      noteIndex = index;
    }

    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          for (int k = 0;
              k < Globals().arrayIndex[yearIndex][dayIndex][1].length;
              k++) {
            if (a == Globals().arrayIndex[yearIndex][dayIndex][1][k]) {
              MayaData().mayaData[yearIndex][dayIndex].noteList[
                  Globals().arrayIndex[yearIndex][dayIndex][3][k]] = null;

              Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                  .removeAt(yearIndex, dayIndex,
                      Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][1]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][2]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][3]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][4]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals().arrayIndex[yearIndex][dayIndex][0].removeLast();
              setIndex(yearIndex, dayIndex);

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
                    'note': MayaData().mayaData[yearIndex][dayIndex].noteList[
                        Globals().arrayIndex[yearIndex][dayIndex][3][i]]
                  });
                  elementIndexNote++;
                }
              }
              if (listMapNotes.isNotEmpty) {
                DatabaseHandlerNotes().insertNoteList(listMapNotes);
              }

              if (Globals().arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
                DatabaseHandlerArrangements().updateArrangement(
                    yearIndex,
                    dayIndex,
                    Globals().arrayIndex[yearIndex][dayIndex][2].toString());
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
              final List val = await showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return NoteDialog(
                        mainColor: mainColor,
                        yearIndex: yearIndex,
                        dayIndex: dayIndex,
                        note: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .noteList[noteIndex],
                        flagCreateChange: false);
                  });

              if (val[0]) {
                updateNote(yearIndex, dayIndex, noteIndex, val[1]);
              }
            },
            child: Padding(
                padding: EdgeInsets.all(size.width * 0.014),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 70),
                  child: Container(
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.green, BlendMode.modulate),
                              image: AssetImage(
                                  'assets/images/bg_pattern_one.jpg'),
                              fit: BoxFit.cover),
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(size.width * 0.013888889,
                              5, size.width * 0.013888889, 5),
                          child: Consumer<MayaData>(
                              builder: (context, data, child) {
                            return Text(
                                data.mayaData[yearIndex][dayIndex]
                                    .noteList[noteIndex]!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16));
                          }))),
                ))));
  }

  updateNote(int yearIndex, int dayIndex, int noteIndex, String data) {
    Provider.of<MayaData>(navigatorKey.currentContext!, listen: false)
        .setNote(yearIndex, dayIndex, noteIndex, data);

    int elementIndex = 0;
    for (int i = 0;
        i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
        i++) {
      if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 1 &&
          Globals().arrayIndex[yearIndex][dayIndex][3][i] == noteIndex) {
        elementIndex = Globals().arrayIndex[yearIndex][dayIndex][4][i];
      }
    }
    DatabaseHandlerNotes().updateNote(yearIndex, dayIndex, elementIndex, data);
  }

/* -------------------------------------------------------------------------- */
/* ========================================================================== */
/* ========================================================================== */
/* -------------------------------------------------------------------------- */
  Dismissible task(String task, bool isChecked) {
    init();

    Globals().arrayIndex[yearIndex][dayIndex][2].add(2);

    int a = Globals().arrayIndex[yearIndex][dayIndex][0].last;

    // FIXME: move to selection_dialog
    int taskIndex = 0;
    if (newListItem) {
      initMayaData();

      Globals()
          .arrayIndex[yearIndex][dayIndex][3]
          .add(MayaData().mayaData[yearIndex][dayIndex].taskList.length);

      taskIndex = MayaData().mayaData[yearIndex][dayIndex].taskList.length;

      Globals().arrayIndex[yearIndex][dayIndex][4].add(0);
      setIndex(yearIndex, dayIndex);
/* ========================================================================== */
      int elementIndex = Globals()
          .arrayIndex[yearIndex][dayIndex][2]
          .where((element) => element == 2)
          .length;

      DatabaseHandlerTasks()
          .insertTask(yearIndex, dayIndex, elementIndex - 1, task, false);

      if (Globals().arrayIndex[yearIndex][dayIndex][2].length > 1) {
        DatabaseHandlerArrangements().updateArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      } else {
        DatabaseHandlerArrangements().insertArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      }
/* ========================================================================== */
      // FIXME: move to selection_dialog
      MayaData()
          .mayaData[yearIndex][dayIndex]
          .taskList
          .add(Task(task, isChecked));
    } else {
      Globals().arrayIndex[yearIndex][dayIndex][3].add(index);
      Globals().arrayIndex[yearIndex][dayIndex][4].add(index);
      taskIndex = index;
    }

    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          for (int k = 0;
              k < Globals().arrayIndex[yearIndex][dayIndex][1].length;
              k++) {
            if (a == Globals().arrayIndex[yearIndex][dayIndex][1][k]) {
              MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .taskList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .text = null;
              MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .taskList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .isChecked = true;

              Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                  .removeAt(yearIndex, dayIndex,
                      Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][1]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][2]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][3]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][4]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals().arrayIndex[yearIndex][dayIndex][0].removeLast();
              setIndex(yearIndex, dayIndex);

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
                        .taskList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .text,
                    'isChecked': MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .taskList[Globals().arrayIndex[yearIndex][dayIndex]
                                [3][i]]
                            .isChecked
                        ? 1
                        : 0
                  });
                  elementIndexTask++;
                }
              }
              if (listMapTasks.isNotEmpty) {
                DatabaseHandlerTasks().insertTaskList(listMapTasks);
              }

              if (Globals().arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
                DatabaseHandlerArrangements().updateArrangement(
                    yearIndex,
                    dayIndex,
                    Globals().arrayIndex[yearIndex][dayIndex][2].toString());
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
              final List val = await showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return TaskDialog(
                        mainColor: mainColor,
                        yearIndex: yearIndex,
                        dayIndex: dayIndex,
                        task: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .taskList[taskIndex]
                            .text,
                        flagCreateChange: false);
                  });

              if (val[0]) {
                updateTask(yearIndex, dayIndex, taskIndex, val[1]);
              }
            },
            child: Padding(
                padding: EdgeInsets.all(size.width * 0.014),
                child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue, BlendMode.modulate),
                            image:
                                AssetImage('assets/images/bg_pattern_one.jpg'),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: size.width * 0.64,
                              child: Center(child: Consumer<MayaData>(
                                  builder: (context, data, child) {
                                return Text(
                                    data.mayaData[yearIndex][dayIndex]
                                        .taskList[taskIndex].text!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16));
                              }))),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: size.width * 0.014),
                              child: Transform.scale(
                                  scale: 2,
                                  child: Consumer<MayaData>(
                                      builder: (context, data, child) {
                                    return Checkbox(
                                        shape: const CircleBorder(),
                                        side: const BorderSide(
                                            color: Colors.white),
                                        activeColor: Colors.blue,
                                        checkColor: Colors.white,
                                        value: data
                                            .mayaData[yearIndex][dayIndex]
                                            .taskList[taskIndex]
                                            .isChecked,
                                        onChanged: (bool? value) {
                                          Provider.of<MayaData>(context,
                                                  listen: false)
                                              .setIsChecked(yearIndex, dayIndex,
                                                  taskIndex, value);
                                          int elementIndex = 0;
                                          for (int i = 0;
                                              i <
                                                  Globals()
                                                      .arrayIndex[yearIndex]
                                                          [dayIndex][2]
                                                      .length;
                                              i++) {
                                            if (Globals().arrayIndex[yearIndex]
                                                        [dayIndex][2][i] ==
                                                    2 &&
                                                Globals().arrayIndex[yearIndex]
                                                        [dayIndex][3][i] ==
                                                    taskIndex) {
                                              elementIndex = Globals()
                                                      .arrayIndex[yearIndex]
                                                  [dayIndex][4][i];
                                            }
                                          }
                                          DatabaseHandlerTasks()
                                              .updateTaskIsChecked(
                                                  yearIndex,
                                                  dayIndex,
                                                  elementIndex,
                                                  value!);
                                        });
                                  })))
                        ])))));
  }

  updateTask(int yearIndex, int dayIndex, int taskIndex, String data) {
    Provider.of<MayaData>(navigatorKey.currentContext!, listen: false)
        .setTask(yearIndex, dayIndex, taskIndex, data);

    int elementIndex = 0;
    for (int i = 0;
        i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
        i++) {
      if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 2 &&
          Globals().arrayIndex[yearIndex][dayIndex][3][i] == taskIndex) {
        elementIndex = Globals().arrayIndex[yearIndex][dayIndex][4][i];
      }
    }
    DatabaseHandlerTasks()
        .updateTaskText(yearIndex, dayIndex, elementIndex, data);
  }

/* -------------------------------------------------------------------------- */
/* ========================================================================== */
/* ========================================================================== */
/* -------------------------------------------------------------------------- */
  Dismissible alarm(AlarmSettings alarmSettings, bool isActive) {
    late DateFormat timeFormat;
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        timeFormat = DateFormat('h:mm a');
        break;
      case 'HH:mm:ss':
        timeFormat = DateFormat('HH:mm');
        break;
    }

    init();

    Globals().arrayIndex[yearIndex][dayIndex][2].add(3);

    int a = Globals().arrayIndex[yearIndex][dayIndex][0].last;

    // FIXME: move to selection_dialog
    int alarmIndex = 0;
    if (newListItem) {
      initMayaData();

      Globals()
          .arrayIndex[yearIndex][dayIndex][3]
          .add(MayaData().mayaData[yearIndex][dayIndex].alarmList.length);

      alarmIndex = MayaData().mayaData[yearIndex][dayIndex].alarmList.length;

      Globals().arrayIndex[yearIndex][dayIndex][4].add(0);
      setIndex(yearIndex, dayIndex);
/* ========================================================================== */
      int elementIndex = Globals()
          .arrayIndex[yearIndex][dayIndex][2]
          .where((element) => element == 3)
          .length;

      DatabaseHandlerAlarms().insertAlarm(
          yearIndex, dayIndex, elementIndex - 1, alarmSettings, true);

      if (Globals().arrayIndex[yearIndex][dayIndex][2].length > 1) {
        DatabaseHandlerArrangements().updateArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      } else {
        DatabaseHandlerArrangements().insertArrangement(yearIndex, dayIndex,
            Globals().arrayIndex[yearIndex][dayIndex][2].toString());
      }
/* ========================================================================== */
      // FIXME: move to selection_dialog
      MayaData()
          .mayaData[yearIndex][dayIndex]
          .alarmList
          .add(MayaAlarm(alarmSettings, isActive));
      SetStopAlarm().setAlarm(MayaData()
          .mayaData[yearIndex][dayIndex]
          .alarmList
          .last
          .alarmSettings);
    } else {
      Globals().arrayIndex[yearIndex][dayIndex][3].add(index);
      Globals().arrayIndex[yearIndex][dayIndex][4].add(index);
      alarmIndex = index;
    }

    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          for (int k = 0;
              k < Globals().arrayIndex[yearIndex][dayIndex][1].length;
              k++) {
            if (a == Globals().arrayIndex[yearIndex][dayIndex][1][k]) {
              SetStopAlarm().stopAlarm(MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .alarmSettings
                  .id);
              MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .alarmSettings = null;
              MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3][k]]
                  .isActive = false;

              Provider.of<DayItems>(navigatorKey.currentContext!, listen: false)
                  .removeAt(yearIndex, dayIndex,
                      Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][1]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][2]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][3]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals()
                  .arrayIndex[yearIndex][dayIndex][4]
                  .removeAt(Globals().arrayIndex[yearIndex][dayIndex][0][k]);
              Globals().arrayIndex[yearIndex][dayIndex][0].removeLast();
              setIndex(yearIndex, dayIndex);

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
                        .alarmList[Globals().arrayIndex[yearIndex][dayIndex][3]
                            [i]]
                        .alarmSettings,
                    'isActive': MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .alarmList[Globals().arrayIndex[yearIndex][dayIndex]
                                [3][i]]
                            .isActive
                        ? 1
                        : 0
                  });
                  elementIndexAlarm++;
                }
              }
              if (listMapAlarms.isNotEmpty) {
                DatabaseHandlerAlarms().insertAlarmList(listMapAlarms);
              }

              if (Globals().arrayIndex[yearIndex][dayIndex][2].isNotEmpty) {
                DatabaseHandlerArrangements().updateArrangement(
                    yearIndex,
                    dayIndex,
                    Globals().arrayIndex[yearIndex][dayIndex][2].toString());
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
              final List val = await showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ADialog(
                        mainColor: mainColor,
                        yearIndex: yearIndex,
                        dayIndex: dayIndex,
                        alarmSettings: MayaData()
                            .mayaData[yearIndex][dayIndex]
                            .alarmList[alarmIndex]
                            .alarmSettings,
                        flagCreateChange: false);
                  });
              if (val[0]) {
                updateAlarm(yearIndex, dayIndex, alarmIndex, val[1]);
              }
            },
            child: Padding(
                padding: EdgeInsets.all(size.width * 0.014),
                child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.red, BlendMode.modulate),
                            image:
                                AssetImage('assets/images/bg_pattern_one.jpg'),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: size.width * 0.64,
                              child: Consumer<MayaData>(
                                  builder: (context, data, child) {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          timeFormat.format(data
                                              .mayaData[yearIndex][dayIndex]
                                              .alarmList[alarmIndex]
                                              .alarmSettings
                                              .dateTime!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      Text(
                                          data
                                              .mayaData[yearIndex][dayIndex]
                                              .alarmList[alarmIndex]
                                              .alarmSettings
                                              .notificationSettings
                                              .title!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))
                                    ]);
                              })),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: size.width * 0.014),
                              child: Transform.scale(
                                  scale: 2,
                                  child: Consumer<MayaData>(
                                      builder: (context, data, child) {
                                    return Checkbox(
                                        shape: const CircleBorder(),
                                        side: const BorderSide(
                                            color: Colors.white),
                                        activeColor: Colors.blue,
                                        checkColor: Colors.white,
                                        value: data
                                            .mayaData[yearIndex][dayIndex]
                                            .alarmList[alarmIndex]
                                            .isActive,
                                        onChanged: (bool? value) {
                                          Provider.of<MayaData>(context,
                                                  listen: false)
                                              .setIsActive(yearIndex, dayIndex,
                                                  alarmIndex, value);
                                          int elementIndex = 0;
                                          for (int i = 0;
                                              i <
                                                  Globals()
                                                      .arrayIndex[yearIndex]
                                                          [dayIndex][2]
                                                      .length;
                                              i++) {
                                            if (Globals().arrayIndex[yearIndex]
                                                        [dayIndex][2][i] ==
                                                    3 &&
                                                Globals().arrayIndex[yearIndex]
                                                        [dayIndex][3][i] ==
                                                    alarmIndex) {
                                              elementIndex = Globals()
                                                      .arrayIndex[yearIndex]
                                                  [dayIndex][4][i];
                                            }
                                          }
                                          DatabaseHandlerAlarms()
                                              .updateAlarmIsActive(
                                                  yearIndex,
                                                  dayIndex,
                                                  elementIndex,
                                                  value!);
                                          if (value) {
                                            SetStopAlarm().setAlarm(MayaData()
                                                .mayaData[yearIndex][dayIndex]
                                                .alarmList[alarmIndex]
                                                .alarmSettings);
                                          } else {
                                            SetStopAlarm().stopAlarm(MayaData()
                                                .mayaData[yearIndex][dayIndex]
                                                .alarmList[alarmIndex]
                                                .alarmSettings
                                                .id);
                                          }
                                        });
                                  })))
                        ])))));
  }

  updateAlarm(int yearIndex, int dayIndex, int alarmIndex,
      AlarmSettings alarmSettings) {
    SetStopAlarm().stopAlarm(MayaData()
        .mayaData[yearIndex][dayIndex]
        .alarmList[alarmIndex]
        .alarmSettings
        .id);

    Provider.of<MayaData>(navigatorKey.currentContext!, listen: false)
        .setAlarm(yearIndex, dayIndex, alarmIndex, alarmSettings);

    Provider.of<MayaData>(navigatorKey.currentContext!, listen: false)
        .setIsActive(yearIndex, dayIndex, alarmIndex, true);

    int elementIndex = 0;
    for (int i = 0;
        i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
        i++) {
      if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 3 &&
          Globals().arrayIndex[yearIndex][dayIndex][3][i] == alarmIndex) {
        elementIndex = Globals().arrayIndex[yearIndex][dayIndex][4][i];
      }
    }
    DatabaseHandlerAlarms()
        .updateAlarmSettings(yearIndex, dayIndex, elementIndex, alarmSettings);

    DatabaseHandlerAlarms()
        .updateAlarmIsActive(yearIndex, dayIndex, elementIndex, true);

    SetStopAlarm().setAlarm(MayaData()
        .mayaData[yearIndex][dayIndex]
        .alarmList[alarmIndex]
        .alarmSettings);
  }
/* -------------------------------------------------------------------------- */
/* ========================================================================== */
/* ========================================================================== */
/* -------------------------------------------------------------------------- */
}
