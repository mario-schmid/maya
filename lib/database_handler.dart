import 'dart:convert';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:archive/archive.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../providers/mayadata.dart';

class DatabaseHandlerEvents {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    _db = await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'events.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE events(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, begin TEXT NOT NULL, end TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        // old version: 1
        if (oldVersion < 2) {
          await database.transaction((txn) async {
            await txn.execute(
              """CREATE TABLE events_new(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, begin TEXT NOT NULL, end TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL)""",
            );

            List<Map<String, dynamic>> oldItems = await txn.query('events');

            Uuid uuid = Uuid();
            for (var oldItem in oldItems) {
              final String newId = uuid.v4();
              await txn.insert('events_new', {
                'yearIndex': oldItem['yearIndex'],
                'dayIndex': oldItem['dayIndex'],
                'elementIndex': oldItem['elementIndex'],
                'uuid': newId,
                'begin': oldItem['begin'],
                'end': oldItem['end'],
                'title': oldItem['title'],
                'description': oldItem['description'],
              });
            }

            await txn.execute("DROP TABLE events;");

            await txn.execute("ALTER TABLE events_new RENAME TO events;");
          });
        }
      },
      version: 2,
    );
  }

  Future<int> insertEvent(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String uuid,
    String begin,
    String end,
    String title,
    String description,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('events', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'uuid': uuid,
      'begin': begin,
      'end': end,
      'title': title,
      'description': description,
    });
    return result;
  }

  void insertEventList(List<Map<String, dynamic>> listMapEvents) async {
    final Database db = await initializeDB();
    for (var element in listMapEvents) {
      await db.insert('events', element);
    }
  }

  Future<int> updateEvent(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String begin,
    String end,
    String title,
    String description,
  ) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'events',
      {'begin': begin, 'end': end, 'title': title, 'description': description},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteEvent(
    int yearIndex,
    int dayIndex,
    int elementIndex,
  ) async {
    final Database db = await initializeDB();
    await db.delete(
      'events',
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
  }

  Future<void> deleteEvents(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'events',
      where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex',
    );
  }

  Future<List<Map<String, dynamic>>> retrieveEvents() async {
    final Database db = await initializeDB();
    return await db.query(
      'events',
      orderBy: 'yearIndex ASC, dayIndex ASC, elementIndex ASC',
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

class DatabaseHandlerNotes {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    _db = await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'notes.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE notes(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, entry TEXT NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        // old version: 1
        if (oldVersion < 2) {
          await database.transaction((txn) async {
            await txn.execute(
              """CREATE TABLE notes_new(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, entry TEXT NOT NULL)""",
            );

            List<Map<String, dynamic>> oldItems = await txn.query('notes');

            Uuid uuid = Uuid();
            for (var oldItem in oldItems) {
              final String newId = uuid.v4();
              await txn.insert('notes_new', {
                'yearIndex': oldItem['yearIndex'],
                'dayIndex': oldItem['dayIndex'],
                'elementIndex': oldItem['elementIndex'],
                'uuid': newId,
                'entry': oldItem['note'],
              });
            }

            await txn.execute("DROP TABLE notes;");

            await txn.execute("ALTER TABLE notes_new RENAME TO notes;");
          });
        }
      },
      version: 2,
    );
  }

  Future<int> insertNote(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String uuid,
    String entry,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('notes', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'uuid': uuid,
      'entry': entry,
    });
    return result;
  }

  void insertNoteList(List<Map<String, dynamic>> listMapNotes) async {
    final Database db = await initializeDB();
    for (var element in listMapNotes) {
      await db.insert('notes', element);
    }
  }

  Future<int> updateNote(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String entry,
  ) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'notes',
      {'entry': entry},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteNote(int yearIndex, int dayIndex, int elementIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'notes',
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
  }

  Future<void> deleteNotes(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'notes',
      where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex',
    );
  }

  Future<List<Map<String, dynamic>>> retrieveNotes() async {
    final Database db = await initializeDB();
    return await db.query(
      'notes',
      orderBy: 'yearIndex ASC, dayIndex ASC, elementIndex ASC',
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

class DatabaseHandlerTasks {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    _db = await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, description TEXT NOT NULL, isChecked INTEGER NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        // old version: 1
        if (oldVersion < 2) {
          await database.transaction((txn) async {
            await txn.execute(
              """CREATE TABLE tasks_new(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, description TEXT NOT NULL, isChecked INTEGER NOT NULL)""",
            );

            List<Map<String, dynamic>> oldItems = await txn.query('tasks');

            Uuid uuid = Uuid();
            for (var oldItem in oldItems) {
              final String newId = uuid.v4();
              await txn.insert('tasks_new', {
                'yearIndex': oldItem['yearIndex'],
                'dayIndex': oldItem['dayIndex'],
                'elementIndex': oldItem['elementIndex'],
                'uuid': newId,
                'description': oldItem['text'],
                'isChecked': oldItem['isChecked'],
              });
            }

            await txn.execute("DROP TABLE tasks;");

            await txn.execute("ALTER TABLE tasks_new RENAME TO tasks;");
          });
        }
      },
      version: 2,
    );
  }

  Future<int> insertTask(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String uuid,
    String description,
    bool isChecked,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('tasks', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'uuid': uuid,
      'description': description,
      'isChecked': isChecked ? 1 : 0,
    });
    return result;
  }

  void insertTaskList(List<Map<String, dynamic>> listMapTasks) async {
    final Database db = await initializeDB();
    for (var element in listMapTasks) {
      await db.insert('tasks', element);
    }
  }

  Future<int> updateTaskDescription(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String description,
  ) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'tasks',
      {'description': description},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<int> updateTaskIsChecked(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    bool isChecked,
  ) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'tasks',
      {'isChecked': isChecked ? 1 : 0},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteTask(int yearIndex, int dayIndex, int elementIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'tasks',
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
  }

  Future<void> deleteTasks(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'tasks',
      where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex',
    );
  }

  Future<List<Map<String, dynamic>>> retrieveTasks() async {
    final Database db = await initializeDB();
    return await db.query(
      'tasks',
      orderBy: 'yearIndex ASC, dayIndex ASC, elementIndex ASC',
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

class DatabaseHandlerAlarms {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    _db = await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'alarms.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE alarms(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, id INTEGER NOT NULL, payload TEXT NOT NULL, dateTime TEXT NOT NULL, assetAudioPath TEXT NOT NULL, loopAudio INTEGER NOT NULL, vibrate INTEGER NOT NULL, volume STRING NOT NULL, notificationTitle TEXT NOT NULL, notificationBody TEXT NOT NULL, warningNotificationOnKill INTEGER NOT NULL, isActive INTEGER NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        // old version: 1
        if (oldVersion < 2) {
          await database.transaction((txn) async {
            await txn.execute(
              """CREATE TABLE alarms_new(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, elementIndex INTEGER NOT NULL, uuid TEXT PRIMARY KEY, id INTEGER NOT NULL, payload TEXT NOT NULL, dateTime TEXT NOT NULL, assetAudioPath TEXT NOT NULL, loopAudio INTEGER NOT NULL, vibrate INTEGER NOT NULL, volume STRING NOT NULL, notificationTitle TEXT NOT NULL, notificationBody TEXT NOT NULL, warningNotificationOnKill INTEGER NOT NULL, isActive INTEGER NOT NULL)""",
            );

            List<Map<String, dynamic>> oldItems = await txn.query('alarms');

            Uuid uuid = Uuid();
            for (var oldItem in oldItems) {
              final String newId = uuid.v4();
              await txn.insert('alarms_new', {
                'yearIndex': oldItem['yearIndex'],
                'dayIndex': oldItem['dayIndex'],
                'elementIndex': oldItem['elementIndex'],
                'uuid': newId,
                'id': oldItem['id'],
                'payload': (oldItem['id'] + 51410000000).toString(),
                'dateTime': oldItem['dateTime'],
                'assetAudioPath': oldItem['assetAudioPath'],
                'loopAudio': oldItem['loopAudio'],
                'vibrate': oldItem['vibrate'],
                'volume': oldItem['volume'],
                'notificationTitle': oldItem['notificationTitle'],
                'notificationBody': oldItem['notificationBody'],
                'warningNotificationOnKill':
                    oldItem['enableNotificationOnKill'],
                'isActive': oldItem['isActive'],
              });
            }

            await txn.execute("DROP TABLE alarms;");

            await txn.execute("ALTER TABLE alarms_new RENAME TO alarms;");
          });
        }
      },
      version: 2,
    );
  }

  Future<int> insertAlarm(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    String uuid,
    AlarmSettings alarmSettings,
    bool isActive,
  ) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('alarms', {
      'yearIndex': yearIndex,
      'dayIndex': dayIndex,
      'elementIndex': elementIndex,
      'uuid': uuid,
      'id': alarmSettings.id,
      'payload': alarmSettings.payload,
      'dateTime': dateTimeformat.format(alarmSettings.dateTime),
      'assetAudioPath': alarmSettings.assetAudioPath,
      'loopAudio': alarmSettings.loopAudio ? 1 : 0,
      'vibrate': alarmSettings.vibrate ? 1 : 0,
      'volume': alarmSettings.volumeSettings.volume.toString(),
      'notificationTitle': alarmSettings.notificationSettings.title,
      'notificationBody': alarmSettings.notificationSettings.body,
      'warningNotificationOnKill': alarmSettings.warningNotificationOnKill
          ? 1
          : 0,
      'isActive': isActive ? 1 : 0,
    });
    return result;
  }

  Future<int> updateAlarmSettings(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    AlarmSettings alarmSettings,
  ) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    final Database db = await initializeDB();
    var result = await db.update(
      'alarms',
      {
        'id': alarmSettings.id,
        'payload': alarmSettings.payload,
        'dateTime': dateTimeformat.format(alarmSettings.dateTime),
        'assetAudioPath': alarmSettings.assetAudioPath,
        'loopAudio': alarmSettings.loopAudio ? 1 : 0,
        'vibrate': alarmSettings.vibrate ? 1 : 0,
        'volume': alarmSettings.volumeSettings.volume.toString(),
        'notificationTitle': alarmSettings.notificationSettings.title,
        'notificationBody': alarmSettings.notificationSettings.body,
        'warningNotificationOnKill': alarmSettings.warningNotificationOnKill
            ? 1
            : 0,
      },
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  void insertAlarmList(List<Map<String, dynamic>> listMapAlarms) async {
    DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
    final Database db = await initializeDB();
    for (var elements in listMapAlarms) {
      await db.insert('alarms', {
        'yearIndex': elements['yearIndex'],
        'dayIndex': elements['dayIndex'],
        'elementIndex': elements['elementIndex'],
        'uuid': elements['uuid'],
        'id': elements['alarmSettings'].id,
        'payload': elements['alarmSettings'].payload,
        'dateTime': dateTimeformat.format(elements['alarmSettings'].dateTime),
        'assetAudioPath': elements['alarmSettings'].assetAudioPath,
        'loopAudio': elements['alarmSettings'].loopAudio ? 1 : 0,
        'vibrate': elements['alarmSettings'].vibrate ? 1 : 0,
        'volume': elements['alarmSettings'].volumeSettings.volume.toString(),
        'notificationTitle':
            elements['alarmSettings'].notificationSettings.title,
        'notificationBody': elements['alarmSettings'].notificationSettings.body,
        'warningNotificationOnKill':
            elements['alarmSettings'].warningNotificationOnKill ? 1 : 0,
        'isActive': elements['isActive'],
      });
    }
  }

  Future<int> updateAlarmIsActive(
    int yearIndex,
    int dayIndex,
    int elementIndex,
    bool isActive,
  ) async {
    final Database db = await initializeDB();
    var result = await db.update(
      'alarms',
      {'isActive': isActive ? 1 : 0},
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
    return result;
  }

  Future<void> deleteAlarm(
    int yearIndex,
    int dayIndex,
    int elementIndex,
  ) async {
    final Database db = await initializeDB();
    await db.delete(
      'alarms',
      where:
          'yearIndex = $yearIndex AND dayIndex = $dayIndex AND elementIndex = $elementIndex',
    );
  }

  Future<void> deleteAlarms(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'alarms',
      where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex',
    );
  }

  Future<List<Map<String, dynamic>>> retrieveAlarms() async {
    final Database db = await initializeDB();
    return await db.query(
      'alarms',
      orderBy: 'yearIndex ASC, dayIndex ASC, elementIndex ASC',
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

class DatabaseHandlerArrangements {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    _db = await initializeDB();
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'arrangements.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE arrangements(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, arrangement TEXT NOT NULL)",
        );
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        // old version: 1
        if (oldVersion < 2) {
          await database.transaction((txn) async {
            await txn.execute(
              """CREATE TABLE arrangements_new(yearIndex INTEGER NOT NULL, dayIndex INTEGER NOT NULL, arrangement TEXT NOT NULL)""",
            );

            List<Map<String, dynamic>> oldItems = await txn.query(
              'arrangements',
            );

            for (var oldItem in oldItems) {
              String strArrangement = oldItem['arrangement'];

              String removedBrackets = strArrangement.substring(
                1,
                strArrangement.length - 1,
              );
              List<String> arrangementListStr = removedBrackets.split(',');
              List<int> arrangementListInt = arrangementListStr
                  .map((data) => int.parse(data))
                  .toList();

              int l = 0;
              int m = 0;
              int n = 0;
              int o = 0;
              List<Map<String, dynamic>> arrangementListMap = [];
              for (int i = 0; i < arrangementListInt.length; i++) {
                if (arrangementListInt[i] == 0) {
                  arrangementListMap.add({'type': 'event', 'elementIndex': l});
                  l++;
                }
                if (arrangementListInt[i] == 1) {
                  arrangementListMap.add({'type': 'note', 'elementIndex': m});
                  m++;
                }
                if (arrangementListInt[i] == 2) {
                  arrangementListMap.add({'type': 'task', 'elementIndex': n});
                  n++;
                }
                if (arrangementListInt[i] == 3) {
                  arrangementListMap.add({'type': 'alarm', 'elementIndex': o});
                  o++;
                }
              }

              await txn.insert('arrangements_new', {
                'yearIndex': oldItem['yearIndex'],
                'dayIndex': oldItem['dayIndex'],
                'arrangement': jsonEncode(arrangementListMap),
              });
            }

            await txn.execute("DROP TABLE arrangements;");

            await txn.execute(
              "ALTER TABLE arrangements_new RENAME TO arrangements;",
            );
          });
        }
      },
      version: 2,
    );
  }

  Future<int> insertArrangement(
    int yearIndex,
    int dayIndex,
    String arrangement,
  ) async {
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
    int yearIndex,
    int dayIndex,
    String arrangement,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.update('arrangements', {
      'arrangement': arrangement,
    }, where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex');
    return result;
  }

  Future<void> deleteArrangement(int yearIndex, int dayIndex) async {
    final Database db = await initializeDB();
    await db.delete(
      'arrangements',
      where: 'yearIndex = $yearIndex AND dayIndex = $dayIndex',
    );
  }

  Future<List<Map<String, dynamic>>> retrieveArrangements() async {
    final Database db = await initializeDB();
    return await db.query(
      'arrangements',
      orderBy: 'yearIndex ASC, dayIndex ASC',
    );
  }

  Future<void> closeDatabase() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

final List<String> _dbNames = [
  "events.db",
  "notes.db",
  "tasks.db",
  "alarms.db",
  "arrangements.db",
];

Future<void> saveBackupToDownloads() async {
  try {
    final String dbFolder = await getDatabasesPath();
    final archive = Archive();

    for (String name in _dbNames) {
      final File dbFile = File(join(dbFolder, name));
      if (await dbFile.exists()) {
        final bytes = await dbFile.readAsBytes();
        archive.addFile(ArchiveFile(name, bytes.length, bytes));
      }
    }

    final zipEncoder = ZipEncoder();
    final List<int> zipData = zipEncoder.encode(archive);

    final String downloadsPath =
        await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOAD,
        );

    final String timestamp = DateFormat(
      'yyyyMMdd_HHmmss',
    ).format(DateTime.now());
    final File zipFile = File(
      join(downloadsPath, 'Maya_Backup_$timestamp.zip'),
    );

    await zipFile.writeAsBytes(zipData);
    debugPrint("Backup ZIP gespeichert: ${zipFile.path}");
  } catch (e) {
    debugPrint("ZIP Backup fehlgeschlagen: $e");
  }
}

Future<void> backupDatabases(BuildContext context) async {
  try {
    final String dbFolder = await getDatabasesPath();
    final tempDir = await getTemporaryDirectory();
    final archive = Archive();

    for (String name in _dbNames) {
      final File dbFile = File(join(dbFolder, name));
      if (await dbFile.exists()) {
        final bytes = await dbFile.readAsBytes();
        archive.addFile(ArchiveFile(name, bytes.length, bytes));
      }
    }

    final zipFile = File(join(tempDir.path, 'Maya_Backup.zip'));
    await zipFile.writeAsBytes(ZipEncoder().encode(archive));

    if (!context.mounted) return;
    final box = context.findRenderObject() as RenderBox?;

    await SharePlus.instance.share(
      ShareParams(
        text: 'Maya Database Backup',
        subject: 'Maya Backup ZIP',
        files: [XFile(zipFile.path)],
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      ),
    );
  } catch (e) {
    debugPrint("Backup Share Error: $e");
  }
}

Future<void> restoreDatabases(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['zip'],
  );

  if (result != null && result.files.single.path != null) {
    if (context.mounted) {
      await _processRestore(File(result.files.single.path!), context);
    }
  }
}

Future<void> _processRestore(File zipFile, BuildContext context) async {
  try {
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final String dbFolder = await getDatabasesPath();

    // 1. Verbindungen schließen
    await DatabaseHandlerEvents().closeDatabase();
    await DatabaseHandlerNotes().closeDatabase();
    await DatabaseHandlerTasks().closeDatabase();
    await DatabaseHandlerAlarms().closeDatabase();
    await DatabaseHandlerArrangements().closeDatabase();

    // 2. Dateien extrahieren
    for (final file in archive) {
      if (file.isFile && _dbNames.contains(file.name)) {
        final String destinationPath = join(dbFolder, file.name);

        // Journal-Dateien löschen
        await _deleteJournalFiles(file.name);

        final File dbFile = File(destinationPath);
        final content = file.content;
        await dbFile.writeAsBytes(content);

        debugPrint("Restored: ${file.name}");
      }
    }

    if (context.mounted) {
      _showSuccessAndRestart(context);
    }
  } catch (e) {
    debugPrint("Restore Error: $e");
  }
}

Future<void> _deleteJournalFiles(String dbName) async {
  final dbFolder = await getDatabasesPath();
  final List<String> extensions = ["-wal", "-shm", "-journal"];

  for (var ext in extensions) {
    final file = File(join(dbFolder, "$dbName$ext"));
    if (await file.exists()) {
      await file.delete();
    }
  }
}

void _showSuccessAndRestart(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Restore Complete"),
      content: const Text(
        "Data has been restored. The app will now refresh to apply changes.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<MayaData>(context, listen: false).clearAllData();
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
