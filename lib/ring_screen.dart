import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:maya/database_handler.dart';
import 'package:maya/globals.dart';
import 'package:maya/providers/mayadata.dart';
import 'package:provider/provider.dart';

class AlarmRingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const AlarmRingScreen({super.key, required this.alarmSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.modulate),
                    image: AssetImage('assets/images/bg_pattern_one.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(alarmSettings.notificationSettings.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                    Text(alarmSettings.notificationSettings.body,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18))
                  ]),
                  Image.asset('assets/images/icons/sign.png',
                      height: 160, width: 160),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                            onPressed: () {
                              final now = DateTime.now();
                              Alarm.set(
                                alarmSettings: alarmSettings.copyWith(
                                  dateTime: DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    now.hour,
                                    now.minute,
                                    0,
                                    0,
                                  ).add(const Duration(minutes: 1)),
                                ),
                              ).then((_) => Navigator.pop(context));
                            },
                            child: const Text("Snooze",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))),
                        RawMaterialButton(
                            onPressed: () {
                              Alarm.stop(alarmSettings.id)
                                  .then((_) => Navigator.pop(context));
                              setIsActive(context, alarmSettings.id);
                            },
                            child: const Text("Stop",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)))
                      ])
                ])));
  }

  void setIsActive(BuildContext context, int id) {
    String strId = id.toString().padLeft(10, '0');
    String strYearIndex = strId.substring(0, 3);
    String strDayIndex = strId.substring(3, 6);

    int yearIndex = 5129 + int.parse(strYearIndex);
    int dayIndex = int.parse(strDayIndex);
    int k = 0;
    for (k = 0;
        k < MayaData().mayaData[yearIndex][dayIndex].alarmList.length;
        k++) {
      if (MayaData().mayaData[yearIndex][dayIndex].alarmList[k].alarmSettings !=
              null &&
          MayaData()
                  .mayaData[yearIndex][dayIndex]
                  .alarmList[k]
                  .alarmSettings
                  .id ==
              id) {
        MayaData().mayaData[yearIndex][dayIndex].alarmList[k].isActive = false;
        Provider.of<MayaData>(context, listen: false)
            .setIsActive(yearIndex, dayIndex, k, false);

        int elementIndex = 0;
        for (int i = 0;
            i < Globals().arrayIndex[yearIndex][dayIndex][2].length;
            i++) {
          if (Globals().arrayIndex[yearIndex][dayIndex][2][i] == 3 &&
              Globals().arrayIndex[yearIndex][dayIndex][3][i] == k) {
            elementIndex = Globals().arrayIndex[yearIndex][dayIndex][4][i];
          }
        }
        DatabaseHandlerAlarms()
            .updateAlarmIsActive(yearIndex, dayIndex, elementIndex, false);
      }
    }
  }
}
