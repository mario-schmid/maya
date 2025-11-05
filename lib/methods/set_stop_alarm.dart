import 'package:alarm/alarm.dart';

void setAlarm(AlarmSettings alarmSettings) async {
  await Alarm.set(alarmSettings: alarmSettings);
}

void stopAlarm(int id) async {
  await Alarm.stop(id);
}
