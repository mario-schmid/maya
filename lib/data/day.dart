import 'maya_alarm.dart';
import 'event.dart';
import 'task.dart';

class Day {
  List<Event> eventList = <Event>[];
  List<String?> noteList = <String?>[];
  List<Task> taskList = <Task>[];
  List<MayaAlarm> alarmList = <MayaAlarm>[];
  List<int> arrangement = <int>[];
}
