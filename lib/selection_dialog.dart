import 'package:alarm/alarm.dart';
import 'package:alarm/alarm.dart' as alarm_prefix;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'event_dialog.dart';
import 'note_dialog.dart';
import 'task_dialog.dart';
import 'alarm_dialog.dart';

Center selectionDialog(BuildContext context, Color mainColor, int yearIndex,
    int dayIndex, DateTime dateTime) {
  const TextStyle textstyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  return Center(
      child: SizedBox(
          height: 255,
          width: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 60,
                    width: 200,
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.orange, BlendMode.modulate),
                                  image: AssetImage(
                                      'assets/images/bg_pattern_two.jpg'),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                                splashColor: Colors.orange[600],
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EventDialog(
                                            mainColor: mainColor,
                                            yearIndex: yearIndex,
                                            dayIndex: dayIndex,
                                            begin: '',
                                            end: '',
                                            title: '',
                                            description: '',
                                            flagCreateChange: true);
                                      });
                                },
                                child: Text('Event'.tr, style: textstyle))))),
                SizedBox(
                    height: 60,
                    width: 200,
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.green, BlendMode.modulate),
                                  image: AssetImage(
                                      'assets/images/bg_pattern_two.jpg'),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                                splashColor: Colors.green[600],
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return NoteDialog(
                                            mainColor: mainColor,
                                            yearIndex: yearIndex,
                                            dayIndex: dayIndex,
                                            note: '',
                                            flagCreateChange: true);
                                      });
                                },
                                child: Text('Note'.tr, style: textstyle))))),
                SizedBox(
                    height: 60,
                    width: 200,
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.blue, BlendMode.modulate),
                                  image: AssetImage(
                                      'assets/images/bg_pattern_two.jpg'),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                                splashColor: Colors.blue[600],
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TaskDialog(
                                            mainColor: mainColor,
                                            yearIndex: yearIndex,
                                            dayIndex: dayIndex,
                                            task: '',
                                            flagCreateChange: true);
                                      });
                                },
                                child: Text('Task'.tr, style: textstyle))))),
                SizedBox(
                    height: 60,
                    width: 200,
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.red, BlendMode.modulate),
                                  image: AssetImage(
                                      'assets/images/bg_pattern_two.jpg'),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                                splashColor: Colors.red[600],
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ADialog(
                                            mainColor: mainColor,
                                            yearIndex: yearIndex,
                                            dayIndex: dayIndex,
                                            alarmSettings: AlarmSettings(
                                                id: 0,
                                                dateTime: dateTime,
                                                assetAudioPath: '',
                                                loopAudio: true,
                                                vibrate: false,
                                                volume: 0.5,
                                                fadeDuration: 0.5,
                                                notificationSettings:
                                                    alarm_prefix
                                                        .NotificationSettings(
                                                            title: '',
                                                            body: ''),
                                                warningNotificationOnKill:
                                                    true),
                                            flagCreateChange: true);
                                      });
                                },
                                child: Text('Alarm'.tr, style: textstyle)))))
              ])));
}
