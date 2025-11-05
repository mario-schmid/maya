import 'dart:convert';

import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../alarm_dialog.dart';
import '../database_handler.dart';
import '../event_dialog.dart';
import '../methods/set_stop_alarm.dart';
import '../note_dialog.dart';
import '../providers/mayadata.dart';
import '../task_dialog.dart';
import '../time_format.dart';

class DayItemWidget {
  final BuildContext context;
  final Size size;
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final int listIndex;
  final int elementIndex;
  final MayaData data;

  DayItemWidget({
    required this.context,
    required this.size,
    required this.mainColor,
    required this.yearIndex,
    required this.dayIndex,
    required this.listIndex,
    required this.elementIndex,
    required this.data,
  });

  final DatabaseHandlerEvents _dbHandlerEvents = DatabaseHandlerEvents();
  final DatabaseHandlerNotes _dbHandlerNotes = DatabaseHandlerNotes();
  final DatabaseHandlerTasks _dbHandlerTasks = DatabaseHandlerTasks();
  final DatabaseHandlerAlarms _dbHandlerAlarms = DatabaseHandlerAlarms();
  final DatabaseHandlerArrangements _dbHandlerArrangements =
      DatabaseHandlerArrangements();

  /* -------------------------------------------------------------------------- */
  /* ========================================================================== */
  /* ========================================================================== */
  /* -------------------------------------------------------------------------- */
  Dismissible event(
    String uuid,
    String begin,
    String end,
    String title,
    String description,
  ) {
    final dayData = data.mayaData[yearIndex]![dayIndex]!;

    return Dismissible(
      key: Key(uuid),
      onDismissed: (direction) {
        dayData.arrangement.removeAt(listIndex);

        int j = 0;
        for (int i = 0; i < dayData.arrangement.length; i++) {
          if (dayData.arrangement[i].type == 'event') {
            dayData.arrangement[i].elementIndex = j;
            j++;
          }
        }

        if (dayData.arrangement.isNotEmpty) {
          List<Map<String, dynamic>> arrangementMaps = dayData.arrangement
              .map((arrangement) => arrangement.toJson())
              .toList();

          _dbHandlerArrangements.updateArrangement(
            yearIndex,
            dayIndex,
            jsonEncode(arrangementMaps),
          );
        } else {
          _dbHandlerArrangements.deleteArrangement(yearIndex, dayIndex);
        }

        data.removeEvent(yearIndex, dayIndex, elementIndex);
        _dbHandlerEvents.deleteEvents(yearIndex, dayIndex);

        if (dayData.eventList.isNotEmpty) {
          List<Map<String, dynamic>> listMapEvents = [];
          for (int i = 0; i < dayData.eventList.length; i++) {
            listMapEvents.add({
              'yearIndex': yearIndex,
              'dayIndex': dayIndex,
              'elementIndex': i,
              'uuid': dayData.eventList[i].uuid,
              'begin': dayData.eventList[i].begin,
              'end': dayData.eventList[i].end,
              'title': dayData.eventList[i].title,
              'description': dayData.eventList[i].description,
            });
          }
          _dbHandlerEvents.insertEventList(listMapEvents);
        }
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => EventDialog(
              mainColor: mainColor,
              yearIndex: yearIndex,
              dayIndex: dayIndex,
              elementIndex: elementIndex,
              begin: begin,
              end: end,
              title: title,
              description: description,
              create: false,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.014),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.orange,
                  BlendMode.modulate,
                ),
                image: AssetImage('assets/images/bg_pattern_one.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: [
                Align(
                  alignment: const Alignment(-0.95, 0.05),
                  child: Text(
                    '${'from'.tr} $begin ${'to'.tr} $end',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* ========================================================================== */
  /* ========================================================================== */
  /* -------------------------------------------------------------------------- */
  Dismissible note(String uuid, String entry) {
    final dayData = data.mayaData[yearIndex]![dayIndex]!;

    return Dismissible(
      key: Key(uuid),
      onDismissed: (direction) {
        dayData.arrangement.removeAt(listIndex);

        int j = 0;
        for (int i = 0; i < dayData.arrangement.length; i++) {
          if (dayData.arrangement[i].type == 'note') {
            dayData.arrangement[i].elementIndex = j;
            j++;
          }
        }

        if (dayData.arrangement.isNotEmpty) {
          List<Map<String, dynamic>> arrangementMaps = dayData.arrangement
              .map((arrangement) => arrangement.toJson())
              .toList();

          _dbHandlerArrangements.updateArrangement(
            yearIndex,
            dayIndex,
            jsonEncode(arrangementMaps),
          );
        } else {
          _dbHandlerArrangements.deleteArrangement(yearIndex, dayIndex);
        }

        data.removeNote(yearIndex, dayIndex, elementIndex);
        _dbHandlerNotes.deleteNotes(yearIndex, dayIndex);

        if (dayData.noteList.isNotEmpty) {
          List<Map<String, dynamic>> listMapNotes = [];
          for (int i = 0; i < dayData.noteList.length; i++) {
            listMapNotes.add({
              'yearIndex': yearIndex,
              'dayIndex': dayIndex,
              'elementIndex': i,
              'uuid': dayData.noteList[i].uuid,
              'entry': dayData.noteList[i].entry,
            });
          }
          _dbHandlerNotes.insertNoteList(listMapNotes);
        }
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => NoteDialog(
              mainColor: mainColor,
              yearIndex: yearIndex,
              dayIndex: dayIndex,
              elementIndex: elementIndex,
              entry: entry,
              create: false,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.014),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 70),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.green,
                    BlendMode.modulate,
                  ),
                  image: AssetImage('assets/images/bg_pattern_one.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.013888889,
                  5,
                  size.width * 0.013888889,
                  5,
                ),
                child: Text(
                  entry,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* ========================================================================== */
  /* ========================================================================== */
  /* -------------------------------------------------------------------------- */
  Dismissible task(String uuid, String description, bool isChecked) {
    final dayData = data.mayaData[yearIndex]![dayIndex]!;

    return Dismissible(
      key: Key(uuid),
      onDismissed: (direction) {
        dayData.arrangement.removeAt(listIndex);

        int j = 0;
        for (int i = 0; i < dayData.arrangement.length; i++) {
          if (dayData.arrangement[i].type == 'task') {
            dayData.arrangement[i].elementIndex = j;
            j++;
          }
        }

        if (dayData.arrangement.isNotEmpty) {
          List<Map<String, dynamic>> arrangementMaps = dayData.arrangement
              .map((arrangement) => arrangement.toJson())
              .toList();

          _dbHandlerArrangements.updateArrangement(
            yearIndex,
            dayIndex,
            jsonEncode(arrangementMaps),
          );
        } else {
          _dbHandlerArrangements.deleteArrangement(yearIndex, dayIndex);
        }

        data.removeTask(yearIndex, dayIndex, elementIndex);
        _dbHandlerTasks.deleteTasks(yearIndex, dayIndex);

        if (dayData.taskList.isNotEmpty) {
          List<Map<String, dynamic>> listMapTasks = [];
          for (int i = 0; i < dayData.taskList.length; i++) {
            listMapTasks.add({
              'yearIndex': yearIndex,
              'dayIndex': dayIndex,
              'elementIndex': i,
              'uuid': dayData.taskList[i].uuid,
              'description': dayData.taskList[i].description,
              'isChecked': dayData.taskList[i].isChecked ? 1 : 0,
            });
          }
          _dbHandlerTasks.insertTaskList(listMapTasks);
        }
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => TaskDialog(
              mainColor: mainColor,
              yearIndex: yearIndex,
              dayIndex: dayIndex,
              elementIndex: elementIndex,
              description: description,
              create: false,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.014),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(Colors.blue, BlendMode.modulate),
                image: AssetImage('assets/images/bg_pattern_one.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.64,
                  child: Center(
                    child: Text(
                      description,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.014),
                  child: Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      side: const BorderSide(color: Colors.white),
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        data.setIsChecked(
                          yearIndex,
                          dayIndex,
                          elementIndex,
                          value,
                        );
                        _dbHandlerTasks.updateTaskIsChecked(
                          yearIndex,
                          dayIndex,
                          elementIndex,
                          value!,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /* ========================================================================== */
  /* ========================================================================== */
  /* -------------------------------------------------------------------------- */
  Dismissible alarm(String uuid, AlarmSettings alarmSettings, bool isActive) {
    final timeFormat = TimeFormat().getTimeFormat.pattern == 'h:mm a'
        ? DateFormat('h:mm a')
        : DateFormat('HH:mm');

    final dayData = data.mayaData[yearIndex]![dayIndex]!;

    return Dismissible(
      key: Key(uuid),
      onDismissed: (direction) {
        final alarm = dayData.alarmList[elementIndex];
        stopAlarm(alarm.alarmSettings.id);

        dayData.arrangement.removeAt(listIndex);

        int j = 0;
        for (int i = 0; i < dayData.arrangement.length; i++) {
          if (dayData.arrangement[i].type == 'alarm') {
            dayData.arrangement[i].elementIndex = j;
            j++;
          }
        }

        if (dayData.arrangement.isNotEmpty) {
          List<Map<String, dynamic>> arrangementMaps = dayData.arrangement
              .map((arrangement) => arrangement.toJson())
              .toList();

          _dbHandlerArrangements.updateArrangement(
            yearIndex,
            dayIndex,
            jsonEncode(arrangementMaps),
          );
        } else {
          _dbHandlerArrangements.deleteArrangement(yearIndex, dayIndex);
        }
        data.removeAlarm(yearIndex, dayIndex, elementIndex);
        _dbHandlerAlarms.deleteAlarms(yearIndex, dayIndex);

        if (dayData.alarmList.isNotEmpty) {
          List<Map<String, dynamic>> listMapAlarms = [];
          for (int i = 0; i < dayData.alarmList.length; i++) {
            listMapAlarms.add({
              'yearIndex': yearIndex,
              'dayIndex': dayIndex,
              'elementIndex': i,
              'uuid': dayData.alarmList[i].uuid,
              'alarmSettings': dayData.alarmList[i].alarmSettings,
              'isActive': dayData.alarmList[i].isActive ? 1 : 0,
            });
          }
          _dbHandlerAlarms.insertAlarmList(listMapAlarms);
        }
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => ADialog(
              mainColor: mainColor,
              yearIndex: yearIndex,
              dayIndex: dayIndex,
              elementIndex: elementIndex,
              chosenGregorianDate: null,
              alarmSettings: alarmSettings,
              alarmSoundIndex: null,
              customAlarmSoundPath: null,
              globalAlarmSoundVolume: null,
              create: false,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.014),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.modulate),
                image: AssetImage('assets/images/bg_pattern_one.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        timeFormat.format(
                          data
                              .mayaData[yearIndex]![dayIndex]!
                              .alarmList[elementIndex]
                              .alarmSettings
                              .dateTime,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        data
                            .mayaData[yearIndex]![dayIndex]!
                            .alarmList[elementIndex]
                            .alarmSettings
                            .notificationSettings
                            .title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.014),
                  child: Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      side: const BorderSide(color: Colors.white),
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      value: isActive,
                      onChanged: (bool? value) {
                        data.setIsActive(
                          yearIndex,
                          dayIndex,
                          elementIndex,
                          value,
                        );
                        _dbHandlerAlarms.updateAlarmIsActive(
                          yearIndex,
                          dayIndex,
                          elementIndex,
                          value!,
                        );
                        if (value) {
                          setAlarm(alarmSettings);
                        } else {
                          stopAlarm(alarmSettings.id);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
