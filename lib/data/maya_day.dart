import '../data/maya_alarm.dart';
import '../data/maya_event.dart';
import '../data/maya_task.dart';

class Day {
  List<Event> eventList = <Event>[];
  List<String?> noteList = <String?>[];
  List<Task> taskList = <Task>[];
  List<MayaAlarm> alarmList = <MayaAlarm>[];
  List<int> arrangement = <int>[];
}
