import 'package:alarm/alarm.dart' as alarm_prefix;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../alarm_dialog.dart';
import '../event_dialog.dart';
import '../helper/shared_prefs.dart';
import '../note_dialog.dart';
import '../task_dialog.dart';

Center selectionDialog(
  BuildContext context,
  Color mainColor,
  int yearIndex,
  int dayIndex,
  DateTime dateTime,
) {
  const TextStyle textStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );

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
                      Colors.orange,
                      BlendMode.modulate,
                    ),
                    image: AssetImage('assets/images/bg_pattern_two.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  splashColor: Colors.orange[600],
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EventDialog(
                          mainColor: mainColor,
                          yearIndex: yearIndex,
                          dayIndex: dayIndex,
                          elementIndex: null,
                          begin: '',
                          end: '',
                          title: '',
                          description: '',
                          create: true,
                        );
                      },
                    );
                  },
                  child: Text('Event'.tr, style: textStyle),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.green,
                      BlendMode.modulate,
                    ),
                    image: AssetImage('assets/images/bg_pattern_two.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  splashColor: Colors.green[600],
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NoteDialog(
                          mainColor: mainColor,
                          yearIndex: yearIndex,
                          dayIndex: dayIndex,
                          elementIndex: null,
                          entry: '',
                          create: true,
                        );
                      },
                    );
                  },
                  child: Text('Note'.tr, style: textStyle),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.blue,
                      BlendMode.modulate,
                    ),
                    image: AssetImage('assets/images/bg_pattern_two.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  splashColor: Colors.blue[600],
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TaskDialog(
                          mainColor: mainColor,
                          yearIndex: yearIndex,
                          dayIndex: dayIndex,
                          elementIndex: null,
                          description: '',
                          create: true,
                        );
                      },
                    );
                  },
                  child: Text('Task'.tr, style: textStyle),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.red,
                      BlendMode.modulate,
                    ),
                    image: AssetImage('assets/images/bg_pattern_two.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  splashColor: Colors.red[600],
                  onPressed: () async {
                    String customAlarmSoundPath =
                        (await SharedPrefs.readCustomAlarmSoundPath())
                            .toString();
                    String alarmSoundIndex =
                        (await SharedPrefs.readAlarmSoundIndex()).toString();
                    String globalAlarmSoundVolume =
                        (await SharedPrefs.readGlobalAlarmSoundVolume())
                            .toString();

                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ADialog(
                          mainColor: mainColor,
                          yearIndex: yearIndex,
                          dayIndex: dayIndex,
                          elementIndex: null,
                          chosenGregorianDate: dateTime,
                          alarmSettings: alarm_prefix.AlarmSettings(
                            id: 0,
                            payload: '',
                            dateTime: dateTime,
                            assetAudioPath: '',
                            loopAudio: true,
                            vibrate: false,
                            volumeSettings: alarm_prefix.VolumeSettings.fade(
                              volume: 0.5,
                              fadeDuration: Duration(milliseconds: 500),
                            ),
                            notificationSettings:
                                alarm_prefix.NotificationSettings(
                                  title: '',
                                  body: '',
                                  stopButton: 'Stop',
                                  icon: 'ic_stat_sign',
                                  iconColor: Color(0xff000000),
                                ),
                            warningNotificationOnKill: true,
                          ),
                          alarmSoundIndex: alarmSoundIndex,
                          customAlarmSoundPath: customAlarmSoundPath,
                          globalAlarmSoundVolume: globalAlarmSoundVolume,
                          create: true,
                        );
                      },
                    );
                  },
                  child: Text('Alarm'.tr, style: textStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
