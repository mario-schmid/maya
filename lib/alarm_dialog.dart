import 'dart:convert';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../data/maya_day.dart';
import '../data/maya_location.dart';
import '../database_handler.dart';
import '../helper/maya_list.dart';
import '../helper/maya_style.dart';
import '../methods/set_stop_alarm.dart';
import '../providers/mayadata.dart';
import '../time_format.dart';

class ADialog extends StatefulWidget {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final int? elementIndex;
  final DateTime? chosenGregorianDate;
  final AlarmSettings? alarmSettings;
  final String? alarmSoundIndex;
  final String? customAlarmSoundPath;
  final String? globalAlarmSoundVolume;
  final bool create;
  const ADialog({
    super.key,
    required this.mainColor,
    required this.yearIndex,
    required this.dayIndex,
    required this.elementIndex,
    required this.chosenGregorianDate,
    required this.alarmSettings,
    required this.alarmSoundIndex,
    required this.customAlarmSoundPath,
    required this.globalAlarmSoundVolume,
    required this.create,
  });

  @override
  State<ADialog> createState() => _ADialogState();
}

class _ADialogState extends State<ADialog> {
  late Size size;
  late DateFormat timeFormat;

  late bool hour24;
  late String _hour, _minute, _time;
  String _period = '';

  late TimeOfDay initTime;
  late TimeOfDay selectedTime;

  late String alarmSoundPath;
  late double alarmSoundVolume;

  final _alarmControllerTitle = TextEditingController();
  final _alarmControllerDescription = TextEditingController();

  late DateTime dateTime;
  late bool loopAudio;
  late bool vibrate;

  @override
  void initState() {
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        hour24 = false;
        timeFormat = DateFormat('h:mm a');
        break;
      case 'HH:mm:ss':
        hour24 = true;
        timeFormat = DateFormat('HH:mm');
        break;
    }

    if (widget.create) {
      initTime = TimeOfDay(hour: 13, minute: 00);
      _hour = initTime.hour.toString();
      _minute = initTime.minute.toString();
      _time = hour24 ? '13:00' : '1:00 pm';

      dateTime = widget.chosenGregorianDate!;
      loopAudio = true;
      vibrate = false;
      final int index = int.parse(widget.alarmSoundIndex!);
      if (index != 9) {
        alarmSoundPath = 'assets/${MayaList.listAlarmSoundPath[index]}';
      } else {
        alarmSoundPath = widget.customAlarmSoundPath!;
      }
      alarmSoundVolume = double.parse(widget.globalAlarmSoundVolume!) / 100;
      _alarmControllerTitle.text = '';
      _alarmControllerDescription.text = '';
    } else {
      initTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      _hour = widget.alarmSettings!.dateTime.hour.toString();
      _minute = widget.alarmSettings!.dateTime.minute.toString();
      _time = timeFormat.format(widget.alarmSettings!.dateTime);

      dateTime = widget.alarmSettings!.dateTime;
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      alarmSoundPath = widget.alarmSettings!.assetAudioPath!;
      alarmSoundVolume = widget.alarmSettings!.volumeSettings.volume!;
      _alarmControllerTitle.text =
          widget.alarmSettings!.notificationSettings.title;
      _alarmControllerDescription.text =
          widget.alarmSettings!.notificationSettings.body;
    }

    super.initState();
  }

  Future<void> _selectTime(BuildContext context) async {
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initTime,
          builder: (context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(alwaysUse24HourFormat: false),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            String hourOfPeriod = selectedTime.hourOfPeriod.toString();
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _period = selectedTime.period.name;
            _time = '$hourOfPeriod:$_minute $_period';
          });
        }
        break;
      case 'HH:mm:ss':
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initTime,
          builder: (context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _time = '$_hour:$_minute';
          });
        }
        break;
    }
  }

  TextStyle getTextStyle(Size size) {
    return TextStyle(color: Colors.white, fontSize: size.width * 0.04);
  }

  @override
  void dispose() {
    _alarmControllerTitle.dispose();
    _alarmControllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Align(
          alignment: const Alignment(0, -0.9),
          child: Container(
            height: size.width * 1.1,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.modulate),
                image: AssetImage('assets/images/bg_pattern_one.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.028),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.width * 0.028),
                      child: GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          height: size.width * 0.12,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _time,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.06,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.width * 0.028),
                      child: SizedBox(
                        height: size.width * 0.14,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.036,
                              horizontal: size.width * 0.03,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 1,
                              ),
                            ),
                            filled: false,
                            labelText: 'Title'.tr,
                            labelStyle: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          controller: _alarmControllerTitle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.width * 0.028),
                      child: SizedBox(
                        height: size.width * 0.21,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          style: const TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.036,
                              horizontal: size.width * 0.03,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 1,
                              ),
                            ),
                            filled: false,
                            labelText: 'Description'.tr,
                            labelStyle: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          controller: _alarmControllerDescription,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.12,
                      child: SwitchListTile(
                        inactiveThumbColor: Colors.indigo[400],
                        activeThumbColor: Colors.white,
                        title: Text(
                          'Loop alarm audio'.tr,
                          style: getTextStyle(size),
                        ),
                        value: loopAudio,
                        onChanged: (bool? value) {
                          setState(() {
                            loopAudio = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.12,
                      child: SwitchListTile(
                        inactiveThumbColor: Colors.indigo[400],
                        activeThumbColor: Colors.white,
                        title: Text('Vibrate'.tr, style: getTextStyle(size)),
                        value: vibrate,
                        onChanged: (bool? value) {
                          setState(() {
                            vibrate = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.116,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          alarmSoundVolume < 0.7
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Icon(
                                    Icons.volume_down,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                )
                              : SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.indigo[400],
                              min: 0.0,
                              max: 1.0,
                              value: alarmSoundVolume,
                              onChanged: (value) {
                                setState(() {
                                  alarmSoundVolume = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            '${(alarmSoundVolume * 100).toInt()} %',
                            style: getTextStyle(size),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.width * 0.028,
                            right: size.width * 0.028,
                          ),
                          child: SizedBox(
                            height: size.width * 0.1,
                            width: size.width * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              },
                              style: MayaStyle().transparentButtonStyle(
                                Colors.red[400],
                              ),
                              child: Text('Cancel'.tr),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 0.028),
                          child: SizedBox(
                            height: size.width * 0.1,
                            width: size.width * 0.3,
                            child: ElevatedButton(
                              onPressed: () async {
                                final MayaData data = MayaData();

                                data.mayaData[widget.yearIndex] ??=
                                    <int, Day>{};

                                final Day dayData;
                                if (data.mayaData[widget.yearIndex]![widget
                                        .dayIndex] ==
                                    null) {
                                  data.mayaData[widget.yearIndex]![widget
                                          .dayIndex] =
                                      Day();
                                  dayData =
                                      data.mayaData[widget.yearIndex]![widget
                                          .dayIndex]!;
                                  DatabaseHandlerArrangements()
                                      .insertArrangement(
                                        widget.yearIndex,
                                        widget.dayIndex,
                                        '',
                                      );
                                } else {
                                  dayData =
                                      data.mayaData[widget.yearIndex]![widget
                                          .dayIndex]!;
                                }

                                final DateFormat dateTimeFormat = DateFormat(
                                  "dd.MM.yyyy HH:mm",
                                );
                                final DateFormat dateFormat = DateFormat(
                                  "dd.MM.yyyy",
                                );
                                final String strDate = dateFormat.format(
                                  dateTime,
                                );
                                dateTime = dateTimeFormat.parse(
                                  '$strDate $_hour:$_minute',
                                );

                                final Random random = Random();
                                final int id = random.nextInt(99999999);

                                final AlarmSettings
                                alarmSettings = AlarmSettings(
                                  id: id,
                                  payload:
                                      '${widget.yearIndex.toString()}'
                                      '${widget.dayIndex.toString().padLeft(3, '0')}'
                                      '${_hour.padLeft(2, '0')}'
                                      '${_minute.padLeft(2, '0')}',
                                  dateTime: dateTime,
                                  assetAudioPath: alarmSoundPath,
                                  loopAudio: loopAudio,
                                  vibrate: vibrate,
                                  volumeSettings: VolumeSettings.fade(
                                    volume: alarmSoundVolume,
                                    fadeDuration: Duration(milliseconds: 500),
                                  ),
                                  notificationSettings: NotificationSettings(
                                    title: _alarmControllerTitle.text,
                                    body: _alarmControllerDescription.text,
                                    stopButton: 'Stop',
                                    icon: 'ic_stat_sign',
                                    iconColor: Color(0xff000000),
                                  ),
                                  warningNotificationOnKill: true,
                                );
                                if (widget.create) {
                                  final String uuid = Uuid().v1();
                                  final int eIndex = dayData.alarmList.length;

                                  dayData.arrangement.add(
                                    Location('alarm', eIndex),
                                  );

                                  List<Map<String, dynamic>> arrangementMaps =
                                      dayData.arrangement
                                          .map(
                                            (arrangement) =>
                                                arrangement.toJson(),
                                          )
                                          .toList();

                                  DatabaseHandlerArrangements()
                                      .updateArrangement(
                                        widget.yearIndex,
                                        widget.dayIndex,
                                        jsonEncode(arrangementMaps),
                                      );

                                  Provider.of<MayaData>(
                                    context,
                                    listen: false,
                                  ).addAlarm(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    uuid,
                                    alarmSettings,
                                  );

                                  setAlarm(
                                    dayData.alarmList.last.alarmSettings,
                                  );

                                  DatabaseHandlerAlarms().insertAlarm(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    eIndex,
                                    uuid,
                                    alarmSettings,
                                    true,
                                  );

                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                } else {
                                  stopAlarm(
                                    dayData
                                        .alarmList[widget.elementIndex!]
                                        .alarmSettings
                                        .id,
                                  );

                                  Provider.of<MayaData>(
                                    context,
                                    listen: false,
                                  ).updateAlarm(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    alarmSettings,
                                  );

                                  Provider.of<MayaData>(
                                    context,
                                    listen: false,
                                  ).setIsActive(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    true,
                                  );

                                  DatabaseHandlerAlarms().updateAlarmSettings(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    alarmSettings,
                                  );

                                  DatabaseHandlerAlarms().updateAlarmIsActive(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    true,
                                  );

                                  setAlarm(alarmSettings);

                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                }
                              },
                              style: MayaStyle().transparentButtonStyle(
                                Colors.red[400],
                              ),
                              child: Text('Save'.tr),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
