import 'package:alarm/alarm.dart';

class SetStopAlarm {
  setAlarm(alarmSettings) async {
    await Alarm.set(alarmSettings: alarmSettings);
  }

  stopAlarm(id) async {
    await Alarm.stop(id);
  }
}
