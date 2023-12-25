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
      'isChecked': isChecked,
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
        'isChecked': isChecked,
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
}
