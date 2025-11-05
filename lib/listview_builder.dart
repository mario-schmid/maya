import 'package:flutter/material.dart';
import 'package:maya/providers/mayadata.dart';

import '../data/maya_alarm.dart';
import '../data/maya_day.dart';
import '../data/maya_event.dart';
import '../data/maya_note.dart';
import '../data/maya_task.dart';
import '../day_item_widget.dart';
import '../methods/update_list.dart';

ReorderableListView listViewBuilder(
  EdgeInsets edgeInsets,
  ScrollPhysics scrollPhysics,
  Size size,
  Color mainColor,
  int yearIndex,
  int dayIndex,
  MayaData data,
) {
  return ReorderableListView.builder(
    padding: edgeInsets,
    physics: scrollPhysics,
    shrinkWrap: true,
    itemCount: data.mayaData[yearIndex]![dayIndex]!.arrangement.length,
    onReorder: (int oldIndex, int newIndex) {
      updateList(oldIndex, newIndex, yearIndex, dayIndex, data);
    },
    itemBuilder: (BuildContext context, int listIndex) {
      final Day dayData = data.mayaData[yearIndex]![dayIndex]!;
      final String type = dayData.arrangement[listIndex].type;
      final int elementIndex = dayData.arrangement[listIndex].elementIndex;
      final DayItemWidget dayItemWidget = DayItemWidget(
        context: context,
        size: size,
        mainColor: mainColor,
        yearIndex: yearIndex,
        dayIndex: dayIndex,
        listIndex: listIndex,
        elementIndex: elementIndex,
        data: data,
      );

      if (type == 'event') {
        final Event event = dayData.eventList[elementIndex];
        return dayItemWidget.event(
          event.uuid,
          event.begin,
          event.end,
          event.title,
          event.description,
        );
      }
      if (type == 'note') {
        final Note note = dayData.noteList[elementIndex];
        return dayItemWidget.note(note.uuid, note.entry);
      }
      if (type == 'task') {
        final Task task = dayData.taskList[elementIndex];
        return dayItemWidget.task(task.uuid, task.description, task.isChecked);
      }
      if (type == 'alarm') {
        final MayaAlarm alarm = dayData.alarmList[elementIndex];
        return dayItemWidget.alarm(
          alarm.uuid,
          alarm.alarmSettings,
          alarm.isActive,
        );
      }
      return const SizedBox.shrink();
    },
  );
}
