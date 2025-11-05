import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/maya_alarm.dart';
import '../database_handler.dart';
import '../providers/mayadata.dart';

class AlarmRingScreen extends StatelessWidget {
  final Color mainColor;
  final ImageProvider backgroundImage;
  final String alarmSnoozeIndex;
  final AlarmSettings alarmSettings;

  const AlarmRingScreen({
    super.key,
    required this.mainColor,
    required this.backgroundImage,
    required this.alarmSnoozeIndex,
    required this.alarmSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    alarmSettings.notificationSettings.title,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    alarmSettings.notificationSettings.body,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 160),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      final now = DateTime.now();
                      Alarm.set(
                        alarmSettings: alarmSettings.copyWith(
                          dateTime:
                              DateTime(
                                now.year,
                                now.month,
                                now.day,
                                now.hour,
                                now.minute,
                                0,
                                0,
                              ).add(
                                Duration(
                                  minutes: int.parse(alarmSnoozeIndex) + 1,
                                ),
                              ),
                        ),
                      ).then(
                        (_) => context.mounted ? Navigator.pop(context) : null,
                      );
                    },
                    child: const Text(
                      "Snooze",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Alarm.stop(alarmSettings.id).then(
                        (_) => context.mounted ? Navigator.pop(context) : null,
                      );
                      setIsActive(
                        context,
                        alarmSettings.id,
                        alarmSettings.payload!,
                      );
                    },
                    child: const Text(
                      "Stop",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setIsActive(BuildContext context, int id, String payload) {
    final String strYearIndex = payload.substring(0, 4);
    final String strDayIndex = payload.substring(4, 7);

    final int yearIndex = int.parse(strYearIndex);
    final int dayIndex = int.parse(strDayIndex);

    final MayaData data = MayaData();
    final List<MayaAlarm> alarmList =
        data.mayaData[yearIndex]![dayIndex]!.alarmList;

    for (int k = 0; k < alarmList.length; k++) {
      if (alarmList[k].alarmSettings.id == id) {
        data.setIsActive(yearIndex, dayIndex, k, false);

        DatabaseHandlerAlarms().updateAlarmIsActive(
          yearIndex,
          dayIndex,
          k,
          false,
        );
      }
    }
  }
}
