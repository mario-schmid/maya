import 'maya_alarm.dart';
import 'maya_event.dart';
import 'maya_task.dart';

class Day {
  List<Event> eventList = <Event>[];
  List<String?> noteList = <String?>[];
  List<Task> taskList = <Task>[];
  List<MayaAlarm> alarmList = <MayaAlarm>[];
  List<int> arrangement = <int>[];
}
