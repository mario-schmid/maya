import '../data/maya_alarm.dart';
import '../data/maya_event.dart';
import '../data/maya_location.dart';
import '../data/maya_note.dart';
import '../data/maya_task.dart';

class Day {
  List<Event> eventList = <Event>[];
  List<Note> noteList = <Note>[];
  List<Task> taskList = <Task>[];
  List<MayaAlarm> alarmList = <MayaAlarm>[];
  List<Location> arrangement = <Location>[];
}
