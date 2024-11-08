import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/maya_style.dart';
import '../maya_items.dart';
import '../methods/get_text_size.dart';
import '../providers/dayitems.dart';
import '../time_format.dart';

class ADialog extends StatefulWidget {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final AlarmSettings alarmSettings;
  final bool flagCreateChange;
  const ADialog(
      {super.key,
      required this.mainColor,
      required this.yearIndex,
      required this.dayIndex,
      required this.alarmSettings,
      required this.flagCreateChange});

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

  late String? alarmSoundPath;
  bool alarmSoundPathChanged = false;

  final _alarmControllerTitle = TextEditingController();
  final _alarmControllerDescription = TextEditingController();

  late TextStyle textStyle;
  late BoxDecoration boxDecoration;
  late DateTime dateTime;
  late bool loopAudio;
  late bool vibrate;
  late double volume;

  @override
  void initState() {
    loadAlarmSoundPath();
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

    if (widget.flagCreateChange) {
      initTime = TimeOfDay(hour: 13, minute: 00);
      _hour = initTime.hour.toString();
      _minute = initTime.minute.toString();
      _time = hour24 ? '13:00' : '1:00 pm';
    } else {
      initTime = TimeOfDay(
          hour: widget.alarmSettings.dateTime.hour,
          minute: widget.alarmSettings.dateTime.minute);
      _hour = widget.alarmSettings.dateTime.hour.toString();
      _minute = widget.alarmSettings.dateTime.minute.toString();
      _time = timeFormat.format(widget.alarmSettings.dateTime);
    }

    dateTime = widget.alarmSettings.dateTime;
    loopAudio = widget.alarmSettings.loopAudio;
    vibrate = widget.alarmSettings.vibrate;
    volume = widget.alarmSettings.volume!;
    _alarmControllerTitle.text =
        widget.alarmSettings.notificationSettings.title;
    _alarmControllerDescription.text =
        widget.alarmSettings.notificationSettings.body;

    super.initState();
  }

  loadAlarmSoundPath() async {
    alarmSoundPath = await readAlarmSoundPath();
  }

  Future<void> _selectTime(BuildContext context) async {
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: initTime,
            builder: (context, Widget? child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!);
            });
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
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!);
            });
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

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    boxDecoration = BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10));
    textStyle = TextStyle(color: Colors.white, fontSize: size.width * 0.04);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _alarmControllerTitle.dispose();
    _alarmControllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
                alignment: const Alignment(0, -0.9),
                child: Container(
                    height: size.width * 1.218,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.red, BlendMode.modulate),
                            image:
                                AssetImage('assets/images/bg_pattern_one.jpg'),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Padding(
                        padding: EdgeInsets.all(size.width * 0.028),
                        child: SizedBox(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.width * 0.028),
                                  child: GestureDetector(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Container(
                                          height: size.width * 0.12,
                                          width: size.width * 0.3,
                                          decoration: boxDecoration,
                                          child: Center(
                                              child: Text(_time,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: size.width *
                                                          0.06)))))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.width * 0.028),
                                  child: SizedBox(
                                      height: size.width * 0.14,
                                      child: TextField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: size.width * 0.036,
                                                  horizontal:
                                                      size.width * 0.03),
                                              focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white54,
                                                          width: 1)),
                                              filled: false,
                                              labelText: 'Title'.tr,
                                              labelStyle: const TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w300),
                                              floatingLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                                          controller: _alarmControllerTitle))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.width * 0.028),
                                  child: SizedBox(
                                      height: size.width * 0.21,
                                      child: TextField(
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          keyboardType: TextInputType.multiline,
                                          minLines: null,
                                          maxLines: null,
                                          expands: true,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: size.width * 0.036,
                                                  horizontal:
                                                      size.width * 0.03),
                                              focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                              enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54,
                                                      width: 1)),
                                              filled: false,
                                              labelText: 'Description'.tr,
                                              labelStyle: const TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w300),
                                              floatingLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                                          controller: _alarmControllerDescription))),
                              SizedBox(
                                  height: size.width * 0.12,
                                  child: SwitchListTile(
                                      inactiveThumbColor: Colors.indigo[400],
                                      activeColor: Colors.white,
                                      title: Text('Loop alarm audio'.tr,
                                          style: textStyle),
                                      value: loopAudio,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          loopAudio = value!;
                                        });
                                      })),
                              SizedBox(
                                  height: size.width * 0.12,
                                  child: SwitchListTile(
                                      inactiveThumbColor: Colors.indigo[400],
                                      activeColor: Colors.white,
                                      title:
                                          Text('Vibrate'.tr, style: textStyle),
                                      value: vibrate,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          vibrate = value!;
                                        });
                                      })),
                              SizedBox(
                                  height: size.width * 0.1,
                                  width: size.width * 0.1,
                                  child: RawMaterialButton(
                                      onPressed: () async {
                                        const params = OpenFileDialogParams(
                                          dialogType:
                                              OpenFileDialogType.document,
                                          sourceType: SourceType.camera,
                                        );
                                        alarmSoundPath =
                                            (await FlutterFileDialog.pickFile(
                                                params: params));
                                        if (alarmSoundPath != null) {
                                          String ext =
                                              alarmSoundPath!.split('.').last;
                                          if (ext == 'mp3' ||
                                              ext == 'wav' ||
                                              ext == 'ogg') {
                                            saveAlarmSoundPath(alarmSoundPath!);
                                            alarmSoundPathChanged = true;
                                          } else {
                                            if (!context.mounted) return;
                                            showAudioFileFormatDialog(context,
                                                widget.mainColor, size);
                                            loadAlarmSoundPath();
                                          }
                                        } else {
                                          loadAlarmSoundPath();
                                        }
                                      },
                                      onLongPress: () {
                                        alarmSoundPath =
                                            'assets/audio/ringtone.mp3';
                                        deleteAlarmSoundPath();
                                        alarmSoundPathChanged = true;
                                      },
                                      child: SvgPicture.asset(
                                          'assets/vector/music_icon.svg',
                                          height: size.width * 0.1,
                                          width: size.width * 0.1))),
                              SizedBox(
                                  height: size.width * 0.134,
                                  child: Slider(
                                      activeColor: Colors.indigo[400],
                                      min: 0.0,
                                      max: 1.0,
                                      value: volume,
                                      onChanged: (value) {
                                        setState(() {
                                          volume = value;
                                        });
                                      })),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.028,
                                            right: size.width * 0.028),
                                        child: SizedBox(
                                            height: size.width * 0.1,
                                            width: size.width * 0.3,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (widget.flagCreateChange) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  } else {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop([false]);
                                                  }
                                                },
                                                style: MayaStyle()
                                                    .transparentButtonStyle(
                                                        Colors.indigo[400]),
                                                child: Text('Cancel'.tr)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.028),
                                        child: SizedBox(
                                            height: size.width * 0.1,
                                            width: size.width * 0.3,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (widget.flagCreateChange) {
                                                    dateTime = dateTime.add(
                                                        Duration(
                                                            hours: int.parse(
                                                                _hour),
                                                            minutes: int.parse(
                                                                _minute)));
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    Provider.of<DayItems>(context, listen: false).add(
                                                        widget.yearIndex,
                                                        widget.dayIndex,
                                                        MayaItems(
                                                                mainColor: widget
                                                                    .mainColor,
                                                                yearIndex: widget
                                                                    .yearIndex,
                                                                dayIndex: widget
                                                                    .dayIndex,
                                                                newListItem:
                                                                    true,
                                                                index: 0)
                                                            .alarm(
                                                                AlarmSettings(
                                                                    id: int.parse(
                                                                        '${(widget.yearIndex - 5129).toString()}${widget.dayIndex.toString().padLeft(3, '0')}${_hour.padLeft(2, '0')}${_minute.padLeft(2, '0')}'),
                                                                    dateTime:
                                                                        dateTime,
                                                                    assetAudioPath:
                                                                        alarmSoundPath!,
                                                                    loopAudio:
                                                                        loopAudio,
                                                                    vibrate:
                                                                        vibrate,
                                                                    volume:
                                                                        volume,
                                                                    fadeDuration:
                                                                        0.5,
                                                                    notificationSettings: NotificationSettings(
                                                                        title: _alarmControllerTitle
                                                                            .text,
                                                                        body: _alarmControllerDescription
                                                                            .text),
                                                                    warningNotificationOnKill:
                                                                        true),
                                                                true));
                                                  } else {
                                                    DateFormat dateTimeFormat =
                                                        DateFormat(
                                                            "dd.MM.yyyy HH:mm");
                                                    DateFormat dateFormat =
                                                        DateFormat(
                                                            "dd.MM.yyyy");
                                                    String strDate = dateFormat
                                                        .format(dateTime);
                                                    dateTime = dateTimeFormat.parse(
                                                        '$strDate $_hour:$_minute');
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop([
                                                      true,
                                                      AlarmSettings(
                                                          id: int.parse(
                                                              '${(widget.yearIndex - 5129).toString()}${widget.dayIndex.toString().padLeft(3, '0')}${_hour.padLeft(2, '0')}${_minute.padLeft(2, '0')}'),
                                                          dateTime: dateTime,
                                                          assetAudioPath:
                                                              alarmSoundPathChanged
                                                                  ? alarmSoundPath!
                                                                  : await File(widget
                                                                              .alarmSettings
                                                                              .assetAudioPath)
                                                                          .exists()
                                                                      ? widget
                                                                          .alarmSettings
                                                                          .assetAudioPath
                                                                      : 'assets/audio/ringtone.mp3',
                                                          loopAudio: loopAudio,
                                                          vibrate: vibrate,
                                                          volume: volume,
                                                          fadeDuration: 0.5,
                                                          notificationSettings:
                                                              NotificationSettings(
                                                                  title:
                                                                      _alarmControllerTitle
                                                                          .text,
                                                                  body:
                                                                      _alarmControllerDescription
                                                                          .text),
                                                          warningNotificationOnKill:
                                                              true)
                                                    ]);
                                                  }
                                                },
                                                style: MayaStyle()
                                                    .transparentButtonStyle(
                                                        Colors.red[400]),
                                                child: Text('Save'.tr))))
                                  ])
                            ])))))));
  }
}

class MayaButtonStyle {}

saveAlarmSoundPath(String alarmSoundPath) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'alarmSoundPath';
  prefs.setString(key, alarmSoundPath);
}

Future<String> readAlarmSoundPath() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'alarmSoundPath';
  String alarmSoundPath = prefs.getString(key) ?? 'assets/audio/ringtone.mp3';
  if (await File(alarmSoundPath).exists()) {
    return alarmSoundPath;
  } else {
    return 'assets/audio/ringtone.mp3';
  }
}

deleteAlarmSoundPath() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('alarmSoundPath');
}

showAudioFileFormatDialog(BuildContext context, Color mainColor, Size size) {
  Size size = GetTextSize().getTextSize(
      'Only mp3, ogg or wav files are allowed!'.tr, MayaStyle.popUpDialogBody);
  showDialog<void>(
      context: context,
      //barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: MayaStyle().popUpDialogDecoration(mainColor),
                height: 93,
                width: size.width + 52,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Invalid File Format!'.tr,
                          style: MayaStyle.popUpDialogTitle),
                      Text('Only mp3, ogg or wav files are allowed!'.tr,
                          style: MayaStyle.popUpDialogBody)
                    ])));
      });
}
