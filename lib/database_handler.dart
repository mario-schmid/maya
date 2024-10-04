import 'package:alarm/alarm.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandlerEvents {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'events.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE events(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, begin TEXT NOT NULL, end TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertEvent(int yearIndex, int dayIndex, int elementIndex,
      String begin, String end, String title, String description) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('events', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'begin': begin,
      'end': end,
      'title': title,
      'description': description
    });
    return result;
  }

  insertEventList(List<Map<String, dynamic>> listMapEvents) async {
    final Database db = await initializeDB();
    for (var element in listMapEvents) {
      await db.insert('events', element);
    }
  }

  Future<int> updateEvent(int yearIndex, int dayIndex, int elementIndex,
      String begin, String end, String title, String description) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'events',
      {'begin': begin, 'end': end, 'title': title, 'description': description},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteEvents(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete('events',
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
  }

  Future<Iterable<List<Object?>>> retrieveEvents() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('events');
    Iterable<List<Object?>> eventList =
        queryResult.map((e) => e.values.toList());
    return eventList;
  }

  //TODO: remove in the future
  Future<bool> updateYear() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> eventResult = await db.query('events');

    if (eventResult.isNotEmpty) {
      var existingYears = {};
      for (var e in eventResult) {
        existingYears.putIfAbsent("${e['yearIndex']}", () => e);
      }
      List result = existingYears.keys.toList();
      for (var year in result) {
        await db.update(
          'events',
          {
            'yearIndex': 5129 + int.parse(year),
          },
          where: 'yearIndex = $year',
        );
      }
      return true;
    } else {
      return false;
    }
  }
}

class DatabaseHandlerNotes {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'notes.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE notes(yearIndex INTAGER NOT NULL, dayIndex INTAGER NOT NULL, elementIndex INTEGER NOT NULL, note TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertNote(
      int yearIndex, int dayIndex, int elementIndex, String note) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('notes', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'note': note,
    });
    return result;
  }

  insertNoteList(List<Map<String, dynamic>> listMapNotes) async {
    final Database db = await initializeDB();
    for (var element in listMapNotes) {
      await db.insert('notes', element);
    }
  }

  Future<int> updateNote(
      int yearIndex, int dayIndex, int elementIndex, String note) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'notes',
      {
        'note': note,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteNotes(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete('notes',
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
  }

  Future<Iterable<List<Object?>>> retrieveNotes() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('notes');
    Iterable<List<Object?>> noteList =
        queryResult.map((e) => e.values.toList());
    return noteList;
  }

  //TODO: remove in the future
  Future<bool> updateYear() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> noteResult = await db.query('notes');

    if (noteResult.isNotEmpty) {
      var existingYears = {};
      for (var e in noteResult) {
        existingYears.putIfAbsent("${e['yearIndex']}", () => e);
      }
      List result = existingYears.keys.toList();
      for (var year in result) {
        await db.update(
          'notes',
          {
            'yearIndex': 5129 + int.parse(year),
          },
          where: 'yearIndex = $year',
        );
      }
      return true;
    } else {
      return false;
    }
  }
}

class DatabaseHandlerTasks {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(yearIndex INTAGER NOT NULL, dayIndex INTAGER NOT NULL, elementIndex INTEGER NOT NULL, text TEXT NOT NULL, isChecked INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(int yearIndex, int dayIndex, int elementIndex,
      String text, bool isChecked) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('tasks', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'text': text,
      'isChecked': isChecked ? 1 : 0,
    });
    return result;
  }

  insertTaskList(List<Map<String, dynamic>> listMapTasks) async {
    final Database db = await initializeDB();
    for (var element in listMapTasks) {
      await db.insert('tasks', element);
    }
  }

  Future<int> updateTaskText(
      int yearIndex, int dayIndex, int elementIndex, String text) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'tasks',
      {
        'text': text,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<int> updateTaskIsChecked(
      int yearIndex, int dayIndex, int elementIndex, bool isChecked) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'tasks',
      {
        'isChecked': isChecked ? 1 : 0,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteTasks(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete('tasks',
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
  }

  Future<Iterable<List<Object?>>> retrieveTasks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    Iterable<List<Object?>> taskList =
        queryResult.map((e) => e.values.toList());
    return taskList;
  }

  //TODO: remove in the future
  Future<bool> updateYear() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> taskResult = await db.query('tasks');

    if (taskResult.isNotEmpty) {
      var existingYears = {};
      for (var e in taskResult) {
        existingYears.putIfAbsent("${e['yearIndex']}", () => e);
      }
      List result = existingYears.keys.toList();
      for (var year in result) {
        await db.update(
          'tasks',
          {
            'yearIndex': 5129 + int.parse(year),
          },
          where: 'yearIndex = $year',
        );
      }
      return true;
    } else {
      return false;
    }
  }
}

class DatabaseHandlerAlarms {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'alarms.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE alarms(yearIndex INTAGER NOT NULL, dayIndex INTAGER NOT NULL, elementIndex INTAGER NOT NULL, id INTAGER NOT NULL, dateTime TEXT NOT NULL, assetAudioPath TEXT NOT NULL, loopAudio INTAGER NOT NULL, vibrate INTAGER NOT NULL, volume STRING NOT NULL, fadeDuration STRING NOT NULL, notificationTitle TEXT NOT NULL, notificationBody TEXT NOT NULL, enableNotificationOnKill INTAGER NOT NULL, isActive INTAGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertAlarm(int yearIndex, int dayIndex, int elementIndex,
      AlarmSettings alarmSettings, bool isActive) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('alarms', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'id': alarmSettings.id,
      'dateTime': dateTimeformat.format(alarmSettings.dateTime),
      'assetAudioPath': alarmSettings.assetAudioPath,
      'loopAudio': alarmSettings.loopAudio ? 1 : 0,
      'vibrate': alarmSettings.vibrate ? 1 : 0,
      'volume': alarmSettings.volume.toString(),
      'fadeDuration': alarmSettings.fadeDuration.toString(),
      'notificationTitle': alarmSettings.notificationSettings.title,
      'notificationBody': alarmSettings.notificationSettings.body,
      'enableNotificationOnKill':
          alarmSettings.warningNotificationOnKill ? 1 : 0,
      'isActive': isActive ? 1 : 0,
    });
    return result;
  }

  insertAlarmList(List<Map<String, dynamic>> listMapAlarms) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    final Database db = await initializeDB();
    for (var elements in listMapAlarms) {
      await db.insert('alarms', {
        'yearIndex': elements['yearIndex'],
        'dayIndex': elements['dayIndex'],
        'elementIndex': elements['elementIndex'],
        'id': elements['alarmSettings'].id,
        'dateTime': dateTimeformat.format(elements['alarmSettings'].dateTime),
        'assetAudioPath': elements['alarmSettings'].assetAudioPath,
        'loopAudio': elements['alarmSettings'].loopAudio ? 1 : 0,
        'vibrate': elements['alarmSettings'].vibrate ? 1 : 0,
        'volume': elements['alarmSettings'].volume.toString(),
        'fadeDuration': elements['alarmSettings'].fadeDuration.toString(),
        'notificationTitle': elements['alarmSettings'].notificationTitle,
        'notificationBody': elements['alarmSettings'].notificationBody,
        'enableNotificationOnKill':
            elements['alarmSettings'].enableNotificationOnKill ? 1 : 0,
        'isActive': elements['isActive'],
      });
    }
  }

  Future<int> updateAlarmSettings(int yearIndex, int dayIndex, int elementIndex,
      AlarmSettings alarmSettings) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    final Database db = await initializeDB();
    var result = await db.update(
      'alarms',
      {
        'id': alarmSettings.id,
        'dateTime': dateTimeformat.format(alarmSettings.dateTime),
        'assetAudioPath': alarmSettings.assetAudioPath,
        'loopAudio': alarmSettings.loopAudio,
        'vibrate': alarmSettings.vibrate,
        'volume': alarmSettings.volume.toString(),
        'fadeDuration': alarmSettings.fadeDuration.toString(),
        'notificationTitle': alarmSettings.notificationSettings.title,
        'notificationBody': alarmSettings.notificationSettings.body,
        'enableNotificationOnKill': alarmSettings.warningNotificationOnKill,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<int> updateAlarmIsActive(
      int yearIndex, int dayIndex, int elementIndex, bool isActive) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'alarms',
      {
        'isActive': isActive ? 1 : 0,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteAlarms(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete('alarms',
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
  }

  Future<Iterable<List<Object?>>> retrieveAlarms() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('alarms');
    Iterable<List<Object?>> alarmList =
        queryResult.map((e) => e.values.toList());
    return alarmList;
  }

  //TODO: remove in the future
  Future<bool> updateYear() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> alarmResult = await db.query('alarms');

    if (alarmResult.isNotEmpty) {
      var existingYears = {};
      for (var e in alarmResult) {
        existingYears.putIfAbsent("${e['yearIndex']}", () => e);
      }
      List result = existingYears.keys.toList();
      for (var year in result) {
        await db.update(
          'alarms',
          {
            'yearIndex': 5129 + int.parse(year),
          },
          where: 'yearIndex = $year',
        );
      }
      return true;
    } else {
      return false;
    }
  }
}

class DatabaseHandlerArrangements {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'arrangements.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE arrangements(yearIndex INTAGER NOT NULL, dayIndex INTAGER NOT NULL, arrangement TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertArrangement(
      int yearIndex, int dayIndex, String arrangement) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('arrangements', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'arrangement': arrangement,
    });
    return result;
  }

  Future<int> updateArrangement(
      int yearIndex, int dayIndex, String arrangement) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.update('arrangements', {'arrangement': arrangement},
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
    return result;
  }

  Future<void> deleteArrangement(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete('arrangements',
        where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
  }

  Future<Iterable<List<Object?>>> retrieveArrangements() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('arrangements');
    Iterable<List<Object?>> arrangementList =
        queryResult.map((e) => e.values.toList());
    return arrangementList;
  }

  //TODO: remove in the future
  Future<bool> updateYear() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> arrangementResult =
        await db.query('arrangements');

    if (arrangementResult.isNotEmpty) {
      var existingYears = {};
      for (var e in arrangementResult) {
        existingYears.putIfAbsent("${e['yearIndex']}", () => e);
      }
      List result = existingYears.keys.toList();
      for (var year in result) {
        await db.update(
          'arrangements',
          {
            'yearIndex': 5129 + int.parse(year),
          },
          where: 'yearIndex = $year',
        );
      }
      return true;
    } else {
      return false;
    }
  }
}
