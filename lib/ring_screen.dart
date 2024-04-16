import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:maya/database_handler.dart';
import 'package:maya/globals.dart';
import 'package:maya/methods/set_index.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:maya/providers/yeardata.dart';
import 'package:provider/provider.dart';

class AlarmRingScreen extends StatelessWidget {
  final ImageProvider backgroundImage;
  final AlarmSettings alarmSettings;

  const AlarmRingScreen(
      {super.key, required this.backgroundImage, required this.alarmSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(alarmSettings.notificationTitle,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  Image.asset('assets/images/icons/hunabku.png',
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
                              //removeAlarm(context, alarmSettings.id);
                            },
                            child: const Text("Stop",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)))
                      ])
                ])));
  }

  void setIsActive(BuildContext context, int id) {
    for (int i = 0; i < YearData().yearData.length; i++) {
      for (int j = 0; j < YearData().yearData[i].length; j++) {
        for (int k = 0; k < YearData().yearData[i][j].alarmList.length; k++) {
          if (YearData().yearData[i][j].alarmList[k].alarmSettings != null &&
              YearData().yearData[i][j].alarmList[k].alarmSettings.id == id) {
            YearData().yearData[i][j].alarmList[k].isActive = false;
            Provider.of<YearData>(context, listen: false)
                .setIsActive(i, j, k, false);

            int elementIndex = 0;
            for (int i = 0; i < arrayIndex[i][j][2].length; i++) {
              if (arrayIndex[i][j][2][i] == 3 && arrayIndex[i][j][3][i] == k) {
                elementIndex = arrayIndex[i][j][4][i];
              }
            }
            DatabaseHandlerAlarms()
                .updateAlarmIsActive(i, j, elementIndex, false);
          }
        }
      }
    }
  }

  void removeAlarm(BuildContext context, int id) {
    for (int i = 0; i < YearData().yearData.length; i++) {
      for (int j = 0; j < YearData().yearData[i].length; j++) {
        for (int k = 0; k < YearData().yearData[i][j].alarmList.length; k++) {
          if (YearData().yearData[i][j].alarmList[k].alarmSettings.id == id) {
            YearData().yearData[i][j].alarmList[k].alarmSettings = null;
            YearData().yearData[i][j].alarmList[k].isActive = false;

            Provider.of<DayItems>(context, listen: false)
                .removeAt(i, j, arrayIndex[i][j][0][k]);
            arrayIndex[i][j][1].removeAt(arrayIndex[i][j][0][k]);
            arrayIndex[i][j][2].removeAt(arrayIndex[i][j][0][k]);
            arrayIndex[i][j][3].removeAt(arrayIndex[i][j][0][k]);
            arrayIndex[i][j][4].removeAt(arrayIndex[i][j][0][k]);
            arrayIndex[i][j][0].removeLast();
            setIndex(i, j);

            DatabaseHandlerAlarms().deleteAlarms(i, j);
            int elementIndexAlarm = 0;
            List<Map<String, dynamic>> listMapAlarms = [];
            for (int i = 0; i < arrayIndex[i][j][2].length; i++) {
              if (arrayIndex[i][j][2][i] == 3) {
                listMapAlarms.add({
                  'yearIndex': i,
                  'dayIndex': i,
                  'elementIndex': elementIndexAlarm,
                  'alarmSettings': YearData()
                      .yearData[i][j]
                      .alarmList[arrayIndex[i][j][3][i]]
                      .alarmSettings,
                  'isActive': YearData()
                      .yearData[i][j]
                      .alarmList[arrayIndex[i][j][3][i]]
                      .isActive
                });
                elementIndexAlarm++;
              }
            }
            if (listMapAlarms.isNotEmpty) {
              DatabaseHandlerAlarms().insertAlarmList(listMapAlarms);
            }

            if (arrayIndex[i][j][2].isNotEmpty) {
              DatabaseHandlerArrangements()
                  .updateArrangement(i, j, arrayIndex[i][j][2].toString());
            } else {
              DatabaseHandlerArrangements().deleteArrangement(i, j);
            }
            break;
          }
        }
      }
    }
  }
}
