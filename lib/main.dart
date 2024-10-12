import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:alarm/alarm.dart' as alarm_prefix;
import 'package:android_gesture_exclusion/android_gesture_exclusion.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maya/character_choise.dart';
import 'package:maya/data/maya_alarm.dart';
import 'package:maya/data/maya_day.dart';
import 'package:maya/data/maya_event.dart';
import 'package:maya/data/maya_task.dart';
import 'package:maya/date_selection.dart';
import 'package:maya/helper/maya_images.dart';
import 'package:maya/helper/maya_lists.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:maya/helper/methods.dart';
import 'package:maya/methods/get_delda_year.dart';
import 'package:maya/methods/get_text_size.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:maya/providers/mayadata.dart';
import 'package:maya/random_character.dart';
import 'package:maya/relationship.dart';
import 'package:maya/ring_screen.dart';
import 'package:moon_phase_plus/moon_phase_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cholqij.dart';
import 'classes/position.dart';
import 'color_picker.dart';
import 'database_handler.dart';
import 'date_calculator.dart';
import 'helper/locale_string.dart';
import 'maya_items.dart';
import 'methods/get_kin_nummber.dart';
import 'methods/get_nahual.dart';
import 'methods/get_tone.dart';
import 'the_day.dart';
import 'the_year.dart';
import 'time_format.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
/* -------------------------------------------------------------------------- */
/* Assets for precacheImage                                                   */
/*                                                                            */
  final List<String> allAssetImages = [
    'assets/images/shape_button_left_bottom.png',
    'assets/images/shape_button_left_top.png',
    'assets/images/shape_right_bottom.png',
    'assets/images/shape_right_top.png',
    'assets/images/shape_button_moon.png',
    'assets/images/gearNahuales.png',
    'assets/images/gearTones.png',
    'assets/images/sandstone_tun.jpg',
    'assets/images/sandstone_time.jpg',
    'assets/images/sandstone_date_selection.jpg',
    'assets/images/sandstoneForm_bottom.png',
    'assets/images/sandstoneForm_top.png',
    'assets/images/sandstoneMoon.png',
    'assets/images/shape_section_winal_wayeb.png',
    'assets/images/shape_section_winal.png',
    'assets/images/trecenaBlue.png',
    'assets/images/trecenaRed.png',
    'assets/images/trecenaWhite.png',
    'assets/images/trecenaYellow.png',
    'assets/images/leaves.jpg',
    'assets/images/leaves.png',
    //
    'assets/images/moon_pattern.png',
    //
    'assets/images/transparent.png',
    //
    'assets/images/icons/sign.png',
    //
    'assets/images/tones/01_white_curved_bottom.png',
    'assets/images/tones/02_white_curved_bottom.png',
    'assets/images/tones/03_white_curved_bottom.png',
    'assets/images/tones/04_white_curved_bottom.png',
    'assets/images/tones/05_white_curved_bottom.png',
    'assets/images/tones/06_white_curved_bottom.png',
    'assets/images/tones/07_white_curved_bottom.png',
    'assets/images/tones/08_white_curved_bottom.png',
    'assets/images/tones/09_white_curved_bottom.png',
    'assets/images/tones/10_white_curved_bottom.png',
    'assets/images/tones/11_white_curved_bottom.png',
    'assets/images/tones/12_white_curved_bottom.png',
    'assets/images/tones/13_white_curved_bottom.png',
    //
    'assets/images/tones/01_white_curved.png',
    'assets/images/tones/02_white_curved.png',
    'assets/images/tones/03_white_curved.png',
    'assets/images/tones/04_white_curved.png',
    'assets/images/tones/05_white_curved.png',
    'assets/images/tones/06_white_curved.png',
    'assets/images/tones/07_white_curved.png',
    'assets/images/tones/08_white_curved.png',
    'assets/images/tones/09_white_curved.png',
    'assets/images/tones/10_white_curved.png',
    'assets/images/tones/11_white_curved.png',
    'assets/images/tones/12_white_curved.png',
    'assets/images/tones/13_white_curved.png',
    //
    'assets/images/tones/01_white_vertical.png',
    'assets/images/tones/02_white_vertical.png',
    'assets/images/tones/03_white_vertical.png',
    'assets/images/tones/04_white_vertical.png',
    'assets/images/tones/05_white_vertical.png',
    'assets/images/tones/06_white_vertical.png',
    'assets/images/tones/07_white_vertical.png',
    'assets/images/tones/08_white_vertical.png',
    'assets/images/tones/09_white_vertical.png',
    'assets/images/tones/10_white_vertical.png',
    'assets/images/tones/11_white_vertical.png',
    'assets/images/tones/12_white_vertical.png',
    'assets/images/tones/13_white_vertical.png',
    //
    'assets/images/tones/01_black_flat_center.png',
    'assets/images/tones/02_black_flat_center.png',
    'assets/images/tones/03_black_flat_center.png',
    'assets/images/tones/04_black_flat_center.png',
    'assets/images/tones/05_black_flat_center.png',
    'assets/images/tones/06_black_flat_center.png',
    'assets/images/tones/07_black_flat_center.png',
    'assets/images/tones/08_black_flat_center.png',
    'assets/images/tones/09_black_flat_center.png',
    'assets/images/tones/10_black_flat_center.png',
    'assets/images/tones/11_black_flat_center.png',
    'assets/images/tones/12_black_flat_center.png',
    'assets/images/tones/13_black_flat_center.png',
    //
    'assets/images/tones/00_white_bottom.png',
    'assets/images/tones/01_white_flat_bottom.png',
    'assets/images/tones/02_white_flat_bottom.png',
    'assets/images/tones/03_white_flat_bottom.png',
    'assets/images/tones/04_white_flat_bottom.png',
    'assets/images/tones/05_white_flat_bottom.png',
    'assets/images/tones/06_white_flat_bottom.png',
    'assets/images/tones/07_white_flat_bottom.png',
    'assets/images/tones/08_white_flat_bottom.png',
    'assets/images/tones/09_white_flat_bottom.png',
    'assets/images/tones/10_white_flat_bottom.png',
    'assets/images/tones/11_white_flat_bottom.png',
    'assets/images/tones/12_white_flat_bottom.png',
    'assets/images/tones/13_white_flat_bottom.png',
    'assets/images/tones/14_white_flat_bottom.png',
    'assets/images/tones/15_white_flat_bottom.png',
    'assets/images/tones/16_white_flat_bottom.png',
    'assets/images/tones/17_white_flat_bottom.png',
    'assets/images/tones/18_white_flat_bottom.png',
    'assets/images/tones/19_white_flat_bottom.png',
    //
    'assets/images/tones/00_white_center.png',
    'assets/images/tones/01_white_flat_center.png',
    'assets/images/tones/02_white_flat_center.png',
    'assets/images/tones/03_white_flat_center.png',
    'assets/images/tones/04_white_flat_center.png',
    'assets/images/tones/05_white_flat_center.png',
    'assets/images/tones/06_white_flat_center.png',
    'assets/images/tones/07_white_flat_center.png',
    'assets/images/tones/08_white_flat_center.png',
    'assets/images/tones/09_white_flat_center.png',
    'assets/images/tones/10_white_flat_center.png',
    'assets/images/tones/11_white_flat_center.png',
    'assets/images/tones/12_white_flat_center.png',
    'assets/images/tones/13_white_flat_center.png',
    'assets/images/tones/14_white_flat_center.png',
    'assets/images/tones/15_white_flat_center.png',
    'assets/images/tones/16_white_flat_center.png',
    'assets/images/tones/17_white_flat_center.png',
    'assets/images/tones/18_white_flat_center.png',
    'assets/images/tones/19_white_flat_center.png',
    //
    'assets/images/nahuales/00_imox.png',
    'assets/images/nahuales/01_iq.png',
    'assets/images/nahuales/02_aqabal.png',
    'assets/images/nahuales/03_kat.png',
    'assets/images/nahuales/04_kan.png',
    'assets/images/nahuales/05_kame.png',
    'assets/images/nahuales/06_kej.png',
    'assets/images/nahuales/07_qanil.png',
    'assets/images/nahuales/08_toj.png',
    'assets/images/nahuales/09_tzi.png',
    'assets/images/nahuales/10_batz.png',
    'assets/images/nahuales/11_e.png',
    'assets/images/nahuales/12_aj.png',
    'assets/images/nahuales/13_ix.png',
    'assets/images/nahuales/14_tzikin.png',
    'assets/images/nahuales/15_ajmaq.png',
    'assets/images/nahuales/16_noj.png',
    'assets/images/nahuales/17_tijax.png',
    'assets/images/nahuales/18_kawoq.png',
    'assets/images/nahuales/19_ajpu.png',
    //
    'assets/images/bg_pattern_one.jpg',
    'assets/images/bg_pattern_two.jpg',
    'assets/images/bg_pattern_three.jpg',
    //
    'assets/images/cholqij_field_red.jpg',
    'assets/images/cholqij_field_white.jpg',
    'assets/images/cholqij_field_blue.jpg',
    'assets/images/cholqij_field_yellow.jpg'
  ];
/*                                                                          */
/* Assets for precacheImage - END                                           */
/* ------------------------------------------------------------------------ */
  final binding = WidgetsFlutterBinding.ensureInitialized();
  binding.addPostFrameCallback((_) async {
    Element? context = binding.rootElement;
    if (context != null) {
      for (var asset in allAssetImages) {
        precacheImage(AssetImage(asset), context);
      }
    }
  });

  await Alarm.init();
  runApp(const MayaApp());
}

class MayaApp extends StatelessWidget {
  const MayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MayaData()),
        ChangeNotifierProvider(create: (context) => DayItems())
      ],
      child: GetMaterialApp(
          navigatorKey: navigatorKey,
          translations: LocaleString(),
          locale: const Locale('en', 'GB'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Roboto'),
          home: const Home()),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
  final DateFormat dateTimeformatSeasons =
      DateFormat("yyyy-MM-ddTHH:mm:00.000Z");

  late String? bgFilePath;
  ImageProvider backgroundImage =
      const AssetImage('assets/images/transparent.png');
  /* ------------------------------------------------------------------------ */
  /* Positions and Sizes                                                      */
  /*                                                                          */
  late Size sizeSettings;
  late Position posSettings;
  //
  late Size sizeBoxTime;
  late Position posBoxTime;
  //
  late double sizeIconNotification;
  late double sizePaddingNotificationTime;
  late TextStyle textStyleTime;
  //
  late Size sizeSandstoneFormTop;
  late Position posSandstoneFormTop;
  //
  late Size sizeShapeRightTop;
  late Position posShapeRightTop;
  //
  late Size sizeSandstoneFormBottom;
  late Position posSandstoneFormBottom;
  //
  late Size sizeShapeRightBottom;
  late Position posShapeRightBottom;
  //
  late Size sizeWheelNahuales;
  late Position posWheelNahuales;
  //
  late Size sizeSignNahual;
  late Offset offsetSignNahual;
  //
  late Size sizeWheelHaab;
  late Position posWheelHaab;
  //
  late Size sizeSectionFieldWinal;
  late Position posSectionFieldWinal;
  late Size sizeSectionWinal;
  late Offset offsetSectionFieldWinal;
  //
  late Size sizeImageToneWhiteFlatCenter;
  late Position posImageToneWhiteFlatCenter;
  late Offset offsetImageToneWhiteFlatCenter;
  //
  late Size sizeBoxTextWinal;
  late Position posBoxTextWinal;
  late Offset offsetBoxTextWinal;
  //
  late Size sizeSectionFieldWinalWayeb;
  late Position posSectionFieldWinalWayeb;
  late Size sizeSectionWinalWayeb;
  late Offset offsetSectionFieldWinalWayeb;
  //
  late Size sizeImageToneWhiteFlatCenterWayeb;
  late Position posImageToneWhiteFlatCenterWayeb;
  late Offset offsetImageToneWhiteFlatCenterWayeb;
  //
  late Size sizeBoxTextWinalWayeb;
  late Position posBoxTextWinalWayeb;
  late Offset offsetBoxTextWinalWayeb;
  //
  late TextStyle textStyleStrWinal;
  //
  late Size sizeFrame;
  late Position posFrame;
  late Offset offsetFrame;
  //
  late Size sizeSandstoneMoon;
  late Position posSandstoneMoon;
  //
  late Size sizeButtonReset;
  late Position posButtonReset;
  //
  late Size sizeWheelTones;
  late Position posWheelTones;
  //
  late Size sizeBoxSeasons;
  late Position posBoxSeasons;
  //
  late Size sizeSignTone;
  late Offset offsetSignTone;
  //
  late double sizeMoon;
  late Position posMoon;
  //
  late double sizeBoxSolsticesEquinoxes;
  late Position posBoxSolsticesEquinoxes;
  //
  late EdgeInsets paddingBoxSolsticesEquinoxes;
  late double mainAxisSpacingBoxSolsticesEquinoxes;
  late double crossAxisSpacingBoxSolsticesEquinoxes;
  //
  late double sizeCircleSeason;
  late EdgeInsets paddingCircleSeason;
  late Offset offsetCircleSeason;
  //
  late Size sizeButtonRelationship;
  late Position posButtonRelationship;
  //
  late Size sizeButtonTheYear;
  late Position posButtonTheYear;
  //
  late Size sizeButtonDateCalculator;
  late Position posButtonDateCalculator;
  //
  late Size sizeButtonCholqij;
  late Position posButtonCholqij;
  //
  late Size sizeBoxTextToneNahual;
  late Position posBoxTextToneNahual;
  //
  late TextStyle texttextStyleToneNahual;
  //
  late Size sizeBoxLongCount;
  late Position posBoxLongCount;
  late Size sizeSandstones;
  late Size sizeNummbers;
  late EdgeInsets paddingSandstones;
  late EdgeInsets paddingNummbersBaktun;
  late EdgeInsets paddingNummbersKatun;
  late EdgeInsets paddingNummbersTun;
  late EdgeInsets paddingNummbersWinal;
  late EdgeInsets paddingNummbersKin;
  /*                                                                          */
  /* Positions and Sizes - END                                                */
  /* ------------------------------------------------------------------------ */
  /* ------------------------------------------------------------------------ */
  /* Varibles                                                                 */
  /*                                                                          */
  DateTime now = DateTime.now();

  //TODO: remove in the future
  Future<bool> adjustDatabase = updateYear();

  final Future<Iterable<List<Object?>>> _eventList =
      DatabaseHandlerEvents().retrieveEvents();
  final Future<Iterable<List<Object?>>> _noteList =
      DatabaseHandlerNotes().retrieveNotes();
  final Future<Iterable<List<Object?>>> _taskList =
      DatabaseHandlerTasks().retrieveTasks();
  final Future<Iterable<List<Object?>>> _alarmList =
      DatabaseHandlerAlarms().retrieveAlarms();
  final Future<Iterable<List<Object?>>> _arrangementList =
      DatabaseHandlerArrangements().retrieveArrangements();

  List<List<dynamic>> eventList = [];
  List<List<dynamic>> noteList = [];
  List<List<dynamic>> taskList = [];
  List<List<dynamic>> alarmList = [];
  List<List<dynamic>> arrangementList = [];

  late DateTime startDate;
  String currTime = '';

  late double angleTime;

  double angleSeason = 0.0;

  SvgPicture iconSeason =
      SvgPicture.asset('assets/vector_graphics/transparent_icon.svg');

  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;
  double prevAngle = 0.0;

  double mAngle = 0.0;
  double iRounds = 0.0;
  int nAngle = 0;

  final int dDays = 62;

  late int baktun, sBaktun;
  late int katun, sKatun;
  late int tun, sTun;
  late int winal, sWinal;
  late int kin, sKin;

  late int currDay;
  late int chosenDay;
  late int xDayTotal;

  late int currYear;
  late int chosenYear;

  late int tone;
  late int sTone;

  late int nahual;
  late int sNahual;

  final int startTone = 0;
  final int startNahual = 1;
  final int startKinIndex = 221;

  late int currKinIndex;

  late int trecenaColor;
  late int nTrecenaColor;

  double dTrecenaAngle = 0.0;
  int nTrecenaAngle = 0;
  int iTrecena = 1;

  late double offsetGearNahuales;
  late double offsetGearTones;
  late double offsetGearHaab;

  late double diffAngle;

  late double trecenaOffsetAngle;

  late Image currTrecenaMask;

  late String strTextToneNahual;

  final List<Image> imageToneWhiteFlatBottom = [
    Image.asset('assets/images/tones/00_white_bottom.png'),
    Image.asset('assets/images/tones/01_white_flat_bottom.png'),
    Image.asset('assets/images/tones/02_white_flat_bottom.png'),
    Image.asset('assets/images/tones/03_white_flat_bottom.png'),
    Image.asset('assets/images/tones/04_white_flat_bottom.png'),
    Image.asset('assets/images/tones/05_white_flat_bottom.png'),
    Image.asset('assets/images/tones/06_white_flat_bottom.png'),
    Image.asset('assets/images/tones/07_white_flat_bottom.png'),
    Image.asset('assets/images/tones/08_white_flat_bottom.png'),
    Image.asset('assets/images/tones/09_white_flat_bottom.png'),
    Image.asset('assets/images/tones/10_white_flat_bottom.png'),
    Image.asset('assets/images/tones/11_white_flat_bottom.png'),
    Image.asset('assets/images/tones/12_white_flat_bottom.png'),
    Image.asset('assets/images/tones/13_white_flat_bottom.png'),
    Image.asset('assets/images/tones/14_white_flat_bottom.png'),
    Image.asset('assets/images/tones/15_white_flat_bottom.png'),
    Image.asset('assets/images/tones/16_white_flat_bottom.png'),
    Image.asset('assets/images/tones/17_white_flat_bottom.png'),
    Image.asset('assets/images/tones/18_white_flat_bottom.png'),
    Image.asset('assets/images/tones/19_white_flat_bottom.png')
  ];

  final List<Image> trecenaMask = [
    Image.asset('assets/images/trecenaRed.png'),
    Image.asset('assets/images/trecenaWhite.png'),
    Image.asset('assets/images/trecenaBlue.png'),
    Image.asset('assets/images/trecenaYellow.png')
  ];

  late List<AlarmSettings> alarms;
  static StreamSubscription<AlarmSettings>? subscription;
  /*                                                                          */
  /* Varibles - END                                                           */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* initState                                                                */
  /*                                                                          */
  @override
  void initState() {
    // Clock
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final DateTime nowClock = DateTime.now();
      setState(() {
        currTime = TimeFormat().getTimeFormat.format(nowClock);
      });
    });
    // Clock END

    if (Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermission();
    }
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );

    loadSeasonsFromAssets('assets/seasons.json');

    loadMainColor();
    loadLanguage();

    loadTimeFormat();
    loadBgFilePath();
    loadData();

    startDate = DateTime.parse('2013-02-21 00:00:00');

    // TODO: remove in the future
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await adjustDatabase) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => Center(
                    child: AlertDialog(
                        insetPadding: const EdgeInsets.all(0),
                        contentPadding: const EdgeInsets.all(0),
                        actionsPadding: const EdgeInsets.all(0),
                        actionsAlignment: MainAxisAlignment.center,
                        content: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: const EdgeInsets.all(20),
                          decoration:
                              MayaStyle().popUpDialogDecoration(mainColor),
                          child: Text(
                              'Please restart the app to restore all data!'.tr,
                              style: MayaStyle.popUpDialogBody),
                        ),
                        actions: <Widget>[
                      RawMaterialButton(
                          child: const Text('Restart',
                              style: TextStyle(
                                  fontFamily: 'Robot',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none)),
                          onPressed: () {
                            Restart.restartApp();
                          }),
                    ])));
      }
    });
    hideSplashScreen();
    super.initState();
  }

  /*                                                                          */
  /* initState - END                                                          */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* hideSplashScreen                                                         */
  /*                                                                          */
  Future<void> hideSplashScreen() async {
    Future.delayed(const Duration(milliseconds: 1111), () {
      FlutterSplashScreen.hide();
    });
  }

  /*                                                                          */
  /* hideSplashScreen - END                                                   */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* loadData                                                                 */
  /*                                                                          */
  loadData() async {
    eventList = (await _eventList).toList();
    noteList = (await _noteList).toList();
    taskList = (await _taskList).toList();
    alarmList = (await _alarmList).toList();
    arrangementList = (await _arrangementList).toList();

    for (var event in eventList) {
      if (!MayaData().mayaData.containsKey(event[0])) {
        MayaData().mayaData[event[0]] = <int, Day>{};
        MayaData().mayaData[event[0]][event[1]] = Day();
      } else if (!MayaData().mayaData[event[0]].containsKey(event[1])) {
        MayaData().mayaData[event[0]][event[1]] = Day();
      }

      MayaData()
          .mayaData[event[0]][event[1]]
          .eventList
          .add(Event([event[3], event[4], event[5], event[6]]));
    }
    for (var note in noteList) {
      if (!MayaData().mayaData.containsKey(note[0])) {
        MayaData().mayaData[note[0]] = <int, Day>{};
        MayaData().mayaData[note[0]][note[1]] = Day();
      } else if (!MayaData().mayaData[note[0]].containsKey(note[1])) {
        MayaData().mayaData[note[0]][note[1]] = Day();
      }

      MayaData().mayaData[note[0]][note[1]].noteList.add(note[3]);
    }
    for (var task in taskList) {
      if (!MayaData().mayaData.containsKey(task[0])) {
        MayaData().mayaData[task[0]] = <int, Day>{};
        MayaData().mayaData[task[0]][task[1]] = Day();
      } else if (!MayaData().mayaData[task[0]].containsKey(task[1])) {
        MayaData().mayaData[task[0]][task[1]] = Day();
      }

      MayaData()
          .mayaData[task[0]][task[1]]
          .taskList
          .add(Task(task[3], task[4] == 0 ? false : true));
    }
    for (var alarm in alarmList) {
      if (!MayaData().mayaData.containsKey(alarm[0])) {
        MayaData().mayaData[alarm[0]] = <int, Day>{};
        MayaData().mayaData[alarm[0]][alarm[1]] = Day();
      } else if (!MayaData().mayaData[alarm[0]].containsKey(alarm[1])) {
        MayaData().mayaData[alarm[0]][alarm[1]] = Day();
      }

      MayaData().mayaData[alarm[0]][alarm[1]].alarmList.add(MayaAlarm(
          AlarmSettings(
              id: alarm[3],
              dateTime: dateTimeformat.parse(alarm[4]),
              assetAudioPath: alarm[5],
              loopAudio: alarm[6] == 0 ? false : true,
              vibrate: alarm[7] == 0 ? false : true,
              volume: alarm[8],
              fadeDuration: alarm[9],
              notificationSettings: alarm_prefix.NotificationSettings(
                  title: alarm[10], body: alarm[11]),
              warningNotificationOnKill: alarm[12] == 0 ? false : true),
          alarm[13] == 0 ? false : true));
    }
    for (var arrangement in arrangementList) {
      int l = 0;
      int m = 0;
      int n = 0;
      int o = 0;
      String removedBrackets =
          arrangement[2].substring(1, arrangement[2].length - 1);
      List<String> strArrangements = removedBrackets.split(',');
      List<int> arrangements =
          strArrangements.map((data) => int.parse(data)).toList();
      for (int j = 0; j < arrangements.length; j++) {
        if (!DayItems().dayItems.containsKey(arrangement[0])) {
          DayItems().dayItems[arrangement[0]] = <int, List<Dismissible>>{};
          DayItems().dayItems[arrangement[0]][arrangement[1]] = <Dismissible>[];
        } else if (!DayItems()
            .dayItems[arrangement[0]]
            .containsKey(arrangement[1])) {
          DayItems().dayItems[arrangement[0]][arrangement[1]] = <Dismissible>[];
        }

        if (arrangements[j] == 0) {
          DayItems().dayItems[arrangement[0]][arrangement[1]].add(MayaItems(
                  mainColor: mainColor,
                  yearIndex: arrangement[0],
                  dayIndex: arrangement[1],
                  newListItem: false,
                  index: l)
              .event(eventList[l][3], eventList[l][4], eventList[l][5],
                  eventList[l][6]));
          l++;
        }
        if (arrangements[j] == 1) {
          DayItems().dayItems[arrangement[0]][arrangement[1]].add(MayaItems(
                  mainColor: mainColor,
                  yearIndex: arrangement[0],
                  dayIndex: arrangement[1],
                  newListItem: false,
                  index: m)
              .note(noteList[m][3]));
          m++;
        }
        if (arrangements[j] == 2) {
          DayItems().dayItems[arrangement[0]][arrangement[1]].add(MayaItems(
                  mainColor: mainColor,
                  yearIndex: arrangement[0],
                  dayIndex: arrangement[1],
                  newListItem: false,
                  index: n)
              .task(taskList[n][3], taskList[n][4] == 0 ? false : true));
          n++;
        }
        if (arrangements[j] == 3) {
          DayItems().dayItems[arrangement[0]][arrangement[1]].add(MayaItems(
                  mainColor: mainColor,
                  yearIndex: arrangement[0],
                  dayIndex: arrangement[1],
                  newListItem: false,
                  index: o)
              .alarm(
                  AlarmSettings(
                      id: alarmList[o][3],
                      dateTime: dateTimeformat.parse(alarmList[o][4]),
                      assetAudioPath: alarmList[o][5],
                      loopAudio: alarmList[o][6] == 0 ? false : true,
                      vibrate: alarmList[o][7] == 0 ? false : true,
                      volume: alarmList[o][8],
                      fadeDuration: alarmList[o][9],
                      notificationSettings: alarm_prefix.NotificationSettings(
                          title: alarmList[o][10], body: alarmList[o][11]),
                      warningNotificationOnKill:
                          alarmList[o][12] == 0 ? false : true),
                  alarmList[o][13] == 0 ? false : true));
          o++;
        }
      }
    }
  }

  /*                                                                          */
  /* loadData - END                                                           */
  /* ------------------------------------------------------------------------ */
  List<bool> isSelected = [true, false];
  /* ------------------------------------------------------------------------ */
  /* loadTimeFormat                                                           */
  /*                                                                          */
  loadTimeFormat() async {
    Future<Object> timeFormatFuture = readTimeFormat();
    TimeFormat().setTimeFormat =
        DateFormat((await timeFormatFuture).toString());
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        isSelected = [true, false];
        break;
      case 'HH:mm:ss':
        isSelected = [false, true];
        break;
    }
  }

  /*                                                                          */
  /* loadTimeFormat - END                                                     */
  /* ------------------------------------------------------------------------ */
  /* ------------------------------------------------------------------------ */
  /* init, load and set Language                                              */
  /*                                                                          */
  bool isCheckedEnglish = true;
  bool isCheckedGerman = false;
  bool isCheckedFrance = false;
  bool isCheckedSpain = false;

  loadLanguage() async {
    Future<Object> languageFuture = readLanguage();
    String strLanguage = (await languageFuture).toString();
    List<String> listLanguage = strLanguage.split('_');

    switch (strLanguage) {
      case 'en_GB':
        isCheckedEnglish = true;
        isCheckedGerman = false;
        isCheckedFrance = false;
        isCheckedSpain = false;
        break;
      case 'de_DE':
        isCheckedEnglish = false;
        isCheckedGerman = true;
        isCheckedFrance = false;
        isCheckedSpain = false;
        break;
      case 'fr_FR':
        isCheckedEnglish = false;
        isCheckedGerman = false;
        isCheckedFrance = true;
        isCheckedSpain = false;
        break;
      case 'es_ES':
        isCheckedEnglish = false;
        isCheckedGerman = false;
        isCheckedFrance = false;
        isCheckedSpain = true;
        break;
    }

    Get.updateLocale(Locale(listLanguage[0], listLanguage[1]));
  }

  /*                                                                          */
  /* init, load and set Language - END                                        */
  /* ------------------------------------------------------------------------ */
  Color mainColor = const Color(0xff0000ff);
  /* ------------------------------------------------------------------------ */
  /* loadMainColor                                                            */
  /*                                                                          */
  loadMainColor() async {
    Future<Object> mainColorFuture = readMainColor();
    String strMainColor = (await mainColorFuture).toString();
    mainColor = Color(int.parse(strMainColor));
  }

  /*                                                                          */
  /* loadMainColor - END                                                      */
  /* ------------------------------------------------------------------------ */
  /* ------------------------------------------------------------------------ */
  /* loadBgFilePath                                                           */
  /*                                                                          */
  loadBgFilePath() async {
    backgroundImage = await readBgFilePath();
  }

  /*                                                                          */
  /* loadBgFilePath - END                                                     */
  /* ------------------------------------------------------------------------ */

  List<dynamic> seasons = [];
  /* ------------------------------------------------------------------------ */
  /* loadSeasonsFromAssets                                                    */
  /*                                                                          */
  loadSeasonsFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    seasons = jsonDecode(jsonString);
  }

  /*                                                                          */
  /* loadSeasonsFromAssets - END                                              */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* navigateToRingScreen                                                     */
  /*                                                                          */
  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
  }

  /*                                                                          */
  /* navigateToRingScreen - END                                               */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* reset                                                                    */
  /*                                                                          */
  reset() {
    setState(() {
      upsetAngle = 0.0;
      finalAngle = 0.0;
      oldAngle = 0.0;

      iRounds = 0;
      mAngle = 0.0;

      nTrecenaColor = trecenaColor;
      nTrecenaAngle = 0;
      dTrecenaAngle = 0.0;
      iTrecena = 1;

      currTrecenaMask = trecenaMask[trecenaColor];

      sTone = tone;
      sNahual = nahual;
      nAngle = 0;

      strTextToneNahual =
          '${MayaLists().strTone[tone]}\n${MayaLists().strNahual[nahual]}';

      sBaktun = baktun;
      sKatun = katun;
      sTun = tun;
      sWinal = winal;
      sKin = kin;

      chosenDay = currDay;
      xDayTotal = currDay;
      chosenYear = currYear;
    });
  }

  /*                                                                          */
  /* reset - END                                                              */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* updateLanguage                                                           */
  /*                                                                          */
  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  /*                                                                          */
  /* updateLanguage - END                                                     */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* inticators                                                               */
  /*                                                                          */
  bool inticators(int i, Map<int, Map<int, Day>> mayaData) {
    int cYear = (currYear + (xDayTotal + i) / 365).floor();
    int cDay = (xDayTotal + i) % 365;
    if (mayaData.containsKey(cYear)) {
      if (mayaData[cYear]!.containsKey(cDay)) {
        if (mayaData[cYear]![cDay]!
                .eventList
                .any((element) => element.event != null) ||
            mayaData[cYear]![cDay]!
                .noteList
                .any((element) => element != null) ||
            mayaData[cYear]![cDay]!
                .taskList
                .any((element) => element.isChecked == false) ||
            mayaData[cYear]![cDay]!
                .alarmList
                .any((element) => element.isActive == true)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*                                                                          */
  /* inticators - END                                                         */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* tunContainer                                                             */
  /*                                                                          */
  Container tunContainer(Size size, int value) {
    return Container(
      height: sizeSandstones.height,
      width: sizeSandstones.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size.width * 0.02)),
          image: const DecorationImage(
              image: AssetImage('assets/images/sandstone_tun.jpg'),
              fit: BoxFit.cover)),
      child: Center(
        child: SizedBox(
            width: sizeNummbers.width, child: imageToneWhiteFlatBottom[value]),
      ),
    );
  }

  /*                                                                          */
  /* tunContainer - END                                                       */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* Drawer                                                                   */
  /*                                                                          */
  Drawer _customDrawer(BuildContext context, Size size) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Drawer(
        width: size.width * 0.8,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(height: statusBarHeight),
              SizedBox(
                  child: Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Image(
                          image:
                              const AssetImage("assets/images/icons/sign.png"),
                          height: size.width * 0.3,
                          width: size.width * 0.3))),
              Divider(
                  color: Colors.white,
                  height: 0,
                  thickness: size.width * 0.003,
                  indent: 0,
                  endIndent: 0),
              SizedBox(height: size.width * 0.02),
              SizedBox(
                  height: size.width * 0.12,
                  child: CheckboxListTile(
                      activeColor: mainColor.withOpacity(0.5),
                      side: const BorderSide(color: Colors.white),
                      title: Text('English'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04)),
                      secondary: Flag.fromCode(FlagsCode.GB,
                          height: size.width * 0.07, width: size.width * 0.108),
                      value: isCheckedEnglish,
                      onChanged: (newValue) {
                        setState(() {
                          isCheckedEnglish = newValue!;
                          isCheckedGerman = !newValue;
                          isCheckedFrance = !newValue;
                          isCheckedSpain = !newValue;
                        });
                        updateLanguage(const Locale('en', 'GB'));
                        saveLanguage('en_GB');
                      })),
              SizedBox(
                  height: size.width * 0.12,
                  child: CheckboxListTile(
                      activeColor: mainColor.withOpacity(0.5),
                      side: const BorderSide(color: Colors.white),
                      title: Text('German'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04)),
                      secondary: Flag.fromCode(FlagsCode.DE,
                          height: size.width * 0.07, width: size.width * 0.108),
                      value: isCheckedGerman,
                      onChanged: (newValue) {
                        setState(() {
                          isCheckedGerman = newValue!;
                          isCheckedEnglish = !newValue;
                          isCheckedFrance = !newValue;
                          isCheckedSpain = !newValue;
                        });
                        updateLanguage(const Locale('de', 'DE'));
                        saveLanguage('de_DE');
                      })),
              SizedBox(
                  height: size.width * 0.12,
                  child: CheckboxListTile(
                      activeColor: mainColor.withOpacity(0.5),
                      side: const BorderSide(color: Colors.white),
                      title: Text('French'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04)),
                      secondary: Flag.fromCode(FlagsCode.FR,
                          height: size.width * 0.07, width: size.width * 0.108),
                      value: isCheckedFrance,
                      onChanged: (newValue) {
                        setState(() {
                          isCheckedFrance = newValue!;
                          isCheckedEnglish = !newValue;
                          isCheckedGerman = !newValue;
                          isCheckedSpain = !newValue;
                        });
                        updateLanguage(const Locale('fr', 'FR'));
                        saveLanguage('fr_FR');
                      })),
              SizedBox(
                  height: size.width * 0.12,
                  child: CheckboxListTile(
                      activeColor: mainColor.withOpacity(0.5),
                      side: const BorderSide(color: Colors.white),
                      title: Text('Spain'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04)),
                      secondary: Flag.fromCode(FlagsCode.ES,
                          height: size.width * 0.07, width: size.width * 0.108),
                      value: isCheckedSpain,
                      onChanged: (newValue) {
                        setState(() {
                          isCheckedSpain = newValue!;
                          isCheckedEnglish = !newValue;
                          isCheckedGerman = !newValue;
                          isCheckedFrance = !newValue;
                        });
                        updateLanguage(const Locale('es', 'ES'));
                        saveLanguage('es_ES');
                      })),
              SizedBox(height: size.width * 0.04),
              Center(
                  child: ToggleButtons(
                      constraints: BoxConstraints(
                          minHeight: size.width * 0.1,
                          minWidth: size.width * 0.3),
                      fillColor: mainColor.withOpacity(0.5),
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.01)),
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            isSelected[1] = false;
                            isSelected[0] = true;
                            TimeFormat().setTimeFormat = DateFormat('h:mm a');
                            saveTimeFormat('h:mm a');
                          } else {
                            isSelected[0] = false;
                            isSelected[1] = true;
                            TimeFormat().setTimeFormat = DateFormat('HH:mm:ss');
                            saveTimeFormat('HH:mm:ss');
                          }
                        });
                      },
                      children: <Widget>[
                    Text('12 ${'Hours'.tr}',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 0.04)),
                    Text('24 ${'Hours'.tr}',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 0.04))
                  ])),
              SizedBox(height: size.width * 0.04),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.2,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          mainColor = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ColorPicker(mainColor: mainColor);
                              });
                        },
                        onLongPress: () async {
                          mainColor = const Color(0xff0000ff);
                          deleteMainColor();
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                                mainColor.withOpacity(0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                            side: WidgetStateProperty.all(const BorderSide(
                                color: Colors.white, width: 1)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.01))),
                            overlayColor: WidgetStateProperty.all(mainColor)),
                        child: SvgPicture.asset(
                            "assets/vector_graphics/rby_icon.svg",
                            height: size.width * 0.08,
                            width: size.width * 0.08))),
                SizedBox(width: size.width * 0.06),
                SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.2,
                    child: ElevatedButton(
                        onPressed: () async {
                          const params = OpenFileDialogParams(
                            dialogType: OpenFileDialogType.image,
                            sourceType: SourceType.photoLibrary,
                          );
                          bgFilePath =
                              await FlutterFileDialog.pickFile(params: params);
                          if (bgFilePath != null) {
                            String ext = bgFilePath!.split('.').last;
                            if (ext == 'jpg' || ext == 'jpeg' || ext == 'png') {
                              saveBgFilePath(bgFilePath!);
                              backgroundImage = FileImage(File(bgFilePath!));
                            } else {
                              if (!context.mounted) return;
                              showImageFileFormatDialog(
                                  context, mainColor, size);
                            }
                          }
                        },
                        onLongPress: () async {
                          backgroundImage =
                              const AssetImage('assets/images/leaves.jpg');
                          deleteBgImagePath();
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                                mainColor.withOpacity(0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                            side: WidgetStateProperty.all(const BorderSide(
                                color: Colors.white, width: 1)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.01))),
                            overlayColor: WidgetStateProperty.all(mainColor)),
                        child: SvgPicture.asset(
                            "assets/vector_graphics/image_icon.svg",
                            height: size.width * 0.08,
                            width: size.width * 0.08)))
              ]),
              SizedBox(height: size.width * 0.04),
              SizedBox(
                  height: size.height - size.width * 1.78 - statusBarHeight),
              Column(children: [
                Padding(
                    padding: EdgeInsets.only(bottom: size.width * 0.02),
                    child: SizedBox(
                        height: size.width * 0.1,
                        width: size.width * 0.6,
                        child: KofiButton(
                            kofiName: "mario_schmid",
                            kofiColor: KofiColor.Blue,
                            style: ButtonStyle(
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.014)))),
                            onDonation: () {
                              // Runs after the button has been pressed
                              debugPrint("On donation");
                            }))),
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.02),
                  child: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.6,
                      child: PayPalButton(
                        paypalButtonId: "S9YDP9YQ2KHVL",
                        style: ButtonStyle(
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.014)))),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.02),
                  child: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.66,
                      child: PatreonButton(
                        patreonName: "mario_schmid",
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.red),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.014)))),
                      )),
                ),
                SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.56,
                    child: BuyMeACoffeeButton(
                      buyMeACoffeeName: "mario_schmid",
                      color: BuyMeACoffeeColor.Green,
                      style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.014)))),
                    ))
              ]),
              SizedBox(height: size.width * 0.03),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: size.width * 0.08,
                    width: size.width * 0.22,
                    child: ElevatedButton(
                        onPressed: _launchGithub,
                        style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                                mainColor.withOpacity(0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                            side: WidgetStateProperty.all(const BorderSide(
                                color: Colors.white, width: 1)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.01))),
                            overlayColor: WidgetStateProperty.all(mainColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/vector_graphics/github.svg",
                                height: size.width * 0.06,
                                width: size.width * 0.06),
                            SizedBox(width: size.width * 0.01),
                            Text('Github',
                                style: TextStyle(fontSize: size.width * 0.034))
                          ],
                        ))),
                SizedBox(width: size.width * 0.03),
                SizedBox(
                  height: size.width * 0.08,
                  width: size.width * 0.26,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        backgroundColor:
                            WidgetStateProperty.all(mainColor.withOpacity(0.5)),
                        shadowColor:
                            WidgetStateProperty.all(Colors.transparent),
                        side: WidgetStateProperty.all(
                            const BorderSide(color: Colors.white, width: 1)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.01))),
                        overlayColor: WidgetStateProperty.all(mainColor)),
                    onPressed: _launchPrivacyPolicy,
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: size.width * 0.034),
                    ),
                  ),
                ),
              ])
            ])));
  }

  /*                                                                          */
  /* Drawer - END                                                             */
  /* ------------------------------------------------------------------------ */
  /* ------------------------------------------------------------------------ */
  /* Build                                                                    */
  /*                                                                          */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    if (size.height / size.width >= 692 / 360) {
      //
      // TODO: calculate the size based on the display size
      sizeSettings = const Size(16, 120);
      posSettings =
          Position(statusBarHeight + 10, size.width - sizeSettings.width);
      //
      sizeBoxTime = Size(size.width * 0.52, size.width * 0.1);
      posBoxTime = Position(size.height / 2 - size.width * 0.84,
          size.width - sizeBoxTime.width - size.width * 0.4);
      //
      sizeIconNotification = size.width * 0.067;
      //
      sizePaddingNotificationTime = size.width * 0.014;
      //
      textStyleTime = TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.normal);
      //
      sizeSandstoneFormTop =
          Size(size.width * 0.776591667, size.width * 0.417247222);
      posSandstoneFormTop = Position(size.height / 2 - size.width * 0.793058333,
          size.width - size.width * 0.949322222);
      //
      sizeShapeRightTop =
          Size(size.width * 0.403827667, size.width * 0.317301957);
      posShapeRightTop = Position(size.height / 2 - size.width * 0.748390489,
          size.width - size.width * 0.602768191);
      //
      sizeSandstoneFormBottom =
          Size(size.width * 0.776591667, size.width * 0.417247222);
      posSandstoneFormBottom = Position(
          size.height / 2 + size.width * 0.375811111,
          size.width - size.width * 0.949322222);
      //
      sizeShapeRightBottom =
          Size(size.width * 0.403827667, size.width * 0.317301957);
      posShapeRightBottom = Position(size.height / 2 + size.width * 0.431143267,
          size.width - size.width * 0.602768191);
      //
      sizeWheelNahuales =
          Size(size.width * 1.092592593, size.width * 1.092592593);
      posWheelNahuales = Position((size.height - sizeWheelNahuales.height) / 2,
          size.width - sizeWheelNahuales.width - size.width * 0.113888889);
      //
      sizeSignNahual = Size(size.width * 0.128, size.width * 0.117333333);
      offsetSignNahual = Offset(-size.width * 0.435995852, 0);
      //
      sizeWheelHaab =
          Size(size.width * 18.503703704, size.width * 18.503703704);
      posWheelHaab = Position((size.height - sizeWheelHaab.height) / 2,
          size.width - size.width * 0.155555556);
      //
      sizeSectionFieldWinal =
          Size(size.width * 9.251851852, size.width * 3.169558333);
      posSectionFieldWinal = Position(size.width * 7.667072685, 0);
      sizeSectionWinal =
          Size(size.width * 0.375630556, size.width * 3.169558333);
      offsetSectionFieldWinal = Offset(size.width * 4.625925926, 0);
      //
      sizeImageToneWhiteFlatCenter = Size(size.width * 0.086111111, 0);
      posImageToneWhiteFlatCenter =
          Position(size.width * 1.557425, size.width * 0.009702778);
      offsetImageToneWhiteFlatCenter = Offset(size.width * 9.199093519, 0);
      //
      sizeBoxTextWinal = Size(size.width * 0.166666667, size.width * 0.05);
      posBoxTextWinal =
          Position(size.width * 1.501447222, size.width * 0.099958333);
      offsetBoxTextWinal = Offset(size.width * 9.126893519, 0);
      //
      sizeSectionFieldWinalWayeb =
          Size(size.width * 9.251851852, size.width * 0.796069444);
      posSectionFieldWinalWayeb = Position(size.width * 8.853816667, 0);
      sizeSectionWinalWayeb =
          Size(size.width * 0.260044444, size.width * 0.796069444);
      offsetSectionFieldWinalWayeb = Offset(size.width * 4.625925926, 0);
      //
      sizeImageToneWhiteFlatCenterWayeb = Size(size.width * 0.086111111, 0);
      posImageToneWhiteFlatCenterWayeb =
          Position(size.width * 0.370680556, size.width * 0.009702778);
      offsetImageToneWhiteFlatCenterWayeb = Offset(size.width * 9.199093519, 0);
      //
      sizeBoxTextWinalWayeb = Size(size.width * 0.166666667, size.width * 0.05);
      posBoxTextWinalWayeb =
          Position(size.width * 0.314702778, size.width * 0.099958333);
      offsetBoxTextWinalWayeb = Offset(size.width * 9.126893519, 0);
      //
      textStyleStrWinal =
          TextStyle(color: Colors.white, fontSize: size.width * 0.044444444);
      //
      sizeFrame = Size(size.width * 0.099958333, size.width * 0.099958333);
      posFrame = Position(sizeWheelHaab.height / 2 - size.width * 0.049980556,
          size.width * 0.002777778);
      offsetFrame = Offset(size.width * 9.199093519, 0);
      //
      sizeSandstoneMoon =
          Size(size.width * 0.398594444, size.width * 0.629252778);
      posSandstoneMoon = Position((size.height - size.width * 0.629252778) / 2,
          size.width - size.width * 0.977588889);
      //
      sizeButtonReset =
          Size(size.width * 0.274891667, size.width * 0.581611111);
      posButtonReset = Position((size.height - size.width * 0.581611111) / 2,
          size.width - size.width * 0.954027778);
      //
      sizeWheelTones = Size(size.width * 0.496296296, size.width * 0.496296296);
      posWheelTones = Position((size.height - sizeWheelTones.height) / 2,
          size.width - sizeWheelTones.width - size.width * 0.277777778);
      //
      sizeSignTone = Size(size.width * 0.048, size.width * 0.1);
      offsetSignTone = Offset(-size.width * 0.201733333, 0);
      //
      sizeBoxSeasons = Size(size.width * 0.496296296, size.width * 0.496296296);
      posBoxSeasons = Position((size.height - sizeBoxSeasons.height) / 2,
          size.width - sizeBoxSeasons.width - size.width * 0.277777778);
      //
      sizeMoon = size.width * 0.231965889;
      posMoon = Position((size.height - sizeMoon) / 2,
          size.width - sizeMoon - size.width * 0.409942981);
      //
      sizeBoxSolsticesEquinoxes = size.width * 0.269727778;
      posBoxSolsticesEquinoxes = Position(
          (size.height - sizeBoxSolsticesEquinoxes) / 2,
          size.width - sizeBoxSolsticesEquinoxes - size.width * 0.391062037);
      //
      paddingBoxSolsticesEquinoxes = EdgeInsets.all(size.width * 0.072222222);
      mainAxisSpacingBoxSolsticesEquinoxes = size.width * 0.066666667;
      crossAxisSpacingBoxSolsticesEquinoxes = size.width * 0.066666667;
      //
      sizeCircleSeason = size.width * 0.064;
      paddingCircleSeason = EdgeInsets.all(size.width * 0.077);
      offsetCircleSeason = Offset(0, size.width * 0.1396);
      //
      sizeButtonRelationship =
          Size(size.width * 0.214533333, size.width * 0.102897222);
      posButtonRelationship = Position(
          size.height / 2 - size.width * 0.659097222,
          size.width - size.width * 0.926025);
      //
      sizeButtonTheYear =
          Size(size.width * 0.207738889, size.width * 0.192205556);
      posButtonTheYear = Position(size.height / 2 - size.width * 0.692102778,
          size.width - size.width * 0.441625);
      //
      sizeButtonDateCalculator =
          Size(size.width * 0.214533333, size.width * 0.102897222);
      posButtonDateCalculator = Position(
          size.height / 2 + size.width * 0.556369444,
          size.width - size.width * 0.926025);
      //
      sizeButtonCholqij =
          Size(size.width * 0.207738889, size.width * 0.192205556);
      posButtonCholqij = Position(size.height / 2 + size.width * 0.500066667,
          size.width - size.width * 0.441625);
      //
      sizeBoxTextToneNahual =
          Size(size.width * 0.269727778, size.width * 0.269727778);
      posBoxTextToneNahual = Position(
          (size.height - sizeBoxTextToneNahual.height) / 2,
          size.width - sizeBoxTextToneNahual.width - size.width * 0.391062037);
      //
      texttextStyleToneNahual = TextStyle(
          color: Color.lerp(mainColor, Colors.white, 0.1)!,
          fontSize: size.width * 0.044);
      //
      sizeBoxLongCount =
          Size(size.width * 0.738888889, size.width * 0.138888889);
      posBoxLongCount = Position(size.height - size.width * 0.152777778,
          size.width - size.width * 0.927777778);
      sizeSandstones = Size(size.width * 0.138888889, size.width * 0.138888889);
      sizeNummbers = Size(size.width * 0.111111111, 0);
      paddingSandstones = EdgeInsets.only(right: size.width * 0.011111111);
      paddingNummbersBaktun = EdgeInsets.fromLTRB(
          size.width * 0.013888889, 0, size.width * 0.019444444, 0);
      paddingNummbersKatun = EdgeInsets.fromLTRB(
          size.width * 0.019444444, 0, size.width * 0.019444444, 0);
      paddingNummbersTun = EdgeInsets.fromLTRB(
          size.width * 0.019444444, 0, size.width * 0.019444444, 0);
      paddingNummbersWinal = EdgeInsets.fromLTRB(
          size.width * 0.019444444, 0, size.width * 0.019444444, 0);
      paddingNummbersKin = EdgeInsets.fromLTRB(
          size.width * 0.019444444, 0, size.width * 0.013888889, 0);
      //
    } else {
      //
      // TODO: calculate the size based on the display size
      sizeSettings = const Size(16, 120);
      posSettings =
          Position(statusBarHeight + 10, size.width - sizeSettings.width);
      //
      sizeBoxTime = Size(size.height * 0.270520231, size.height * 0.052023121);
      posBoxTime = Position(size.height / 2 - size.height * 0.436994220,
          size.width - sizeBoxTime.width - size.height * 0.208092486);
      //
      sizeIconNotification = size.height * 0.034855491;
      //
      sizePaddingNotificationTime = size.height * 0.007283237;
      //
      textStyleTime = TextStyle(
          color: Colors.white,
          fontSize: size.height * 0.031213873,
          fontWeight: FontWeight.normal);
      //
      sizeSandstoneFormTop =
          Size(size.height * 0.404007225, size.height * 0.217065029);
      posSandstoneFormTop = Position(
          size.height / 2 - size.height * 0.412573699,
          size.width - size.height * 0.493867052);
      //
      sizeShapeRightTop =
          Size(size.height * 0.210083757, size.height * 0.1650703825);
      posShapeRightTop = Position(size.height / 2 - size.height * 0.389336093,
          size.width - size.height * 0.313578828);
      //
      sizeSandstoneFormBottom =
          Size(size.height * 0.404007225, size.height * 0.217065029);
      posSandstoneFormBottom = Position(
          size.height / 2 + size.height * 0.195508671,
          size.width - size.height * 0.493867052);
      //
      sizeShapeRightBottom =
          Size(size.height * 0.210083757, size.height * 0.1650703825);
      posShapeRightBottom = Position(
          size.height / 2 + size.height * 0.224294185,
          size.width - size.height * 0.313578828);
      //
      sizeWheelNahuales =
          Size(size.height * 0.568400771, size.height * 0.568400771);
      posWheelNahuales = Position((size.height - sizeWheelNahuales.height) / 2,
          size.width - sizeWheelNahuales.width - size.height * 0.059248555);
      //
      sizeSignNahual =
          Size(size.height * 0.066589595, size.height * 0.061040462);
      offsetSignNahual = Offset(-size.height * 0.226818651, 0);
      //
      sizeWheelHaab =
          Size(size.height * 9.626204239, size.height * 9.626204239);
      posWheelHaab = Position((size.height - sizeWheelHaab.height) / 2,
          size.width - size.height * 0.080924855);
      //
      sizeSectionFieldWinal =
          Size(size.height * 4.813102119, size.height * 1.648903179);
      posSectionFieldWinal = Position(size.height * 3.98865053, 0);
      sizeSectionWinal =
          Size(size.height * 0.19541474, size.height * 1.648903179);
      offsetSectionFieldWinal = Offset(size.height * 2.40655106, 0);
      //
      sizeImageToneWhiteFlatCenter = Size(size.height * 0.044797688, 0);
      posImageToneWhiteFlatCenter =
          Position(size.height * 0.810221098, size.height * 0.005047688);
      offsetImageToneWhiteFlatCenter = Offset(size.height * 4.785655588, 0);
      //
      sizeBoxTextWinal =
          Size(size.height * 0.086705202, size.height * 0.026011561);
      posBoxTextWinal =
          Position(size.height * 0.781099711, size.height * 0.052001445);
      offsetBoxTextWinal = Offset(size.height * 4.748094894, 0);
      //
      sizeSectionFieldWinalWayeb =
          Size(size.height * 4.813102119, size.height * 0.414140173);
      posSectionFieldWinalWayeb = Position(size.height * 4.606031792, 0);
      sizeSectionWinalWayeb =
          Size(size.height * 0.135283237, size.height * 0.414140173);
      offsetSectionFieldWinalWayeb = Offset(size.height * 2.40655106, 0);
      //
      sizeImageToneWhiteFlatCenterWayeb = Size(size.height * 0.044797688, 0);
      posImageToneWhiteFlatCenterWayeb =
          Position(size.height * 0.192839595, size.height * 0.005047688);
      offsetImageToneWhiteFlatCenterWayeb =
          Offset(size.height * 4.785655588, 0);
      //
      sizeBoxTextWinalWayeb =
          Size(size.height * 0.086705202, size.height * 0.026011561);
      posBoxTextWinalWayeb =
          Position(size.height * 0.163718208, size.height * 0.052001445);
      offsetBoxTextWinalWayeb = Offset(size.height * 4.748094894, 0);
      //
      textStyleStrWinal =
          TextStyle(color: Colors.white, fontSize: size.height * 0.023121387);
      //
      sizeFrame = Size(size.height * 0.052001445, size.height * 0.052001445);
      posFrame = Position(sizeWheelHaab.height / 2 - size.height * 0.026001445,
          size.height * 0.001445087);
      offsetFrame = Offset(size.height * 4.785655588, 0);
      //
      sizeSandstoneMoon =
          Size(size.height * 0.207361272, size.height * 0.327356936);
      posSandstoneMoon = Position((size.height - size.height * 0.327356936) / 2,
          size.width - size.height * 0.508572254);
      //
      sizeButtonReset =
          Size(size.height * 0.143007225, size.height * 0.302572254);
      posButtonReset = Position((size.height - size.height * 0.302572254) / 2,
          size.width - size.height * 0.496315029);
      //
      sizeWheelTones =
          Size(size.height * 0.258188825, size.height * 0.258188825);
      posWheelTones = Position((size.height - sizeWheelTones.height) / 2,
          size.width - sizeWheelTones.width - size.height * 0.144508671);
      //
      sizeSignTone = Size(size.height * 0.024971098, size.height * 0.052023121);
      offsetSignTone = Offset(-size.height * 0.104947977, 0);
      //
      sizeBoxSeasons =
          Size(size.height * 0.258188825, size.height * 0.258188825);
      posBoxSeasons = Position((size.height - sizeBoxSeasons.height) / 2,
          size.width - sizeBoxSeasons.width - size.height * 0.144508671);
      //
      sizeMoon = size.height * 0.120675896;
      posMoon = Position((size.height - sizeMoon) / 2,
          size.width - sizeMoon - size.height * 0.213265135);
      //
      sizeBoxSolsticesEquinoxes = size.width * 0.140320809;
      posBoxSolsticesEquinoxes = Position(
          (size.height - sizeBoxSolsticesEquinoxes) / 2,
          size.width - sizeBoxSolsticesEquinoxes - size.width * 0.203442678);
      //
      paddingBoxSolsticesEquinoxes = EdgeInsets.all(size.height * 0.037572254);
      mainAxisSpacingBoxSolsticesEquinoxes = size.height * 0.034682081;
      crossAxisSpacingBoxSolsticesEquinoxes = size.height * 0.034682081;
      //
      sizeCircleSeason = size.height * 0.033295;
      paddingCircleSeason = EdgeInsets.all(size.height * 0.040058);
      offsetCircleSeason = Offset(0, size.height * 0.072624);
      //
      sizeButtonRelationship =
          Size(size.height * 0.111606936, size.height * 0.053530347);
      posButtonRelationship = Position(
          size.height / 2 - size.height * 0.342882948,
          size.width - size.height * 0.48174711);
      //
      sizeButtonTheYear =
          Size(size.height * 0.108072254, size.height * 0.099991329);
      posButtonTheYear = Position(size.height / 2 - size.height * 0.360053468,
          size.width - size.height * 0.22974711);
      //
      sizeButtonDateCalculator =
          Size(size.height * 0.111606936, size.height * 0.053530347);
      posButtonDateCalculator = Position(
          size.height / 2 + size.height * 0.289440751,
          size.width - size.height * 0.48174711);
      //
      sizeButtonCholqij =
          Size(size.height * 0.108072254, size.height * 0.099991329);
      posButtonCholqij = Position(size.height / 2 + size.height * 0.260150289,
          size.width - size.height * 0.22974711);
      //
      sizeBoxTextToneNahual =
          Size(size.height * 0.140320809, size.height * 0.140320809);
      posBoxTextToneNahual = Position(
          (size.height - sizeBoxTextToneNahual.height) / 2,
          size.width - sizeBoxTextToneNahual.width - size.height * 0.203442678);
      //
      texttextStyleToneNahual = TextStyle(
          color: Color.lerp(mainColor, Colors.white, 0.1)!,
          fontSize: size.height * 0.022890173);
      //
      sizeBoxLongCount =
          Size(size.height * 0.384393064, size.height * 0.072254335);
      posBoxLongCount = Position(size.height - size.height * 0.079479769,
          size.width - size.height * 0.48265896);
      sizeSandstones =
          Size(size.height * 0.072254335, size.height * 0.072254335);
      sizeNummbers = Size(size.height * 0.057803468, 0);
      paddingSandstones = EdgeInsets.only(right: size.height * 0.005780347);
      paddingNummbersBaktun = EdgeInsets.fromLTRB(
          size.height * 0.007225434, 0, size.height * 0.010115607, 0);
      paddingNummbersKatun = EdgeInsets.fromLTRB(
          size.height * 0.010115607, 0, size.height * 0.010115607, 0);
      paddingNummbersTun = EdgeInsets.fromLTRB(
          size.height * 0.010115607, 0, size.height * 0.010115607, 0);
      paddingNummbersWinal = EdgeInsets.fromLTRB(
          size.height * 0.010115607, 0, size.height * 0.010115607, 0);
      paddingNummbersKin = EdgeInsets.fromLTRB(
          size.height * 0.010115607, 0, size.height * 0.007225434, 0);
      //
    }

    if (finalAngle == 0.0) {
      now = DateTime.now();

      final int daysGoneBy =
          (now.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch) ~/
              86400000;

      baktun = 13 + (daysGoneBy + dDays) ~/ 144000 % 14;
      katun = (daysGoneBy + dDays) ~/ 7200 % 20;
      tun = (daysGoneBy - katun * 7200 + dDays) ~/ 360 % 20;
      winal = (daysGoneBy - katun * 7200 - tun * 360 + dDays) ~/ 20 % 18;
      kin = (daysGoneBy - katun * 7200 - tun * 360 - winal * 20 + dDays) % 20;

      sBaktun = baktun;
      sKatun = katun;
      sTun = tun;
      sWinal = winal;
      sKin = kin;

      currDay = daysGoneBy % 365;
      chosenDay = currDay;
      xDayTotal = currDay;

      //TODO: change to 5141 (5152-12) after database year index update
      currYear = 5129 + daysGoneBy ~/ 365;
      chosenYear = currYear;

      tone = (startTone + daysGoneBy) % 13;
      sTone = tone;
      nahual = (startNahual + daysGoneBy) % 20;
      sNahual = nahual;

      currKinIndex = getKinNummber(tone, nahual);
      int trecena = currKinIndex ~/ 13;

      trecenaColor = trecena % 4;
      nTrecenaColor = trecenaColor;

      offsetGearNahuales = 18 * nahual / 180 * pi;
      offsetGearTones = 360 / 13 * tone / 180 * pi;
      offsetGearHaab = -360 / 365 * currDay / 180 * pi;

      int initialValueTrecenamask = currKinIndex % 52;
      diffAngle = initialValueTrecenamask % 13;
      trecenaOffsetAngle = 18 * initialValueTrecenamask / 180 * pi;

      currTrecenaMask = trecenaMask[trecenaColor];

      angleTime = (now.hour * 60 + now.minute) / 14400 * pi;

      strTextToneNahual =
          '${MayaLists().strTone[tone]}\n${MayaLists().strNahual[nahual]}';
    }
    if (seasons.isNotEmpty) {
      DateTime nowSeasons =
          now.toUtc().add(Duration(minutes: (finalAngle * 14400 / pi).toInt()));
      int index = nowSeasons.year - 2001;

      List<String> strDateTimeSeasons = [
        seasons[index - 1]['winter'],
        seasons[index]['spring'],
        seasons[index]['summer'],
        seasons[index]['fall'],
        seasons[index]['winter'],
        seasons[index + 1]['spring']
      ];

      List<DateTime> dateTimeSolsticesEquinoxes = [
        dateTimeformatSeasons.parse(strDateTimeSeasons[0]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[1]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[2]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[3]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[4]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[5])
      ];

      List<Duration> durations = [
        nowSeasons.difference(dateTimeSolsticesEquinoxes[1]),
        nowSeasons.difference(dateTimeSolsticesEquinoxes[2]),
        nowSeasons.difference(dateTimeSolsticesEquinoxes[3]),
        nowSeasons.difference(dateTimeSolsticesEquinoxes[4]),
      ];

      List<int> diffSeasons = [
        durations[0].inMinutes,
        durations[1].inMinutes,
        durations[2].inMinutes,
        durations[3].inMinutes,
      ];

      List<int> diffSeasonsAbs = [
        durations[0].inMinutes.abs(),
        durations[1].inMinutes.abs(),
        durations[2].inMinutes.abs(),
        durations[3].inMinutes.abs(),
      ];

      int minimum = diffSeasonsAbs.reduce(min);

      int indexMinimum =
          diffSeasonsAbs.indexWhere((element) => element == minimum);

      if (diffSeasons[indexMinimum] < 0) {
        int seasonTime = dateTimeSolsticesEquinoxes[indexMinimum + 1]
            .difference(dateTimeSolsticesEquinoxes[indexMinimum])
            .inMinutes;

        double angle = (90 / seasonTime) * -diffSeasons[indexMinimum];

        switch (indexMinimum) {
          case 0:
            // winter
            angleSeason = 270 + angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/winter_icon_dark.svg');
            break;
          case 1:
            // spring
            angleSeason = 180 + angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/spring_icon_dark.svg');
            break;
          case 2:
            // summer
            angleSeason = 90 + angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/summer_icon_dark.svg');
            break;
          case 3:
            // fall
            angleSeason = angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/fall_icon_dark.svg');
            break;
          default:
            angleSeason = 0;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/winter_icon_dark.svg');
        }
      } else {
        int seasonTime = dateTimeSolsticesEquinoxes[indexMinimum + 1]
            .difference(dateTimeSolsticesEquinoxes[indexMinimum + 2])
            .inMinutes;

        double angle = (90 / seasonTime) * -diffSeasons[indexMinimum];

        switch (indexMinimum) {
          case 0:
            // spring
            angleSeason = 270 - angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/spring_icon_dark.svg');
            break;
          case 1:
            // summer
            angleSeason = 180 - angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/summer_icon_dark.svg');
            break;
          case 2:
            // fall
            angleSeason = 90 - angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/fall_icon_dark.svg');
            break;
          case 3:
            // winter
            angleSeason = -angle;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/winter_icon_dark.svg');
            break;
          default:
            angleSeason = 0;
            iconSeason =
                SvgPicture.asset('assets/vector_graphics/winter_icon_dark.svg');
        }
      }
    }

    strTextToneNahual =
        '${MayaLists().strTone[sTone]}\n${MayaLists().strNahual[sNahual]}';

    DateTime datetimeMoon =
        now.add(Duration(minutes: (finalAngle * 14400 / pi).toInt()));

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: _customDrawer(context, size),
        endDrawerEnableOpenDragGesture: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(children: [
              Positioned(
                  top: posBoxTime.top,
                  left: posBoxTime.left,
                  child: Container(
                    height: sizeBoxTime.height,
                    width: sizeBoxTime.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.elliptical(
                            sizeBoxTime.width, sizeBoxTime.height)),
                        image: const DecorationImage(
                            image:
                                AssetImage('assets/images/sandstone_time.jpg'),
                            fit: BoxFit.cover)),
                    child: Text(currTime,
                        textAlign: TextAlign.center, style: textStyleTime),
                  )),
              Positioned(
                  top: posSandstoneFormTop.top,
                  left: posSandstoneFormTop.left,
                  child: Image.asset('assets/images/sandstoneForm_top.png',
                      height: sizeSandstoneFormTop.height,
                      width: sizeSandstoneFormTop.width)),
              Positioned(
                  top: posShapeRightTop.top,
                  left: posShapeRightTop.left,
                  child: Image.asset('assets/images/shape_right_top.png',
                      height: sizeShapeRightTop.height,
                      width: sizeShapeRightTop.width,
                      color: mainColor,
                      colorBlendMode: BlendMode.modulate)),
              Positioned(
                  top: posSandstoneFormBottom.top,
                  left: posSandstoneFormBottom.left,
                  child: Image.asset('assets/images/sandstoneForm_bottom.png',
                      height: sizeSandstoneFormBottom.height,
                      width: sizeSandstoneFormBottom.width)),
              Positioned(
                  top: posShapeRightBottom.top,
                  left: posShapeRightBottom.left,
                  child: Image.asset('assets/images/shape_right_bottom.png',
                      height: sizeShapeRightBottom.height,
                      width: sizeShapeRightBottom.width,
                      color: mainColor,
                      colorBlendMode: BlendMode.modulate)),
              Positioned(
                  top: posWheelHaab.top,
                  left: posWheelHaab.left,
                  child: Transform.rotate(
                      angle: offsetGearHaab -
                          (angleTime + finalAngle) * 20 / 365 +
                          (1 / 365) *
                              pi, // TODO: check if calculation is correct
                      child: SizedBox(
                          height: sizeWheelHaab.height,
                          width: sizeWheelHaab.width,
                          child: Stack(children: [
                            for (int i = 0; i < 18; i++)
                              Positioned(
                                  top: posSectionFieldWinal.top,
                                  left: posSectionFieldWinal.left,
                                  child: Transform.rotate(
                                      angle: 360 /
                                          365 *
                                          (10 + i * 20) /
                                          180 *
                                          pi, // TODO short calculation if possible
                                      origin: offsetSectionFieldWinal,
                                      child: SizedBox(
                                          height: sizeSectionFieldWinal.height,
                                          width: sizeSectionFieldWinal.width,
                                          child: Stack(children: [
                                            Positioned(
                                                child: Image.asset(
                                                    'assets/images/shape_section_winal.png',
                                                    height:
                                                        sizeSectionWinal.height,
                                                    width:
                                                        sizeSectionWinal.width,
                                                    color: mainColor,
                                                    colorBlendMode:
                                                        BlendMode.modulate)),
                                            for (int j = 0; j < 20; j++)
                                              Positioned(
                                                  top:
                                                      posImageToneWhiteFlatCenter
                                                          .top,
                                                  left:
                                                      posImageToneWhiteFlatCenter
                                                          .left,
                                                  child: Transform.rotate(
                                                      angle: (-360 / 365 * 10 +
                                                              360 / 365 * j) /
                                                          180 *
                                                          pi,
                                                      origin:
                                                          offsetImageToneWhiteFlatCenter,
                                                      child: SizedBox(
                                                          width:
                                                              sizeImageToneWhiteFlatCenter
                                                                  .width,
                                                          child: MayaImages()
                                                                  .imageToneWhiteFlatCenter[
                                                              j]))),
                                            for (int j = 0; j < 20; j++)
                                              Positioned(
                                                  top: posBoxTextWinal.top,
                                                  left: posBoxTextWinal.left,
                                                  child: Transform.rotate(
                                                      angle: (-360 / 365 * 10 +
                                                              360 / 365 * j) /
                                                          180 *
                                                          pi,
                                                      origin:
                                                          offsetBoxTextWinal,
                                                      child: RotatedBox(
                                                          quarterTurns: -1,
                                                          child: SizedBox(
                                                              height:
                                                                  sizeBoxTextWinal
                                                                      .height,
                                                              width:
                                                                  sizeBoxTextWinal
                                                                      .width,
                                                              child: Center(
                                                                  child: Text(
                                                                      MayaLists()
                                                                          .strWinal[i],
                                                                      style: textStyleStrWinal))))))
                                          ])))),
                            Positioned(
                                top: posSectionFieldWinalWayeb.top,
                                left: posSectionFieldWinalWayeb.left,
                                child: Transform.rotate(
                                    angle: 360 / 365 * 362.5 / 180 * pi,
                                    origin: offsetSectionFieldWinalWayeb,
                                    child: SizedBox(
                                        height:
                                            sizeSectionFieldWinalWayeb.height,
                                        width: sizeSectionFieldWinalWayeb.width,
                                        child: Stack(children: [
                                          Positioned(
                                              child: Image.asset(
                                                  'assets/images/shape_section_winal_wayeb.png',
                                                  height: sizeSectionWinalWayeb
                                                      .height,
                                                  width: sizeSectionWinalWayeb
                                                      .width,
                                                  color: mainColor,
                                                  colorBlendMode:
                                                      BlendMode.modulate)),
                                          for (int i = 0; i < 5; i++)
                                            Positioned(
                                                top:
                                                    posImageToneWhiteFlatCenterWayeb
                                                        .top,
                                                left:
                                                    posImageToneWhiteFlatCenterWayeb
                                                        .left,
                                                child: Transform.rotate(
                                                    angle: (-360 / 365 * 2.5 +
                                                            360 / 365 * i) /
                                                        180 *
                                                        pi,
                                                    origin:
                                                        offsetImageToneWhiteFlatCenterWayeb,
                                                    child: SizedBox(
                                                        width:
                                                            sizeImageToneWhiteFlatCenterWayeb
                                                                .width,
                                                        child: MayaImages()
                                                                .imageToneWhiteFlatCenter[
                                                            i]))),
                                          Positioned(
                                              top:
                                                  posImageToneWhiteFlatCenterWayeb
                                                      .top,
                                              left:
                                                  posImageToneWhiteFlatCenterWayeb
                                                      .left,
                                              child: Transform.rotate(
                                                  angle: (-360 / 365 * 2.5 +
                                                          360 / 365 * 5) /
                                                      180 *
                                                      pi,
                                                  origin:
                                                      offsetImageToneWhiteFlatCenterWayeb,
                                                  child: SizedBox(
                                                      width:
                                                          sizeImageToneWhiteFlatCenterWayeb
                                                              .width,
                                                      child: MayaImages()
                                                              .imageToneWhiteFlatCenter[
                                                          0]))),
                                          for (int i = 0; i < 5; i++)
                                            Positioned(
                                                top: posBoxTextWinalWayeb.top,
                                                left: posBoxTextWinalWayeb.left,
                                                child: Transform.rotate(
                                                    angle: (-360 / 365 * 2.5 +
                                                            360 / 365 * i) /
                                                        180 *
                                                        pi,
                                                    origin:
                                                        offsetBoxTextWinalWayeb,
                                                    child: RotatedBox(
                                                        quarterTurns: -1,
                                                        child: SizedBox(
                                                            height:
                                                                sizeBoxTextWinalWayeb
                                                                    .height,
                                                            width:
                                                                sizeBoxTextWinalWayeb
                                                                    .width,
                                                            child: Center(
                                                                child: Text(
                                                                    MayaLists()
                                                                        .strWinal[18],
                                                                    style: textStyleStrWinal)))))),
                                          Positioned(
                                              top: posBoxTextWinalWayeb.top,
                                              left: posBoxTextWinalWayeb.left,
                                              child: Transform.rotate(
                                                  angle: (-360 / 365 * 2.5 +
                                                          360 / 365 * 5) /
                                                      180 *
                                                      pi,
                                                  origin:
                                                      offsetBoxTextWinalWayeb,
                                                  child: RotatedBox(
                                                      quarterTurns: -1,
                                                      child: SizedBox(
                                                          height:
                                                              sizeBoxTextWinalWayeb
                                                                  .height,
                                                          width:
                                                              sizeBoxTextWinalWayeb
                                                                  .width,
                                                          child: Center(
                                                              child: Text(
                                                                  MayaLists()
                                                                          .strWinal[
                                                                      0],
                                                                  style:
                                                                      textStyleStrWinal))))))
                                        ]))))
                          ])))),
              Positioned(
                  top: posWheelHaab.top,
                  left: posWheelHaab.left,
                  child: Transform.rotate(
                      angle: offsetGearHaab -
                          (angleTime + finalAngle) * 20 / 365 +
                          (1 / 365) *
                              pi, // TODO: check if calculation is correct
                      child: SizedBox(
                          height: sizeWheelHaab.height,
                          width: sizeWheelHaab.width,
                          child: Consumer<MayaData>(
                              builder: (context, data, child) {
                            return Stack(children: [
                              for (int i = -20; i < 21; i++)
                                if (inticators(i, data.mayaData))
                                  Positioned(
                                      top: posFrame.top,
                                      left: posFrame.left,
                                      child: Transform.rotate(
                                          angle: 360 /
                                              365 *
                                              ((xDayTotal + i) % 365) /
                                              180 *
                                              pi,
                                          origin: offsetFrame,
                                          child: Container(
                                              height: sizeFrame.height,
                                              width: sizeFrame.width,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      32, 255, 255, 255),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  shape: BoxShape.rectangle))))
                            ]);
                          })))),
              Positioned(
                  top: posSandstoneMoon.top,
                  left: posSandstoneMoon.left,
                  child: Image.asset("assets/images/sandstoneMoon.png",
                      height: sizeSandstoneMoon.height,
                      width: sizeSandstoneMoon.width)),
              Positioned(
                  top: posWheelNahuales.top,
                  left: posWheelNahuales.left,
                  child: Transform.rotate(
                      angle: offsetGearNahuales + angleTime + finalAngle,
                      child: Image.asset('assets/images/gearNahuales.png',
                          height: sizeWheelNahuales.height,
                          width: sizeWheelNahuales.width,
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate))),
              Positioned(
                  top: posWheelNahuales.top,
                  left: posWheelNahuales.left,
                  child: Transform.rotate(
                      angle: (trecenaOffsetAngle +
                          dTrecenaAngle +
                          angleTime +
                          finalAngle),
                      child: SizedBox(
                          height: sizeWheelNahuales.height,
                          width: sizeWheelNahuales.width,
                          child: currTrecenaMask))),
              Positioned(
                  top: posWheelNahuales.top,
                  left: posWheelNahuales.left,
                  child: SizedBox(
                      height: sizeWheelNahuales.height,
                      width: sizeWheelNahuales.width,
                      child: LayoutBuilder(builder: (context, constraints) {
                        Offset centerOfGestureDetector = Offset(
                            constraints.maxWidth / 2,
                            constraints.maxHeight / 2);
                        return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onPanStart: (details) {
                              final touchPositionFromCenter =
                                  details.localPosition -
                                      centerOfGestureDetector;
                              upsetAngle =
                                  oldAngle - touchPositionFromCenter.direction;
                            },
                            onPanUpdate: (details) {
                              final touchPositionFromCenter =
                                  details.localPosition -
                                      centerOfGestureDetector;
                              setState(() {
                                prevAngle = finalAngle;

                                finalAngle = touchPositionFromCenter.direction +
                                    upsetAngle;

                                finalAngle = (finalAngle + 2 * pi) % (2 * pi);

                                if (finalAngle + mAngle - prevAngle <
                                    -1.5 * pi) {
                                  iRounds++;
                                  mAngle = 2 * pi * iRounds;
                                }

                                if (finalAngle + mAngle - prevAngle >
                                    1.5 * pi) {
                                  mAngle = 2 * pi * iRounds - 2 * pi;
                                  iRounds--;
                                }

                                finalAngle = finalAngle + mAngle;

                                double angle = offsetGearHaab -
                                    (angleTime + finalAngle) * 20 / 365;

                                // get chosenDayTotal, chosenDay
                                int chosenDayTotal =
                                    (-angle * 180 / pi * 365 / 360).floor();
                                chosenDay = chosenDayTotal % 365;

                                // get chosenYear, chosenHaabYear
                                chosenYear = currYear +
                                    (-angle * 180 / pi / 360).floor();

                                if (chosenDayTotal % 10 == 0) {
                                  xDayTotal = chosenDayTotal;
                                }

                                // increase Tone Name, Nahual Name and the Long Count
                                if (finalAngle * 180 / pi > 18 * nAngle + 9) {
                                  sTone++;
                                  sNahual++;
                                  nAngle++;

                                  if (sTone > 12) {
                                    sTone = 0;
                                  }
                                  if (sNahual > 19) {
                                    sNahual = 0;
                                  }

                                  strTextToneNahual =
                                      '${MayaLists().strTone[sTone]}\n${MayaLists().strNahual[sNahual]}';

                                  sKin++;
                                  if (sKin > 19) {
                                    sKin = 0;
                                    sWinal++;
                                    if (sWinal > 17) {
                                      sWinal = 0;
                                      sTun++;
                                      if (sTun > 19) {
                                        sTun = 0;
                                        sKatun++;
                                        if (sKatun > 19) {
                                          sKatun = 0;
                                          sBaktun++;
                                        }
                                      }
                                    }
                                  }
                                }

                                // decrease Tone Name, Nahual Name and the Long Count
                                if (finalAngle * 180 / pi < 18 * nAngle - 9) {
                                  sTone--;
                                  sNahual--;
                                  nAngle--;

                                  if (sTone < 0) {
                                    sTone = 12;
                                  }
                                  if (sNahual < 0) {
                                    sNahual = 19;
                                  }

                                  strTextToneNahual =
                                      '${MayaLists().strTone[sTone]}\n${MayaLists().strNahual[sNahual]}';

                                  sKin--;
                                  if (sKin < 0) {
                                    sKin = 19;
                                    sWinal--;
                                    if (sWinal < 0) {
                                      sWinal = 17;
                                      sTun--;
                                      if (sTun < 0) {
                                        sTun = 19;
                                        sKatun--;
                                        if (sKatun < 0) {
                                          sKatun = 19;
                                          sBaktun--;
                                        }
                                      }
                                    }
                                  }
                                }

                                // change Trecena
                                if ((finalAngle + angleTime) * 180 / pi >
                                    234 * iTrecena - diffAngle * 18) {
                                  nTrecenaColor++;
                                  if (nTrecenaColor > 3) {
                                    nTrecenaColor = 0;
                                  }
                                  if (nTrecenaColor == 0) {
                                    nTrecenaAngle++;
                                    dTrecenaAngle =
                                        144.0 * nTrecenaAngle / 180 * pi;
                                  }
                                  currTrecenaMask = trecenaMask[nTrecenaColor];
                                  iTrecena++;
                                }
                                if ((finalAngle + angleTime) * 180 / pi <
                                    234 * iTrecena - 234 - diffAngle * 18) {
                                  nTrecenaColor--;
                                  if (nTrecenaColor < 0) {
                                    nTrecenaColor = 3;
                                  }
                                  if (nTrecenaColor == 3) {
                                    nTrecenaAngle--;
                                    dTrecenaAngle =
                                        144.0 * nTrecenaAngle / 180 * pi;
                                  }
                                  currTrecenaMask = trecenaMask[nTrecenaColor];
                                  iTrecena--;
                                }
                              });
                            },
                            onPanEnd: (details) {
                              oldAngle = finalAngle;
                            },
                            child: Transform.rotate(
                                angle:
                                    offsetGearNahuales + angleTime + finalAngle,
                                child: Stack(children: [
                                  for (int i = 0; i < 20; i++)
                                    Align(
                                        alignment: const Alignment(0.904, 0),
                                        child: Transform.rotate(
                                            origin: offsetSignNahual,
                                            angle: -1 / 10 * pi * i -
                                                1 /
                                                    20 *
                                                    pi, // TODO: check if calculation is correct
                                            child: SizedBox(
                                                height: sizeSignNahual.height,
                                                width: sizeSignNahual.width,
                                                child: MayaImages()
                                                    .signNahual[i])))
                                ])));
                      }))),
              Positioned(
                  top: posButtonReset.top,
                  left: posButtonReset.left,
                  child: GestureDetector(
                      onTap: () {
                        reset();
                      },
                      onLongPress: () {
                        int character = Random().nextInt(260);

                        List<int> toneNahual =
                            Methods().getToneNahual(character + 150 % 260);

                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, __, _) =>
                                    RandomCharacter(
                                        backgroundImage: backgroundImage,
                                        mainColor: mainColor,
                                        tone: toneNahual[0],
                                        nahual: toneNahual[1])));
                      },
                      child: Image.asset("assets/images/shape_button_moon.png",
                          height: sizeButtonReset.height,
                          width: sizeButtonReset.width,
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate))),
              Positioned(
                  top: posWheelTones.top,
                  left: posWheelTones.left,
                  child: Transform.rotate(
                      angle:
                          offsetGearTones + (angleTime + finalAngle) / 13 * 20,
                      child: SizedBox(
                          height: sizeWheelTones.height,
                          width: sizeWheelTones.width,
                          child: Stack(children: [
                            Image.asset(
                              'assets/images/gearTones.png',
                              color: mainColor,
                              colorBlendMode: BlendMode.modulate,
                            ),
                            Stack(children: [
                              for (int i = 0; i < 13; i++)
                                Align(
                                    alignment: const Alignment(0.9, 0),
                                    child: Transform.rotate(
                                        origin: offsetSignTone,
                                        angle: -2 /
                                                13 * // -360 / 13 / 180 = -2 / 13
                                                pi *
                                                i -
                                            1 / 13 * pi,
                                        child: SizedBox(
                                            height: sizeSignTone.height,
                                            width: sizeSignTone.width,
                                            child: MayaImages()
                                                .imageToneWhiteVertical[i])))
                            ])
                          ])))),
              Positioned(
                  top: posBoxSeasons.top,
                  left: posBoxSeasons.left,
                  child: SizedBox(
                      height: sizeBoxSeasons.height,
                      width: sizeBoxSeasons.width,
                      child: GridView.count(
                          primary: false,
                          padding: paddingBoxSolsticesEquinoxes,
                          mainAxisSpacing: mainAxisSpacingBoxSolsticesEquinoxes,
                          crossAxisSpacing:
                              crossAxisSpacingBoxSolsticesEquinoxes,
                          crossAxisCount: 3,
                          children: <Widget>[
                            SizedBox(),
                            SvgPicture.asset(
                                "assets/vector_graphics/winter_icon.svg"),
                            SizedBox(),
                            SvgPicture.asset(
                                "assets/vector_graphics/spring_icon.svg"),
                            SizedBox(),
                            SvgPicture.asset(
                                "assets/vector_graphics/fall_icon.svg"),
                            SizedBox(),
                            SvgPicture.asset(
                                "assets/vector_graphics/summer_icon.svg"),
                            SizedBox()
                          ]))),
              Positioned(
                  top: posBoxSeasons.top,
                  left: posBoxSeasons.left,
                  child: Container(
                      height: sizeBoxSeasons.height,
                      width: sizeBoxSeasons.width,
                      padding: paddingCircleSeason,
                      alignment: Alignment.topCenter,
                      child: Transform.rotate(
                          angle: angleSeason / 180 * pi,
                          origin: offsetCircleSeason,
                          child: SizedBox(
                              height: sizeCircleSeason,
                              width: sizeCircleSeason,
                              child: iconSeason)))),
              Positioned(
                  top: posMoon.top + sizeMoon / 4,
                  left: posMoon.left + sizeMoon / 4,
                  child: MoonWidget(
                      date: datetimeMoon,
                      resolution: sizeMoon,
                      size: sizeMoon,
                      moonColor: Color.fromARGB(255, 215, 215, 215),
                      earthshineColor:
                          Color.lerp(mainColor, Colors.black, 0.32)!)),
              Positioned(
                  top: posMoon.top,
                  left: posMoon.left,
                  child: Opacity(
                      opacity: 0.6,
                      child: Image.asset('assets/images/moon_pattern.png',
                          height: sizeMoon,
                          width: sizeMoon,
                          colorBlendMode: BlendMode.modulate,
                          color: Color.lerp(mainColor, Colors.black, 0.52)!))),
              Positioned(
                  top: posButtonRelationship.top,
                  left: posButtonRelationship.left,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Relationship(
                                    backgroundImage: backgroundImage,
                                    mainColor: mainColor)));
                      },
                      child: Image.asset(
                          'assets/images/shape_button_left_top.png',
                          height: sizeButtonRelationship.height,
                          width: sizeButtonRelationship.width,
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate))),
              Positioned(
                  top: posButtonTheYear.top,
                  left: posButtonTheYear.left,
                  child: GestureDetector(
                      onTap: () {
                        int beginTone =
                            (startTone + 365 * (chosenYear - 5129)) % 13;
                        int beginNahual =
                            (startNahual + 365 * (chosenYear - 5129)) % 20;
                        int beginKinIndex =
                            (startKinIndex + 365 * (chosenYear - 5129)) % 260;

                        int cBaktun = 13 +
                            (365 * (chosenYear - 5129) + dDays) ~/ 144000 % 14;
                        int cKatun =
                            (365 * (chosenYear - 5129) + dDays) ~/ 7200 % 20;
                        int cTun = (365 * (chosenYear - 5129) +
                                dDays -
                                cKatun * 7200) ~/
                            360 %
                            20;
                        int cWinal = (365 * (chosenYear - 5129) +
                                dDays -
                                cKatun * 7200 -
                                cTun * 360) ~/
                            20 %
                            18;
                        int cKin = (365 * (chosenYear - 5129) +
                                dDays -
                                cKatun * 7200 -
                                cTun * 360 -
                                cWinal * 20) %
                            20;

                        DateTime chosenBeginGregorianDate = startDate
                            .add(Duration(days: 365 * (chosenYear - 5129)));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TheYear(
                                      backgroundImage: backgroundImage,
                                      mainColor: mainColor,
                                      chosenYear: chosenYear,
                                      chosenDay: chosenDay,
                                      beginTone: beginTone,
                                      beginNahual: beginNahual,
                                      beginKinIndex: beginKinIndex,
                                      beginLongCount: [
                                        cBaktun,
                                        cKatun,
                                        cTun,
                                        cWinal,
                                        cKin
                                      ],
                                      chosenBeginGregorianDate:
                                          chosenBeginGregorianDate,
                                    )));
                      },
                      child: Container(
                          height: sizeButtonTheYear.height,
                          width: sizeButtonTheYear.width,
                          decoration:
                              const BoxDecoration(color: Colors.transparent)))),
              Positioned(
                  top: posButtonDateCalculator.top,
                  left: posButtonDateCalculator.left,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateCalculator(
                                    backgroundImage: backgroundImage,
                                    mainColor: mainColor)));
                      },
                      child: Image.asset(
                          'assets/images/shape_button_left_bottom.png',
                          height: sizeButtonDateCalculator.height,
                          width: sizeButtonDateCalculator.width,
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate))),
              Positioned(
                  top: posButtonCholqij.top,
                  left: posButtonCholqij.left,
                  child: GestureDetector(
                      onTap: () {
                        int sTone = getTone(((offsetGearTones +
                                    (angleTime + finalAngle) / 13 * 20) *
                                180 /
                                pi) %
                            360); // TODO: check if calculation is correct
                        int sNahual = getNahuales(
                            ((offsetGearNahuales + angleTime + finalAngle) *
                                    180 /
                                    pi) %
                                360); // TODO: check if calculation is correct
                        int cKinIndex = getKinNummber(sTone, sNahual);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cholqij(
                                    backgroundImage: backgroundImage,
                                    mainColor: mainColor,
                                    cKinIndex: cKinIndex)));
                      },
                      onLongPress: () {
                        int chosenTone = getTone(
                            ((offsetGearTones + angleTime + finalAngle) *
                                    180 /
                                    pi /
                                    13 *
                                    20) %
                                360); // TODO: check if calculation is correct

                        int chosenNahual = getNahuales(
                            ((offsetGearNahuales + angleTime + finalAngle) *
                                    180 /
                                    pi) %
                                360); // TODO: check if calculation is correct

                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, __, _) =>
                                    CharacterChoise(
                                        backgroundImage: backgroundImage,
                                        mainColor: mainColor,
                                        chosenTone: chosenTone,
                                        chosenNahual: chosenNahual)));
                      },
                      child: Container(
                          height: sizeButtonCholqij.height,
                          width: sizeButtonCholqij.width,
                          decoration:
                              const BoxDecoration(color: Colors.transparent)))),
              Positioned(
                  top: posBoxTextToneNahual.top,
                  left: posBoxTextToneNahual.left,
                  child: SizedBox(
                      height: sizeBoxTextToneNahual.height,
                      width: sizeBoxTextToneNahual.width,
                      child: Center(
                          child: GestureDetector(
                              onTap: () {
                                int beginTone =
                                    (startTone + 365 * (chosenYear - 5129)) %
                                        13;
                                int beginNahual =
                                    (startNahual + 365 * (chosenYear - 5129)) %
                                        20;

                                int chosenTone = getTone(((offsetGearTones +
                                            (angleTime + finalAngle) /
                                                13 *
                                                20) *
                                        180 /
                                        pi) %
                                    360); // TODO: check if calculation is correct

                                int chosenNahual = getNahuales(
                                    ((offsetGearNahuales +
                                                angleTime +
                                                finalAngle) *
                                            180 /
                                            pi) %
                                        360); // TODO: check if calculation is correct

                                int dYear = getDeldaYear((-offsetGearHaab *
                                            9 /
                                            pi +
                                        ((angleTime + finalAngle) * 180 / pi) /
                                            365) *
                                    20); // TODO: check if calculation is correct

                                DateTime chosenGregorianDate = startDate.add(
                                    Duration(
                                        days: 365 * (currYear - 5129 + dYear) +
                                            chosenDay));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TheDay(
                                            backgroundImage: backgroundImage,
                                            mainColor: mainColor,
                                            chosenYear: chosenYear,
                                            chosenDay: chosenDay,
                                            chosenTone: chosenTone,
                                            chosenNahual: chosenNahual,
                                            beginTone: beginTone,
                                            beginNahual: beginNahual,
                                            chosenLongCount: [
                                              sBaktun,
                                              sKatun,
                                              sTun,
                                              sWinal,
                                              sKin
                                            ],
                                            chosenGregorianDate:
                                                chosenGregorianDate)));
                              },
                              onLongPress: () {
                                int beginTone =
                                    (startTone + 365 * (chosenYear - 5129)) %
                                        13;
                                int beginNahual =
                                    (startNahual + 365 * (chosenYear - 5129)) %
                                        20;

                                int chosenTone = getTone(((offsetGearTones +
                                            (angleTime + finalAngle) /
                                                13 *
                                                20) *
                                        180 /
                                        pi) %
                                    360); // TODO: check if calculation is correct

                                int chosenNahual = getNahuales(
                                    ((offsetGearNahuales +
                                                angleTime +
                                                finalAngle) *
                                            180 /
                                            pi) %
                                        360); // TODO: check if calculation is correct

                                int dYear = getDeldaYear((-offsetGearHaab *
                                            9 /
                                            pi +
                                        ((angleTime + finalAngle) * 180 / pi) /
                                            365) *
                                    20); // TODO: check if calculation is correct

                                DateTime chosenGregorianDate = startDate.add(
                                    Duration(
                                        days: 365 * (currYear - 5129 + dYear) +
                                            chosenDay));

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, __, _) =>
                                                DateSelection(
                                                    backgroundImage:
                                                        backgroundImage,
                                                    mainColor: mainColor,
                                                    chosenYear: chosenYear,
                                                    chosenDay: chosenDay,
                                                    chosenTone: chosenTone,
                                                    chosenNahual: chosenNahual,
                                                    beginTone: beginTone,
                                                    beginNahual: beginNahual,
                                                    chosenLongCount: [
                                                      sBaktun,
                                                      sKatun,
                                                      sTun,
                                                      sWinal,
                                                      sKin
                                                    ],
                                                    chosenGregorianDate:
                                                        chosenGregorianDate)));
                              },
                              child: Text(strTextToneNahual,
                                  textAlign: TextAlign.center,
                                  style: texttextStyleToneNahual))))),
              Stack(children: [
                Positioned(
                    top: posBoxLongCount.top,
                    left: posBoxLongCount.left,
                    child: SizedBox(
                        height: sizeBoxLongCount.height,
                        width: sizeBoxLongCount.width,
                        child: Row(children: [
                          Padding(
                              padding: paddingSandstones,
                              child: tunContainer(size, sBaktun)),
                          Padding(
                              padding: paddingSandstones,
                              child: tunContainer(size, sKatun)),
                          Padding(
                              padding: paddingSandstones,
                              child: tunContainer(size, sTun)),
                          Padding(
                              padding: paddingSandstones,
                              child: tunContainer(size, sWinal)),
                          tunContainer(size, sKin)
                        ]))),
                Positioned(
                    top: posSettings.top,
                    left: posSettings.left,
                    child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: AndroidGestureExclusionContainer(
                          child: Container(
                              height: sizeSettings.height,
                              width: sizeSettings.width,
                              decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.5),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)))),
                        ))),
              ])
            ])));
  }
  /*                                                                          */
  /* Build - END                                                              */
  /* ------------------------------------------------------------------------ */
}

Future<Object> readLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'language';
  return prefs.getString(key) ?? 'en_GB';
}

saveLanguage(language) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'language';
  prefs.setString(key, language);
}

Future<Object> readTimeFormat() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'timeformat';
  return prefs.getString(key) ?? 'h:mm a';
}

saveTimeFormat(timeFormat) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'timeformat';
  prefs.setString(key, timeFormat);
}

Future<Object> readMainColor() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'mainColor';
  return prefs.getString(key) ?? '0xff0000ff';
}

deleteMainColor() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('mainColor');
}

Future<ImageProvider> readBgFilePath() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'bgFilePath';
  String bgFilePath = prefs.getString(key) ?? 'assets/images/leaves.jpg';
  if (!await File(bgFilePath).exists()) {
    return const AssetImage('assets/images/leaves.jpg');
  } else {
    return FileImage(File(bgFilePath));
  }
}

saveBgFilePath(String bgFilePath) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'bgFilePath';
  prefs.setString(key, bgFilePath);
}

deleteBgImagePath() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('bgFilePath');
}

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  alarmPrint('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    alarmPrint('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    alarmPrint(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}

Future<void> checkAndroidNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    alarmPrint('Requesting notification permission...');
    final res = await Permission.notification.request();
    alarmPrint(
      'Notification permission ${res.isGranted ? '' : 'not '}granted.',
    );
  }
}

showImageFileFormatDialog(BuildContext context, Color mainColor, Size size) {
  Size size = GetTextSize().getTextSize(
      'Only jpeg/jpg and png files are allowed!'.tr, MayaStyle.popUpDialogBody);
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: MayaStyle().popUpDialogDecoration(mainColor),
                height: 93,
                width: size.width + 42,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Invalid File Format!'.tr,
                          style: MayaStyle.popUpDialogTitle),
                      Text('\n${'Only jpeg/jpg and png files are allowed!'.tr}',
                          style: MayaStyle.popUpDialogBody)
                    ])));
      });
}

Future<void> _launchPrivacyPolicy() async {
  final Uri urlPrivacyPolicy =
      Uri.parse('https://sites.google.com/view/privacy-policy-of-maya');
  if (!await launchUrl(urlPrivacyPolicy)) {
    throw Exception('Could not launch $urlPrivacyPolicy');
  }
}

Future<void> _launchGithub() async {
  final Uri urlGithub = Uri.parse('https://github.com/mario-schmid/maya');
  if (!await launchUrl(urlGithub)) {
    throw Exception('Could not launch $urlGithub');
  }
}

//TODO: remove in the future
Future<bool> updateYear() async {
  bool adjustDatabase = await readAdjustDatabase() == 'true' ? true : false;
  if (adjustDatabase) {
    bool flagEvents = await DatabaseHandlerEvents().updateYear();
    bool flagNotes = await DatabaseHandlerNotes().updateYear();
    bool flagTasks = await DatabaseHandlerTasks().updateYear();
    bool flagAlarms = await DatabaseHandlerAlarms().updateYear();
    bool flagArrangement = await DatabaseHandlerArrangements().updateYear();
    if (flagEvents || flagNotes || flagTasks || flagAlarms || flagArrangement) {
      saveAdjustDatabase(false.toString());
      return true;
    } else {
      saveAdjustDatabase(false.toString());
      return false;
    }
  } else {
    return false;
  }
}

//TODO: remove in the future
Future<Object> readAdjustDatabase() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'adjustDatabase';
  return prefs.getString(key) ?? 'true';
}

//TODO: remove in the future
saveAdjustDatabase(String adjustDatabase) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'adjustDatabase';
  prefs.setString(key, adjustDatabase);
}
