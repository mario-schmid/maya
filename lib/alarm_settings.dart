import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:maya/helper/maya_list.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:maya/helper/shared_prefs.dart';

class AlarmSet extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final String alarmSoundIndex;
  final String customAlarmSoundPath;
  final String globalAlarmSoundVolume;
  final String alarmSnoozeIndex;
  const AlarmSet({
    super.key,
    required this.backgroundImage,
    required this.mainColor,
    required this.alarmSoundIndex,
    required this.customAlarmSoundPath,
    required this.globalAlarmSoundVolume,
    required this.alarmSnoozeIndex,
  });

  @override
  State<AlarmSet> createState() => _AlarmSetState();
}

class _AlarmSetState extends State<AlarmSet> {
  final AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;

  List<String> listAlarmSoundText = [
    'Default',
    'Alarm Sound 2',
    'Alarm Sound 3',
    'Alarm Sound 4',
    'Alarm Sound 5',
    'Alarm Sound 6',
    'Alarm Sound 7',
    'Alarm Sound 8',
    'Alarm Sound 9',
    'from file',
  ];

  late int alarmSoundIndex;
  String customAlarmSoundPath = '';
  late double alarmSoundVolume;
  late int alarmSnoozeIndex;

  late int chosenAlarmSoundIndex;
  late int chosenAlarmSnoozeIndex;

  List<String> timeStringSnooze = [
    '1 min',
    '2 min',
    '3 min',
    '4 min',
    '5 min',
    '6 min',
    '7 min',
    '8 min',
    '9 min',
    '10 min',
  ];

  bool alarmSoundSelected = true;
  bool alarmSnoozeSelected = true;

  late ColorFilter colorFilter;
  late ColorFilter colorFilterSelected;

  late FixedExtentScrollController _controllerAlarmSound;
  late FixedExtentScrollController _controllerAlarmSnooze;

  @override
  void initState() {
    alarmSoundIndex = int.parse(widget.alarmSoundIndex);
    alarmSoundVolume = double.parse(widget.globalAlarmSoundVolume) / 100;
    alarmSnoozeIndex = int.parse(widget.alarmSnoozeIndex);

    chosenAlarmSoundIndex = alarmSoundIndex;
    chosenAlarmSnoozeIndex = alarmSnoozeIndex;

    customAlarmSoundPath = widget.customAlarmSoundPath;

    colorFilter = ColorFilter.mode(widget.mainColor, BlendMode.modulate);
    colorFilterSelected = ColorFilter.mode(
      Color.lerp(widget.mainColor, Colors.white, 0.4)!,
      BlendMode.modulate,
    );

    _controllerAlarmSound = FixedExtentScrollController(
      initialItem: alarmSoundIndex,
    );
    _controllerAlarmSnooze = FixedExtentScrollController(
      initialItem: alarmSnoozeIndex,
    );

    player.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        playerState = s;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.7),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width * 1,
              width: size.width * 0.6,
              child: ListWheelScrollView(
                controller: _controllerAlarmSound,
                physics: const FixedExtentScrollPhysics(),
                itemExtent: size.width * 0.2,
                diameterRatio: 1.2,
                onSelectedItemChanged: (int index) async {
                  alarmSoundIndex = index;
                  if (playerState == PlayerState.playing) {
                    await player.stop();
                  }
                },
                children: [
                  for (int i = 0; i < 10; i++)
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          alarmSoundSelected = true;
                          chosenAlarmSoundIndex = alarmSoundIndex;
                        });
                        if (playerState == PlayerState.playing) {
                          await player.stop();
                        } else {
                          if (chosenAlarmSoundIndex != 9) {
                            await player.setVolume(alarmSoundVolume);
                            await player.play(
                              AssetSource(
                                MayaList
                                    .listAlarmSoundPath[chosenAlarmSoundIndex],
                              ),
                            );
                            //await player.dispose();
                          } else {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['mp3', 'wav', 'ogg'],
                                );
                            if (result != null) {
                              customAlarmSoundPath = result.files.first.path!;
                              await player.setVolume(alarmSoundVolume);
                              await player.play(
                                DeviceFileSource(customAlarmSoundPath),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter:
                                alarmSoundSelected && chosenAlarmSoundIndex == i
                                ? colorFilterSelected
                                : colorFilter,
                            image: const AssetImage(
                              'assets/images/bg_pattern_two.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.02),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            listAlarmSoundText[i],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
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
                          height: size.width * 0.06,
                          width: size.width * 0.06,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: size.width * 0.06,
                            ),
                          ),
                        ),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.indigo[400],
                      min: 0.0,
                      max: 1.0,
                      value: alarmSoundVolume,
                      onChanged: (value) async {
                        setState(() {
                          alarmSoundVolume = value;
                        });
                        await player.setVolume(alarmSoundVolume);
                      },
                    ),
                  ),
                  Text(
                    '${(alarmSoundVolume * 100).toInt()} %',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.width * 0.02),
            Text(
              'Snooze',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.06,
              ),
            ),
            SizedBox(height: size.width * 0.02),
            SizedBox(
              height: size.width * 0.12,
              width: size.width,
              child: ListWheelScrollViewX(
                controller: _controllerAlarmSnooze,
                physics: const FixedExtentScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemExtent: size.width * 0.26,
                diameterRatio: 1.3,
                onSelectedItemChanged: (int index) {
                  alarmSnoozeIndex = index;
                },
                children: [
                  for (int i = 0; i < 10; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          alarmSnoozeSelected = true;
                          chosenAlarmSnoozeIndex = alarmSnoozeIndex;
                        });
                      },
                      child: Container(
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter:
                                alarmSnoozeSelected &&
                                    chosenAlarmSnoozeIndex == i
                                ? colorFilterSelected
                                : colorFilter,
                            image: const AssetImage(
                              'assets/images/bg_pattern_two.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.02),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            timeStringSnooze[i],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: size.width * 0.16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.111111111,
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (playerState == PlayerState.playing) {
                        await player.stop();
                      }
                      await player.dispose();
                      if (!context.mounted) return;
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    style: MayaStyle().settingsButtonStyleRadish(
                      size,
                      widget.mainColor,
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: TextStyle(fontSize: size.width * 0.046),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),
                SizedBox(
                  height: size.width * 0.111111111,
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (playerState == PlayerState.playing) {
                        await player.stop();
                      }
                      await player.dispose();
                      setState(() {
                        chosenAlarmSoundIndex = alarmSoundIndex;
                        chosenAlarmSnoozeIndex = alarmSnoozeIndex;
                      });
                      Future.delayed(const Duration(milliseconds: 500), () {
                        saveAlarmSettings();
                        if (!context.mounted) return;
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                    style: MayaStyle().settingsButtonStyleRadish(
                      size,
                      widget.mainColor,
                    ),
                    child: Text(
                      'Save'.tr,
                      style: TextStyle(fontSize: size.width * 0.046),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveAlarmSettings() async {
    if (chosenAlarmSoundIndex == 9) {
      SharedPrefs.saveCustomAlarmSoundPath(customAlarmSoundPath);
    }
    SharedPrefs.saveAlarmSoundIndex(chosenAlarmSoundIndex.toString());
    SharedPrefs.saveGlobalAlarmSoundVolume(
      (alarmSoundVolume * 100).toInt().toString(),
    );
    SharedPrefs.saveAlarmSnoozeIndex(chosenAlarmSnoozeIndex.toString());
  }
}
