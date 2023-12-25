import 'package:intl/intl.dart';

class TimeFormat {
  static DateFormat _timeFormat = DateFormat('h:mm a');

  DateFormat get getTimeFormat => _timeFormat;

  set setTimeFormat(DateFormat format) => _timeFormat = format;
}
