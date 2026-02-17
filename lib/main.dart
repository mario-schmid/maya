import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:alarm/alarm.dart' as maya_alarm;
import 'package:android_gesture_exclusion/android_gesture_exclusion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moon_phase_plus/moon_phase_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../alarm_settings.dart';
import '../character_choice.dart';
import '../cholqij.dart';
import '../classes/position.dart';
import '../color_picker.dart';
import '../data/maya_alarm.dart';
import '../data/maya_day.dart';
import '../data/maya_event.dart';
import '../data/maya_location.dart';
import '../data/maya_note.dart';
import '../data/maya_task.dart';
import '../database_handler.dart';
import '../date_calculator.dart';
import '../date_selection.dart';
import '../helper/locale_string.dart';
import '../helper/maya_image.dart';
import '../helper/maya_list.dart';
import '../helper/maya_style.dart';
import '../helper/release_note_dialog.dart';
import '../helper/shared_prefs.dart';
import '../methods/get_delta_year.dart';
import '../methods/get_kin_number.dart';
import '../methods/get_nahual.dart';
import '../methods/get_tone.dart';
import '../methods/get_tone_nahual.dart';
import '../providers/mayadata.dart';
import '../random_character.dart';
import '../relationship.dart';
import '../ring_screen.dart';
import '../the_day.dart';
import '../the_year.dart';
import '../time_format.dart';

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
    'assets/images/cholqij_field_yellow.jpg',
  ];
  /*                                                                          */
  /* Assets for precacheImage - END                                           */
  /* ------------------------------------------------------------------------ */
  final binding = WidgetsFlutterBinding.ensureInitialized();

  SharedPrefs.removeKey('adjustDatabase');

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Color mainColor = Color(int.parse(await SharedPrefs.readMainColor()));
  ImageProvider backgroundImage = await SharedPrefs.readBgFilePath();

  binding.addPostFrameCallback((_) async {
    Element? context = binding.rootElement;
    if (context != null) {
      for (var asset in allAssetImages) {
        precacheImage(AssetImage(asset), context);
      }
    }
  });

  await maya_alarm.Alarm.init();
  runApp(
    MayaApp(
      packageInfo: packageInfo,
      mainColor: mainColor,
      backgroundImage: backgroundImage,
    ),
  );
}

class MayaApp extends StatelessWidget {
  final PackageInfo packageInfo;
  final Color mainColor;
  final ImageProvider backgroundImage;
  const MayaApp({
    super.key,
    required this.packageInfo,
    required this.mainColor,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MayaData())],
      child: GetMaterialApp(
        translations: LocaleString(),
        locale: const Locale('en', 'GB'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        home: Home(
          packageInfo: packageInfo,
          mainColor: mainColor,
          backgroundImage: backgroundImage,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final PackageInfo packageInfo;
  final Color mainColor;
  final ImageProvider backgroundImage;
  const Home({
    super.key,
    required this.packageInfo,
    required this.mainColor,
    required this.backgroundImage,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Timer _timer;
  late PackageInfo packageInfo;

  late Color mainColor;
  late ImageProvider backgroundImage;

  final DateFormat dateTimeformat = DateFormat("dd.MM.yyyy HH:mm");
  final DateFormat dateTimeformatSeasons = DateFormat(
    "yyyy-MM-ddTHH:mm:00.000Z",
  );

  late String bgFilePath;

  DateTime now = DateTime.now();

  final Future<List<Map<String, dynamic>>> _eventList = DatabaseHandlerEvents()
      .retrieveEvents();
  final Future<List<Map<String, dynamic>>> _noteList = DatabaseHandlerNotes()
      .retrieveNotes();
  final Future<List<Map<String, dynamic>>> _taskList = DatabaseHandlerTasks()
      .retrieveTasks();
  final Future<List<Map<String, dynamic>>> _alarmList = DatabaseHandlerAlarms()
      .retrieveAlarms();
  final Future<List<Map<String, dynamic>>> _arrangementList =
      DatabaseHandlerArrangements().retrieveArrangements();

  List<Map<String, dynamic>> eventList = [];
  List<Map<String, dynamic>> noteList = [];
  List<Map<String, dynamic>> taskList = [];
  List<Map<String, dynamic>> alarmList = [];
  List<Map<String, dynamic>> arrangementList = [];

  late DateTime startDate;
  String currTime = '';

  late double angleTime;

  double angleSeason = 0.0;

  SvgPicture iconSeason = SvgPicture.asset(
    'assets/vector/transparent_icon.svg',
  );

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

  static StreamSubscription<dynamic>? subscription;

  /* ------------------------------------------------------------------------ */
  /* initState                                                                */
  /*                                                                          */
  @override
  void initState() {
    packageInfo = widget.packageInfo;
    mainColor = widget.mainColor;
    backgroundImage = widget.backgroundImage;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // TODO: save version! delete this line if startup release dialog is enabled.
      await SharedPrefs.versionChanged(packageInfo.version);
      // TODO: add startup release dialog in future releases!
      /*if (await SharedPrefs.versionChanged(packageInfo.version)) {
        if (!mounted) return;
        Size size = MediaQuery.of(context).size;
        await showDialog(
          context: context,
          builder: (BuildContext context) => Center(
            child: releaseNoteDialog(size, mainColor, packageInfo.version),
          ),
        );
      }*/
    });

    // Clock
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final DateTime nowClock = DateTime.now();
      setState(() {
        currTime = TimeFormat().getTimeFormat.format(nowClock);
      });
    });
    // Clock END

    if (maya_alarm.Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermission();
    }

    subscription ??= maya_alarm.Alarm.ringing.listen((alarmSet) {
      for (final alarm in alarmSet.alarms) {
        navigateToRingScreen(alarm);
      }
    });

    startDate = DateTime.parse('2013-02-21 00:00:00');
    now.timeZoneOffset > startDate.timeZoneOffset
        ? startDate = startDate
              .add(
                Duration(hours: -1),
              ) // if the damn "daylight saving time" is set, subtract 1 hour.
        : null;

    loadLanguage();
    loadTimeFormat();
    loadSeasonsFromAssets('assets/seasons.json');
    loadData();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: check if necessary!
    _timer.cancel();
    super.dispose();
  }

  /*                                                                          */
  /* initState - END                                                          */
  /* ------------------------------------------------------------------------ */
  /* ------------------------------------------------------------------------ */
  /* loadData                                                                 */
  /*                                                                          */
  void loadData() async {
    final [
      eventList,
      noteList,
      taskList,
      alarmList,
      arrangementList,
    ] = await Future.wait([
      _eventList,
      _noteList,
      _taskList,
      _alarmList,
      _arrangementList,
    ]);

    final data = MayaData();

    for (var event in eventList) {
      data.mayaData[event['yearIndex']] ??= <int, Day>{};
      final dayData = data.mayaData[event['yearIndex']]![event['dayIndex']] ??=
          Day();

      dayData.eventList.add(
        Event(
          event['uuid'],
          event['begin'],
          event['end'],
          event['title'],
          event['description'],
        ),
      );
    }
    for (var note in noteList) {
      data.mayaData[note['yearIndex']] ??= <int, Day>{};
      final dayData = data.mayaData[note['yearIndex']]![note['dayIndex']] ??=
          Day();

      dayData.noteList.add(Note(note['uuid'], note['entry']));
    }
    for (var task in taskList) {
      data.mayaData[task['yearIndex']] ??= <int, Day>{};
      final dayData = data.mayaData[task['yearIndex']]![task['dayIndex']] ??=
          Day();

      dayData.taskList.add(
        Task(
          task['uuid'],
          task['description'],
          task['isChecked'] == 0 ? false : true,
        ),
      );
    }
    for (var alarm in alarmList) {
      data.mayaData[alarm['yearIndex']] ??= <int, Day>{};
      final dayData = data.mayaData[alarm['yearIndex']]![alarm['dayIndex']] ??=
          Day();

      dayData.alarmList.add(
        MayaAlarm(
          alarm['uuid'],
          maya_alarm.AlarmSettings(
            id: alarm['id'],
            payload: alarm['payload'],
            dateTime: dateTimeformat.parse(alarm['dateTime']),
            assetAudioPath: alarm['assetAudioPath'],
            loopAudio: alarm['loopAudio'] == 0 ? false : true,
            vibrate: alarm['vibrate'] == 0 ? false : true,
            volumeSettings: maya_alarm.VolumeSettings.fade(
              volume: alarm['volume'],
              fadeDuration: Duration(milliseconds: 500),
            ),
            notificationSettings: maya_alarm.NotificationSettings(
              title: alarm['notificationTitle'],
              body: alarm['notificationBody'],
              stopButton: 'Stop',
              icon: 'ic_stat_sign',
              iconColor: Color(0xff000000),
            ),
            warningNotificationOnKill: alarm['warningNotificationOnKill'] == 0
                ? false
                : true,
          ),
          alarm['isActive'] == 0 ? false : true,
        ),
      );
    }
    for (var arrangement in arrangementList) {
      data.mayaData[arrangement['yearIndex']] ??= <int, Day>{};
      final dayData =
          data.mayaData[arrangement['yearIndex']]![arrangement['dayIndex']] ??=
              Day();

      final List<dynamic> decodedJson = json.decode(arrangement['arrangement']);

      dayData.arrangement = decodedJson.map((jsonMap) {
        return Location.fromMap(jsonMap);
      }).toList();
    }
  }

  /*                                                                          */
  /* loadData - END                                                           */
  /* ------------------------------------------------------------------------ */
  List<bool> isSelected = [true, false];
  /* ------------------------------------------------------------------------ */
  /* init, load and set Language                                              */
  /*                                                                          */
  bool isCheckedEnglish = true;
  bool isCheckedGerman = false;
  bool isCheckedFrance = false;
  bool isCheckedSpain = false;

  void loadLanguage() async {
    String strLanguage = await SharedPrefs.readLanguage();
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
  /* ------------------------------------------------------------------------ */
  /* loadTimeFormat                                                           */
  /*                                                                          */
  void loadTimeFormat() async {
    TimeFormat().setTimeFormat = DateFormat(
      (await SharedPrefs.readTimeFormat()),
    );
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

  List<dynamic> seasons = [];
  /* ------------------------------------------------------------------------ */
  /* loadSeasonsFromAssets                                                    */
  /*                                                                          */
  void loadSeasonsFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    seasons = jsonDecode(jsonString);
  }

  /*                                                                          */
  /* loadSeasonsFromAssets - END                                              */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* navigateToRingScreen                                                     */
  /*                                                                          */
  Future<void> navigateToRingScreen(
    maya_alarm.AlarmSettings alarmSettings,
  ) async {
    String alarmSnoozeIndex = await SharedPrefs.readAlarmSnoozeIndex();

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlarmRingScreen(
          mainColor: mainColor,
          backgroundImage: backgroundImage,
          alarmSnoozeIndex: alarmSnoozeIndex,
          alarmSettings: alarmSettings,
        ),
      ),
    );
  }

  /*                                                                          */
  /* navigateToRingScreen - END                                               */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* reset                                                                    */
  /*                                                                          */
  void reset() {
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

      currTrecenaMask = MayaImage.trecenaMask[trecenaColor];

      sTone = tone;
      sNahual = nahual;
      nAngle = 0;

      strTextToneNahual =
          '${MayaList.strTone[tone]}\n${MayaList.strNahual[nahual]}';

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
  void updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  /*                                                                          */
  /* updateLanguage - END                                                     */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* indicator                                                               */
  /*                                                                          */
  bool indicator(int i, Map<int, Map<int, Day>> mayaData) {
    final int cYear = (currYear + (xDayTotal + i) / 365).floor();
    final int cDay = (xDayTotal + i) % 365;
    if (mayaData.containsKey(cYear)) {
      if (mayaData[cYear]!.containsKey(cDay)) {
        final Day dayData = mayaData[cYear]![cDay]!;
        if (dayData.eventList.isNotEmpty ||
            dayData.noteList.isNotEmpty ||
            dayData.taskList.any((element) => element.isChecked == false) ||
            dayData.alarmList.any((element) => element.isActive == true)) {
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
  /* indicator - END                                                         */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* tunContainer                                                             */
  /*                                                                          */
  Container tunContainer(
    Size sizeSandstones,
    Size sizeNumbers,
    double celery,
    int value,
  ) {
    return Container(
      height: sizeSandstones.height,
      width: sizeSandstones.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0.02 * celery)),
        image: const DecorationImage(
          image: AssetImage('assets/images/sandstone_tun.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: sizeNumbers.width,
          child: MayaImage.imageToneWhiteFlatBottom[value],
        ),
      ),
    );
  }

  /*                                                                          */
  /* tunContainer - END                                                       */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* Drawer                                                                   */
  /*                                                                          */
  Drawer _customDrawer(BuildContext context, Size size, double celery) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    final double drawerWidth = 0.8 * celery;

    final EdgeInsets paddingSign = EdgeInsets.all(0.02 * celery);
    final double sizeSign = 0.3 * celery;

    final double dividerTickness = 0.003 * celery;

    final double size01 = 0.01 * celery;
    final double size02 = 0.02 * celery;
    final double size03 = 0.03 * celery;
    final double size04 = 0.04 * celery;
    final double size05 = 0.05 * celery;
    final double size06 = 0.06 * celery;
    final double size12 = 0.12 * celery;

    final double fontSizeLanguage = 0.04 * celery;
    final double flagHeight = 0.07 * celery;
    final double flagWidth = 0.108 * celery;

    final BoxConstraints toggleButtonsConstraints = BoxConstraints(
      minHeight: 0.1 * celery,
      minWidth: 0.3 * celery,
    );
    final double toggleButtonsBorderWidth = 0.002 * celery;
    final BorderRadius toggleButtonsBorderRadius = BorderRadius.all(
      Radius.circular(0.01 * celery),
    );
    final double toggleButtonsFontSize = 0.04 * celery;

    final double settingButtonsHeight = 0.1 * celery;
    final double settingButtonsWidth = 0.2 * celery;
    final double settingIconSize = 0.08 * celery;

    final double space = 1.93 * celery;

    final EdgeInsets paddingSocialButtons = EdgeInsets.all(0.01 * celery);
    final double sizeSocialButtons = 0.13 * celery;
    final double borderWidthSocialButtons = 0.003 * celery;
    final EdgeInsets paddingIconSocialButtons = EdgeInsets.all(0.017 * celery);

    final double sizeGitLabIcon = 0.06 * celery;

    final double heightButtonsBottom = 0.08 * celery;
    final double widthButtonsBottom = 0.25 * celery;
    final double borderWidthButtonsBottom = 0.002 * celery;
    final double borderRadiusButtonsBottom = 0.01 * celery;
    final double fontSizeButtonsBottom = 0.034 * celery;

    final double fontSizeVersion = 0.036 * celery;

    return Drawer(
      width: drawerWidth,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(height: statusBarHeight),
            SizedBox(
              child: Padding(
                padding: paddingSign,
                child: Image(
                  image: const AssetImage("assets/images/icons/sign.png"),
                  height: sizeSign,
                  width: sizeSign,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: dividerTickness,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: size02),
            SizedBox(
              height: size12,
              child: CheckboxListTile(
                activeColor: mainColor.withValues(alpha: 0.5),
                side: const BorderSide(color: Colors.white),
                title: Text(
                  'English'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeLanguage,
                  ),
                ),
                secondary: Flag.fromCode(
                  FlagsCode.GB,
                  height: flagHeight,
                  width: flagWidth,
                ),
                value: isCheckedEnglish,
                onChanged: (newValue) {
                  setState(() {
                    isCheckedEnglish = newValue!;
                    isCheckedGerman = !newValue;
                    isCheckedFrance = !newValue;
                    isCheckedSpain = !newValue;
                  });
                  updateLanguage(const Locale('en', 'GB'));
                  SharedPrefs.saveLanguage('en_GB');
                },
              ),
            ),
            SizedBox(
              height: size12,
              child: CheckboxListTile(
                activeColor: mainColor.withValues(alpha: 0.5),
                side: const BorderSide(color: Colors.white),
                title: Text(
                  'German'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeLanguage,
                  ),
                ),
                secondary: Flag.fromCode(
                  FlagsCode.DE,
                  height: flagHeight,
                  width: flagWidth,
                ),
                value: isCheckedGerman,
                onChanged: (newValue) {
                  setState(() {
                    isCheckedGerman = newValue!;
                    isCheckedEnglish = !newValue;
                    isCheckedFrance = !newValue;
                    isCheckedSpain = !newValue;
                  });
                  updateLanguage(const Locale('de', 'DE'));
                  SharedPrefs.saveLanguage('de_DE');
                },
              ),
            ),
            SizedBox(
              height: size12,
              child: CheckboxListTile(
                activeColor: mainColor.withValues(alpha: 0.5),
                side: const BorderSide(color: Colors.white),
                title: Text(
                  'French'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeLanguage,
                  ),
                ),
                secondary: Flag.fromCode(
                  FlagsCode.FR,
                  height: flagHeight,
                  width: flagWidth,
                ),
                value: isCheckedFrance,
                onChanged: (newValue) {
                  setState(() {
                    isCheckedFrance = newValue!;
                    isCheckedEnglish = !newValue;
                    isCheckedGerman = !newValue;
                    isCheckedSpain = !newValue;
                  });
                  updateLanguage(const Locale('fr', 'FR'));
                  SharedPrefs.saveLanguage('fr_FR');
                },
              ),
            ),
            SizedBox(
              height: size12,
              child: CheckboxListTile(
                activeColor: mainColor.withValues(alpha: 0.5),
                side: const BorderSide(color: Colors.white),
                title: Text(
                  'Spain'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeLanguage,
                  ),
                ),
                secondary: Flag.fromCode(
                  FlagsCode.ES,
                  height: flagHeight,
                  width: flagWidth,
                ),
                value: isCheckedSpain,
                onChanged: (newValue) {
                  setState(() {
                    isCheckedSpain = newValue!;
                    isCheckedEnglish = !newValue;
                    isCheckedGerman = !newValue;
                    isCheckedFrance = !newValue;
                  });
                  updateLanguage(const Locale('es', 'ES'));
                  SharedPrefs.saveLanguage('es_ES');
                },
              ),
            ),
            SizedBox(height: size04),
            Center(
              child: ToggleButtons(
                constraints: toggleButtonsConstraints,
                fillColor: mainColor.withValues(alpha: 0.5),
                borderColor: Colors.white,
                selectedBorderColor: Colors.white,
                borderWidth: toggleButtonsBorderWidth,
                borderRadius: toggleButtonsBorderRadius,
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      isSelected[1] = false;
                      isSelected[0] = true;
                      TimeFormat().setTimeFormat = DateFormat('h:mm a');
                      SharedPrefs.saveTimeFormat('h:mm a');
                    } else {
                      isSelected[0] = false;
                      isSelected[1] = true;
                      TimeFormat().setTimeFormat = DateFormat('HH:mm:ss');
                      SharedPrefs.saveTimeFormat('HH:mm:ss');
                    }
                  });
                },
                children: <Widget>[
                  Text(
                    '12 ${'Hours'.tr}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: toggleButtonsFontSize,
                    ),
                  ),
                  Text(
                    '24 ${'Hours'.tr}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: toggleButtonsFontSize,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: settingButtonsHeight,
                  width: settingButtonsWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      mainColor = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ColorPicker(mainColor: mainColor);
                        },
                      );
                    },
                    onLongPress: () async {
                      mainColor = const Color(0xff8800ff);
                      SharedPrefs.deleteMainColor();
                    },
                    style: MayaStyle().settingsButtonStyleCarrot(
                      size,
                      mainColor,
                      celery,
                    ),
                    child: SvgPicture.asset(
                      "assets/vector/rby_icon.svg",
                      height: settingIconSize,
                      width: settingIconSize,
                    ),
                  ),
                ),
                SizedBox(width: size06),
                SizedBox(
                  height: settingButtonsHeight,
                  width: settingButtonsWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                      if (result != null) {
                        bgFilePath = result.files.first.path!;
                        SharedPrefs.saveBgFilePath(bgFilePath);
                        backgroundImage = FileImage(File(bgFilePath));
                      }
                    },
                    onLongPress: () async {
                      backgroundImage = const AssetImage(
                        'assets/images/leaves.jpg',
                      );
                      SharedPrefs.deleteBgImagePath();
                    },
                    style: MayaStyle().settingsButtonStyleCarrot(
                      size,
                      mainColor,
                      celery,
                    ),
                    child: SvgPicture.asset(
                      "assets/vector/image_icon.svg",
                      height: settingIconSize,
                      width: settingIconSize,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: settingButtonsHeight,
                  width: settingButtonsWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String customAlarmSoundPath =
                          (await SharedPrefs.readCustomAlarmSoundPath());
                      final String alarmSoundIndex =
                          (await SharedPrefs.readAlarmSoundIndex());
                      final String globalAlarmSoundVolume =
                          (await SharedPrefs.readGlobalAlarmSoundVolume());
                      final String alarmSnoozeIndex =
                          (await SharedPrefs.readAlarmSnoozeIndex());

                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, _) => AlarmSet(
                            backgroundImage: backgroundImage,
                            mainColor: mainColor,
                            alarmSoundIndex: alarmSoundIndex,
                            customAlarmSoundPath: customAlarmSoundPath,
                            globalAlarmSoundVolume: globalAlarmSoundVolume,
                            alarmSnoozeIndex: alarmSnoozeIndex,
                          ),
                        ),
                      );
                    },
                    style: MayaStyle().settingsButtonStyleCarrot(
                      size,
                      mainColor,
                      celery,
                    ),
                    child: SvgPicture.asset(
                      "assets/vector/alarm_clock_icon.svg",
                      height: settingIconSize,
                      width: settingIconSize,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height:
                  size.height - statusBarHeight - navigationBarHeight - space,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://pixelfed.social/@morgenfrost');
                      },
                      icon: Image.asset('assets/images/icons/pixelfed.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://mastodon.social/@morgenfrost');
                      },
                      icon: Image.asset('assets/images/icons/mastodon.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl(
                          'https://matrix.to/#/@morgenfrost:matrix.org',
                        );
                      },
                      icon: Image.asset('assets/images/icons/matrix.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://www.patreon.com/c/morgenfrost');
                      },
                      icon: Image.asset('assets/images/icons/patreon.png'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl(
                          'https://www.paypal.com/donate/?hosted_button_id=L4F6W8ATK42K2',
                        );
                      },
                      icon: Image.asset('assets/images/icons/paypal.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://buymeacoffee.com/morgenfrost');
                      },
                      icon: Image.asset(
                        'assets/images/icons/buy-me-a-coffee.png',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://ko-fi.com/morgenfrost');
                      },
                      icon: Image.asset('assets/images/icons/kofi.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: paddingSocialButtons,
                  child: Container(
                    height: sizeSocialButtons,
                    width: sizeSocialButtons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withValues(alpha: 0.5),
                      border: Border.all(
                        color: Colors.white,
                        width: borderWidthSocialButtons,
                      ),
                    ),
                    child: IconButton(
                      padding: paddingIconSocialButtons,
                      onPressed: () {
                        _launchUrl('https://de.liberapay.com/morgenfrost');
                      },
                      icon: Image.asset('assets/images/icons/liberapay.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: heightButtonsBottom,
                  width: widthButtonsBottom,
                  child: ElevatedButton(
                    onPressed: () async {
                      showBackupOptions(context, mainColor);
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        mainColor.withValues(alpha: 0.5),
                      ),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color: Colors.white,
                          width: borderWidthButtonsBottom,
                        ),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusButtonsBottom,
                          ),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(mainColor),
                    ),
                    child: Text(
                      'Backup',
                      style: TextStyle(fontSize: fontSizeButtonsBottom),
                    ),
                  ),
                ),
                SizedBox(width: size03),
                SizedBox(
                  height: heightButtonsBottom,
                  width: widthButtonsBottom,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        mainColor.withValues(alpha: 0.5),
                      ),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color: Colors.white,
                          width: borderWidthButtonsBottom,
                        ),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusButtonsBottom,
                          ),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(mainColor),
                    ),
                    onPressed: () async {
                      restoreDatabases(context);
                    },
                    child: Text(
                      'Restore',
                      style: TextStyle(fontSize: fontSizeButtonsBottom),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: heightButtonsBottom,
                  width: widthButtonsBottom,
                  child: ElevatedButton(
                    onPressed: _launchGitLab,
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        mainColor.withValues(alpha: 0.5),
                      ),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color: Colors.white,
                          width: borderWidthButtonsBottom,
                        ),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusButtonsBottom,
                          ),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(mainColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/vector/gitlab.svg",
                          height: sizeGitLabIcon,
                          width: sizeGitLabIcon,
                        ),
                        SizedBox(width: size02),
                        Text(
                          'GitLab',
                          style: TextStyle(fontSize: fontSizeButtonsBottom),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size03),
                SizedBox(
                  height: heightButtonsBottom,
                  width: widthButtonsBottom,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        mainColor.withValues(alpha: 0.5),
                      ),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color: Colors.white,
                          width: borderWidthButtonsBottom,
                        ),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusButtonsBottom,
                          ),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(mainColor),
                    ),
                    onPressed: _launchPrivacyPolicy,
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: fontSizeButtonsBottom),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size03),
            InkWell(
              child: Text(
                'v${packageInfo.version}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeVersion,
                ),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => Center(
                    child: ReleaseNoteDialog().alertDialog(
                      size,
                      mainColor,
                      packageInfo.version,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    final double maxAspectRatio = 18 / 38;
    final double celery = size.width / size.height <= maxAspectRatio
        ? size.width
        : size.height * maxAspectRatio;
    //
    final Size sizeSettings = Size(0.046 * celery, 0.3 * celery);
    final Position posSettings = Position(
      statusBarHeight + 0.07 * celery,
      size.width - sizeSettings.width,
    );
    final double borderWidthSettings = 0.002 * celery;
    final double borderRadiusSettings = 0.046 * celery;
    //
    final Size sizeBoxTime = Size(0.52 * celery, 0.1 * celery);
    final Position posBoxTime = Position(
      size.height / 2 - 0.84 * celery,
      size.width - sizeBoxTime.width - 0.4 * celery,
    );
    //
    final TextStyle textStyleTime = TextStyle(
      color: Colors.white,
      fontSize: 0.06 * celery,
      fontWeight: FontWeight.normal,
    );
    //
    final Size sizeSandstoneFormTop = Size(
      0.776591667 * celery,
      0.417247222 * celery,
    );
    final Position posSandstoneFormTop = Position(
      size.height / 2 - 0.793058333 * celery,
      size.width - 0.949322222 * celery,
    );
    //
    final Size sizeShapeRightTop = Size(
      0.403827667 * celery,
      0.317301957 * celery,
    );
    final Position posShapeRightTop = Position(
      size.height / 2 - 0.748390489 * celery,
      size.width - 0.602768191 * celery,
    );
    //
    final Size sizeSandstoneFormBottom = Size(
      0.776591667 * celery,
      0.417247222 * celery,
    );
    final Position posSandstoneFormBottom = Position(
      size.height / 2 + 0.375811111 * celery,
      size.width - 0.949322222 * celery,
    );
    //
    final Size sizeShapeRightBottom = Size(
      0.403827667 * celery,
      0.317301957 * celery,
    );
    final Position posShapeRightBottom = Position(
      size.height / 2 + 0.431143267 * celery,
      size.width - 0.602768191 * celery,
    );
    //
    final Size sizeWheelNahuales = Size(
      1.092592593 * celery,
      1.092592593 * celery,
    );
    final Position posWheelNahuales = Position(
      (size.height - sizeWheelNahuales.height) / 2,
      size.width - sizeWheelNahuales.width - 0.113888889 * celery,
    );
    //
    final Size sizeSignNahual = Size(0.128 * celery, 0.117333333 * celery);
    final Offset offsetSignNahual = Offset(-0.435995852 * celery, 0);
    //
    final Size sizeWheelHaab = Size(
      18.503703704 * celery,
      18.503703704 * celery,
    );
    final Position posWheelHaab = Position(
      (size.height - sizeWheelHaab.height) / 2,
      size.width - 0.155555556 * celery,
    );
    //
    final Size sizeSectionFieldWinal = Size(
      9.251851852 * celery,
      3.169558333 * celery,
    );
    final Position posSectionFieldWinal = Position(7.667072685 * celery, 0);
    final Size sizeSectionWinal = Size(
      0.375630556 * celery,
      3.169558333 * celery,
    );
    final Offset offsetSectionFieldWinal = Offset(4.625925926 * celery, 0);
    //
    final Size sizeImageToneWhiteFlatCenter = Size(0.086111111 * celery, 0);
    final Position posImageToneWhiteFlatCenter = Position(
      1.557425 * celery,
      0.009702778 * celery,
    );
    final Offset offsetImageToneWhiteFlatCenter = Offset(
      9.199093519 * celery,
      0,
    );
    //
    final Size sizeBoxTextWinal = Size(0.166666667 * celery, 0.05 * celery);
    final Position posBoxTextWinal = Position(
      1.501447222 * celery,
      0.099958333 * celery,
    );
    final Offset offsetBoxTextWinal = Offset(9.126893519 * celery, 0);
    //
    final Size sizeSectionFieldWinalWayeb = Size(
      9.251851852 * celery,
      0.796069444 * celery,
    );
    final Position posSectionFieldWinalWayeb = Position(
      8.853816667 * celery,
      0,
    );
    final Size sizeSectionWinalWayeb = Size(
      0.260044444 * celery,
      0.796069444 * celery,
    );
    final Offset offsetSectionFieldWinalWayeb = Offset(4.625925926 * celery, 0);
    //
    final Size sizeImageToneWhiteFlatCenterWayeb = Size(
      0.086111111 * celery,
      0,
    );
    final Position posImageToneWhiteFlatCenterWayeb = Position(
      0.370680556 * celery,
      0.009702778 * celery,
    );
    final Offset offsetImageToneWhiteFlatCenterWayeb = Offset(
      9.199093519 * celery,
      0,
    );
    //
    final Size sizeBoxTextWinalWayeb = Size(
      0.166666667 * celery,
      0.05 * celery,
    );
    final Position posBoxTextWinalWayeb = Position(
      0.314702778 * celery,
      0.099958333 * celery,
    );
    final Offset offsetBoxTextWinalWayeb = Offset(9.126893519 * celery, 0);
    //
    final TextStyle textStyleStrWinal = TextStyle(
      color: Colors.white,
      fontSize: 0.044444444 * celery,
    );
    //
    final Size sizeFrame = Size(0.099958333 * celery, 0.099958333 * celery);
    // FIXME: calculate with celery (border width, border radius).
    // final double borderWidthFrame = ...
    // final double borderRadiusFrame = ...
    final Position posFrame = Position(
      sizeWheelHaab.height / 2 - 0.049980556 * celery,
      0.002777778 * celery,
    );
    final Offset offsetFrame = Offset(9.199093519 * celery, 0);
    //
    final Size sizeSandstoneMoon = Size(
      0.398594444 * celery,
      0.629252778 * celery,
    );
    final Position posSandstoneMoon = Position(
      (size.height - 0.629252778 * celery) / 2,
      size.width - 0.977588889 * celery,
    );
    //
    final Size sizeButtonReset = Size(
      0.274891667 * celery,
      0.581611111 * celery,
    );
    final Position posButtonReset = Position(
      (size.height - 0.581611111 * celery) / 2,
      size.width - 0.954027778 * celery,
    );
    //
    final Size sizeWheelTones = Size(
      0.496296296 * celery,
      0.496296296 * celery,
    );
    final Position posWheelTones = Position(
      (size.height - sizeWheelTones.height) / 2,
      size.width - sizeWheelTones.width - 0.277777778 * celery,
    );
    //
    final Size sizeSignTone = Size(0.048 * celery, 0.1 * celery);
    final Offset offsetSignTone = Offset(-0.201733333 * celery, 0);
    //
    final Size sizeBoxSeasons = Size(
      0.496296296 * celery,
      0.496296296 * celery,
    );
    final Position posBoxSeasons = Position(
      (size.height - sizeBoxSeasons.height) / 2,
      size.width - sizeBoxSeasons.width - 0.277777778 * celery,
    );
    //
    final double sizeMoon = 0.231965889 * celery;
    final Position posMoon = Position(
      (size.height - sizeMoon) / 2,
      size.width - sizeMoon - 0.409942981 * celery,
    );
    //
    final EdgeInsets paddingBoxSolsticesEquinoxes = EdgeInsets.all(
      0.072222222 * celery,
    );
    final double mainAxisSpacingBoxSolsticesEquinoxes = 0.066666667 * celery;
    final double crossAxisSpacingBoxSolsticesEquinoxes = 0.066666667 * celery;
    //
    final double sizeCircleSeason = 0.064 * celery;
    final EdgeInsets paddingCircleSeason = EdgeInsets.all(0.077 * celery);
    final Offset offsetCircleSeason = Offset(0, 0.1396 * celery);
    //
    final Size sizeButtonRelationship = Size(
      0.214533333 * celery,
      0.102897222 * celery,
    );
    final Position posButtonRelationship = Position(
      size.height / 2 - 0.659097222 * celery,
      size.width - 0.926025 * celery,
    );
    //
    final Size sizeButtonTheYear = Size(
      0.207738889 * celery,
      0.192205556 * celery,
    );
    final Position posButtonTheYear = Position(
      size.height / 2 - 0.692102778 * celery,
      size.width - 0.441625 * celery,
    );
    //
    final Size sizeButtonDateCalculator = Size(
      0.214533333 * celery,
      0.102897222 * celery,
    );
    final Position posButtonDateCalculator = Position(
      size.height / 2 + 0.556369444 * celery,
      size.width - 0.926025 * celery,
    );
    //
    final Size sizeButtonCholqij = Size(
      0.207738889 * celery,
      0.192205556 * celery,
    );
    final Position posButtonCholqij = Position(
      size.height / 2 + 0.500066667 * celery,
      size.width - 0.441625 * celery,
    );
    //5
    final Size sizeBoxTextToneNahual = Size(
      0.269727778 * celery,
      0.269727778 * celery,
    );
    final Position posBoxTextToneNahual = Position(
      (size.height - sizeBoxTextToneNahual.height) / 2,
      size.width - sizeBoxTextToneNahual.width - 0.391062037 * celery,
    );
    //
    final TextStyle textStyleToneNahualStroke = TextStyle(
      fontSize: 0.044 * celery,
      height: 0.0028 * celery,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.005 * celery
        ..color = Color.lerp(mainColor, Colors.black, 0.3)!,
    );
    //
    final TextStyle textStyleToneNahualText = TextStyle(
      color: Colors.grey[350],
      fontSize: 0.044 * celery,
      height: 0.0028 * celery,
    );
    //
    final Size sizeBoxLongCount = Size(
      0.738888889 * celery,
      0.138888889 * celery,
    );
    final Position posBoxLongCount = Position(
      size.height - 0.152777778 * celery,
      size.width - 0.927777778 * celery,
    );
    final Size sizeSandstones = Size(
      0.138888889 * celery,
      0.138888889 * celery,
    );
    final Size sizeNumbers = Size(0.111111111 * celery, 0);
    final EdgeInsets paddingSandstones = EdgeInsets.only(
      right: 0.011111111 * celery,
    );
    //
    if (finalAngle == 0.0) {
      now = DateTime.now();

      final int daysGoneBy = (now.difference(startDate)).inDays;

      // FIXME: calculate with floor(), because of daysGoneBy could be negative
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

      currYear = 5141 + daysGoneBy ~/ 365;
      chosenYear = currYear;

      tone = (startTone + daysGoneBy) % 13;
      sTone = tone;
      nahual = (startNahual + daysGoneBy) % 20;
      sNahual = nahual;

      currKinIndex = getKinNumber(tone, nahual);
      int trecena = currKinIndex ~/ 13;

      trecenaColor = trecena % 4;
      nTrecenaColor = trecenaColor;

      offsetGearNahuales = 18 * nahual / 180 * pi;
      offsetGearTones = 360 / 13 * tone / 180 * pi;
      offsetGearHaab = -360 / 365 * currDay / 180 * pi;

      int initialValueTrecenamask = currKinIndex % 52;
      diffAngle = initialValueTrecenamask % 13;
      trecenaOffsetAngle = 18 * initialValueTrecenamask / 180 * pi;

      currTrecenaMask = MayaImage.trecenaMask[trecenaColor];

      angleTime =
          (now.hour * 3600 + now.minute * 60 + now.second) / 864000 * pi;

      strTextToneNahual =
          '${MayaList.strTone[tone]}\n${MayaList.strNahual[nahual]}';
    }
    if (seasons.isNotEmpty) {
      DateTime nowSeasons = now.add(
        Duration(minutes: (finalAngle * 14400 / pi).toInt()),
      );
      int index = nowSeasons.year - 2001;

      List<String> strDateTimeSeasons = [
        seasons[index - 1]['winter'],
        seasons[index]['spring'],
        seasons[index]['summer'],
        seasons[index]['fall'],
        seasons[index]['winter'],
        seasons[index + 1]['spring'],
      ];

      List<DateTime> dateTimeSolsticesEquinoxes = [
        dateTimeformatSeasons.parse(strDateTimeSeasons[0]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[1]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[2]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[3]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[4]),
        dateTimeformatSeasons.parse(strDateTimeSeasons[5]),
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

      int indexMinimum = diffSeasonsAbs.indexWhere(
        (element) => element == minimum,
      );

      if (diffSeasons[indexMinimum] < 0) {
        int seasonTime = dateTimeSolsticesEquinoxes[indexMinimum + 1]
            .difference(dateTimeSolsticesEquinoxes[indexMinimum])
            .inMinutes;

        double angle = (90 / seasonTime) * -diffSeasons[indexMinimum];

        switch (indexMinimum) {
          case 0:
            // winter
            angleSeason = 270 + angle;
            iconSeason = SvgPicture.asset('assets/vector/winter_icon_dark.svg');
            break;
          case 1:
            // spring
            angleSeason = 180 + angle;
            iconSeason = SvgPicture.asset('assets/vector/spring_icon_dark.svg');
            break;
          case 2:
            // summer
            angleSeason = 90 + angle;
            iconSeason = SvgPicture.asset('assets/vector/summer_icon_dark.svg');
            break;
          case 3:
            // fall
            angleSeason = angle;
            iconSeason = SvgPicture.asset('assets/vector/fall_icon_dark.svg');
            break;
          default:
            angleSeason = 0;
            iconSeason = SvgPicture.asset('assets/vector/winter_icon_dark.svg');
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
            iconSeason = SvgPicture.asset('assets/vector/spring_icon_dark.svg');
            break;
          case 1:
            // summer
            angleSeason = 180 - angle;
            iconSeason = SvgPicture.asset('assets/vector/summer_icon_dark.svg');
            break;
          case 2:
            // fall
            angleSeason = 90 - angle;
            iconSeason = SvgPicture.asset('assets/vector/fall_icon_dark.svg');
            break;
          case 3:
            // winter
            angleSeason = -angle;
            iconSeason = SvgPicture.asset('assets/vector/winter_icon_dark.svg');
            break;
          default:
            angleSeason = 0;
            iconSeason = SvgPicture.asset('assets/vector/winter_icon_dark.svg');
        }
      }
    }

    strTextToneNahual =
        '${MayaList.strTone[sTone]}\n${MayaList.strNahual[sNahual]}';

    DateTime dateTimeMoon = now.add(
      Duration(minutes: (finalAngle * 14400 / pi).toInt()),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _customDrawer(context, size, celery),
        endDrawerEnableOpenDragGesture: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                top: posBoxTime.top,
                left: posBoxTime.left,
                child: Container(
                  height: sizeBoxTime.height,
                  width: sizeBoxTime.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(sizeBoxTime.width, sizeBoxTime.height),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/sandstone_time.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    currTime,
                    textAlign: TextAlign.center,
                    style: textStyleTime,
                  ),
                ),
              ),
              Positioned(
                top: posSandstoneFormTop.top,
                left: posSandstoneFormTop.left,
                child: Image.asset(
                  'assets/images/sandstoneForm_top.png',
                  height: sizeSandstoneFormTop.height,
                  width: sizeSandstoneFormTop.width,
                ),
              ),
              Positioned(
                top: posShapeRightTop.top,
                left: posShapeRightTop.left,
                child: Image.asset(
                  'assets/images/shape_right_top.png',
                  height: sizeShapeRightTop.height,
                  width: sizeShapeRightTop.width,
                  color: mainColor,
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              Positioned(
                top: posSandstoneFormBottom.top,
                left: posSandstoneFormBottom.left,
                child: Image.asset(
                  'assets/images/sandstoneForm_bottom.png',
                  height: sizeSandstoneFormBottom.height,
                  width: sizeSandstoneFormBottom.width,
                ),
              ),
              Positioned(
                top: posShapeRightBottom.top,
                left: posShapeRightBottom.left,
                child: Image.asset(
                  'assets/images/shape_right_bottom.png',
                  height: sizeShapeRightBottom.height,
                  width: sizeShapeRightBottom.width,
                  color: mainColor,
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              Positioned(
                top: posWheelHaab.top,
                left: posWheelHaab.left,
                child: Transform.rotate(
                  angle:
                      offsetGearHaab -
                      4 * (angleTime + finalAngle) / 73 +
                      pi / 365, // [celery] calculation correct
                  child: SizedBox(
                    height: sizeWheelHaab.height,
                    width: sizeWheelHaab.width,
                    child: Stack(
                      children: [
                        for (int i = 0; i < 18; i++)
                          Positioned(
                            top: posSectionFieldWinal.top,
                            left: posSectionFieldWinal.left,
                            child: Transform.rotate(
                              angle:
                                  4 *
                                  pi *
                                  (2 * i + 1) /
                                  73, // [celery] calculation correct
                              origin: offsetSectionFieldWinal,
                              child: SizedBox(
                                height: sizeSectionFieldWinal.height,
                                width: sizeSectionFieldWinal.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Image.asset(
                                        'assets/images/shape_section_winal.png',
                                        height: sizeSectionWinal.height,
                                        width: sizeSectionWinal.width,
                                        color: mainColor,
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                    ),
                                    for (int j = 0; j < 20; j++)
                                      Positioned(
                                        top: posImageToneWhiteFlatCenter.top,
                                        left: posImageToneWhiteFlatCenter.left,
                                        child: Transform.rotate(
                                          angle:
                                              2 *
                                              pi *
                                              (j - 10) /
                                              365, // [celery] calculation correct
                                          origin:
                                              offsetImageToneWhiteFlatCenter,
                                          child: SizedBox(
                                            width: sizeImageToneWhiteFlatCenter
                                                .width,
                                            child: MayaImage
                                                .imageToneWhiteFlatCenter[j],
                                          ),
                                        ),
                                      ),
                                    for (int j = 0; j < 20; j++)
                                      Positioned(
                                        top: posBoxTextWinal.top,
                                        left: posBoxTextWinal.left,
                                        child: Transform.rotate(
                                          angle:
                                              2 *
                                              pi *
                                              (j - 10) /
                                              365, // [celery] calculation correct
                                          origin: offsetBoxTextWinal,
                                          child: RotatedBox(
                                            quarterTurns: -1,
                                            child: SizedBox(
                                              height: sizeBoxTextWinal.height,
                                              width: sizeBoxTextWinal.width,
                                              child: Center(
                                                child: Text(
                                                  MayaList.strWinal[i],
                                                  style: textStyleStrWinal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: posSectionFieldWinalWayeb.top,
                          left: posSectionFieldWinalWayeb.left,
                          child: Transform.rotate(
                            angle:
                                145 * pi / 73, // [celery] calculation correct
                            origin: offsetSectionFieldWinalWayeb,
                            child: SizedBox(
                              height: sizeSectionFieldWinalWayeb.height,
                              width: sizeSectionFieldWinalWayeb.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Image.asset(
                                      'assets/images/shape_section_winal_wayeb.png',
                                      height: sizeSectionWinalWayeb.height,
                                      width: sizeSectionWinalWayeb.width,
                                      color: mainColor,
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                  for (int i = 0; i < 5; i++)
                                    Positioned(
                                      top: posImageToneWhiteFlatCenterWayeb.top,
                                      left:
                                          posImageToneWhiteFlatCenterWayeb.left,
                                      child: Transform.rotate(
                                        angle:
                                            pi *
                                            (2 * i - 5) /
                                            365, // [celery] calculation correct
                                        origin:
                                            offsetImageToneWhiteFlatCenterWayeb,
                                        child: SizedBox(
                                          width:
                                              sizeImageToneWhiteFlatCenterWayeb
                                                  .width,
                                          child: MayaImage
                                              .imageToneWhiteFlatCenter[i],
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    top: posImageToneWhiteFlatCenterWayeb.top,
                                    left: posImageToneWhiteFlatCenterWayeb.left,
                                    child: Transform.rotate(
                                      angle:
                                          pi /
                                          73, // [celery] calculation correct
                                      origin:
                                          offsetImageToneWhiteFlatCenterWayeb,
                                      child: SizedBox(
                                        width: sizeImageToneWhiteFlatCenterWayeb
                                            .width,
                                        child: MayaImage
                                            .imageToneWhiteFlatCenter[0],
                                      ),
                                    ),
                                  ),
                                  for (int i = 0; i < 5; i++)
                                    Positioned(
                                      top: posBoxTextWinalWayeb.top,
                                      left: posBoxTextWinalWayeb.left,
                                      child: Transform.rotate(
                                        angle:
                                            pi *
                                            (2 * i - 5) /
                                            365, // [celery] calculation correct
                                        origin: offsetBoxTextWinalWayeb,
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: SizedBox(
                                            height:
                                                sizeBoxTextWinalWayeb.height,
                                            width: sizeBoxTextWinalWayeb.width,
                                            child: Center(
                                              child: Text(
                                                MayaList.strWinal[18],
                                                style: textStyleStrWinal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    top: posBoxTextWinalWayeb.top,
                                    left: posBoxTextWinalWayeb.left,
                                    child: Transform.rotate(
                                      angle:
                                          pi /
                                          73, // [celery] calculation correct
                                      origin: offsetBoxTextWinalWayeb,
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: SizedBox(
                                          height: sizeBoxTextWinalWayeb.height,
                                          width: sizeBoxTextWinalWayeb.width,
                                          child: Center(
                                            child: Text(
                                              MayaList.strWinal[0],
                                              style: textStyleStrWinal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: posWheelHaab.top,
                left: posWheelHaab.left,
                child: Transform.rotate(
                  angle:
                      offsetGearHaab -
                      4 * (angleTime + finalAngle) / 73 +
                      pi / 365, // [celery] calculation correct
                  child: SizedBox(
                    height: sizeWheelHaab.height,
                    width: sizeWheelHaab.width,
                    child: Consumer<MayaData>(
                      builder: (context, data, child) {
                        return Stack(
                          children: [
                            for (int i = -20; i < 21; i++)
                              if (indicator(i, data.mayaData))
                                Positioned(
                                  top: posFrame.top,
                                  left: posFrame.left,
                                  child: Transform.rotate(
                                    angle:
                                        360 /
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
                                          32,
                                          255,
                                          255,
                                          255,
                                        ),
                                        // FIXME: calculate with celery (border width, border radius).
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: posSandstoneMoon.top,
                left: posSandstoneMoon.left,
                child: Image.asset(
                  "assets/images/sandstoneMoon.png",
                  height: sizeSandstoneMoon.height,
                  width: sizeSandstoneMoon.width,
                ),
              ),
              Positioned(
                top: posWheelNahuales.top,
                left: posWheelNahuales.left,
                child: Transform.rotate(
                  angle: offsetGearNahuales + angleTime + finalAngle,
                  child: Image.asset(
                    'assets/images/gearNahuales.png',
                    height: sizeWheelNahuales.height,
                    width: sizeWheelNahuales.width,
                    color: mainColor,
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ),
              Positioned(
                top: posWheelNahuales.top,
                left: posWheelNahuales.left,
                child: Transform.rotate(
                  angle:
                      (trecenaOffsetAngle +
                      dTrecenaAngle +
                      angleTime +
                      finalAngle),
                  child: SizedBox(
                    height: sizeWheelNahuales.height,
                    width: sizeWheelNahuales.width,
                    child: currTrecenaMask,
                  ),
                ),
              ),
              Positioned(
                top: posWheelNahuales.top,
                left: posWheelNahuales.left,
                child: SizedBox(
                  height: sizeWheelNahuales.height,
                  width: sizeWheelNahuales.width,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      Offset centerOfGestureDetector = Offset(
                        constraints.maxWidth / 2,
                        constraints.maxHeight / 2,
                      );
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onPanStart: (details) {
                          final touchPositionFromCenter =
                              details.localPosition - centerOfGestureDetector;
                          upsetAngle =
                              oldAngle - touchPositionFromCenter.direction;
                        },
                        onPanUpdate: (details) {
                          final touchPositionFromCenter =
                              details.localPosition - centerOfGestureDetector;
                          setState(() {
                            prevAngle = finalAngle;

                            finalAngle =
                                touchPositionFromCenter.direction + upsetAngle;

                            finalAngle = (finalAngle + 2 * pi) % (2 * pi);

                            if (finalAngle + mAngle - prevAngle < -1.5 * pi) {
                              iRounds++;
                              mAngle = 2 * pi * iRounds;
                            }

                            if (finalAngle + mAngle - prevAngle > 1.5 * pi) {
                              mAngle = 2 * pi * iRounds - 2 * pi;
                              iRounds--;
                            }

                            finalAngle = finalAngle + mAngle;

                            double angle =
                                offsetGearHaab -
                                (angleTime + finalAngle) * 20 / 365;

                            // get chosenDayTotal, chosenDay
                            int chosenDayTotal = (-angle * 180 / pi * 365 / 360)
                                .floor();
                            chosenDay = chosenDayTotal % 365;

                            // get chosenYear, chosenHaabYear
                            chosenYear =
                                currYear + (-angle * 180 / pi / 360).floor();

                            if (chosenDayTotal % 10 == 0) {
                              xDayTotal = chosenDayTotal;
                            }

                            // increase Tone Name, Nahual Name and the Long Count
                            if ((angleTime + finalAngle) * 180 / pi >
                                18 * nAngle + 18) {
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
                                  '${MayaList.strTone[sTone]}\n${MayaList.strNahual[sNahual]}';

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
                            if ((angleTime + finalAngle) * 180 / pi <
                                18 * nAngle) {
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
                                  '${MayaList.strTone[sTone]}\n${MayaList.strNahual[sNahual]}';

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
                              currTrecenaMask =
                                  MayaImage.trecenaMask[nTrecenaColor];
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
                              currTrecenaMask =
                                  MayaImage.trecenaMask[nTrecenaColor];
                              iTrecena--;
                            }
                          });
                        },
                        onPanEnd: (details) {
                          oldAngle = finalAngle;
                        },
                        child: Transform.rotate(
                          angle: offsetGearNahuales + angleTime + finalAngle,
                          child: Stack(
                            children: [
                              for (int i = 0; i < 20; i++)
                                Align(
                                  alignment: const Alignment(0.904, 0),
                                  child: Transform.rotate(
                                    origin: offsetSignNahual,
                                    angle:
                                        pi *
                                        (-2 * i - 1) /
                                        20, // [celery] calculation correct
                                    child: SizedBox(
                                      height: sizeSignNahual.height,
                                      width: sizeSignNahual.width,
                                      child: MayaImage.signNahual[i],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: posButtonReset.top,
                left: posButtonReset.left,
                child: GestureDetector(
                  onTap: () {
                    reset();
                  },
                  child: Image.asset(
                    "assets/images/shape_button_moon.png",
                    height: sizeButtonReset.height,
                    width: sizeButtonReset.width,
                    color: mainColor,
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ),
              Positioned(
                top: posWheelTones.top,
                left: posWheelTones.left,
                child: Transform.rotate(
                  angle: offsetGearTones + (angleTime + finalAngle) / 13 * 20,
                  child: SizedBox(
                    height: sizeWheelTones.height,
                    width: sizeWheelTones.width,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/gearTones.png',
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Stack(
                          children: [
                            for (int i = 0; i < 13; i++)
                              Align(
                                alignment: const Alignment(0.9, 0),
                                child: Transform.rotate(
                                  origin: offsetSignTone,
                                  angle:
                                      -2 /
                                          13 * // -360 / 13 / 180 = -2 / 13
                                          pi *
                                          i -
                                      1 / 13 * pi,
                                  child: SizedBox(
                                    height: sizeSignTone.height,
                                    width: sizeSignTone.width,
                                    child: MayaImage.imageToneWhiteVertical[i],
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
                    crossAxisSpacing: crossAxisSpacingBoxSolsticesEquinoxes,
                    crossAxisCount: 3,
                    children: <Widget>[
                      // TODO: check what the 'SizedBox'es are for!
                      SizedBox(),
                      SvgPicture.asset("assets/vector/winter_icon.svg"),
                      SizedBox(),
                      SvgPicture.asset("assets/vector/spring_icon.svg"),
                      SizedBox(),
                      SvgPicture.asset("assets/vector/fall_icon.svg"),
                      SizedBox(),
                      SvgPicture.asset("assets/vector/summer_icon.svg"),
                      SizedBox(),
                    ],
                  ),
                ),
              ),
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
                      child: iconSeason,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: posMoon.top + sizeMoon / 4,
                left: posMoon.left + sizeMoon / 4,
                child: MoonWidget(
                  date: dateTimeMoon,
                  resolution: sizeMoon,
                  size: sizeMoon,
                  moonColor: Color.fromARGB(255, 215, 215, 215),
                  earthshineColor: Color.lerp(mainColor, Colors.black, 0.32)!,
                ),
              ),
              Positioned(
                top: posMoon.top,
                left: posMoon.left,
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/moon_pattern.png',
                    height: sizeMoon,
                    width: sizeMoon,
                    colorBlendMode: BlendMode.modulate,
                    color: Color.lerp(mainColor, Colors.black, 0.52)!,
                  ),
                ),
              ),
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
                          mainColor: mainColor,
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    int character = Random().nextInt(260);

                    List<int> toneNahual = getToneNahual(character + 150 % 260);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, _) =>
                            RandomCharacter(
                              backgroundImage: backgroundImage,
                              tone: toneNahual[0],
                              nahual: toneNahual[1],
                            ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/shape_button_left_top.png',
                    height: sizeButtonRelationship.height,
                    width: sizeButtonRelationship.width,
                    color: mainColor,
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ),
              Positioned(
                top: posButtonTheYear.top,
                left: posButtonTheYear.left,
                child: GestureDetector(
                  onTap: () {
                    int beginTone =
                        (startTone + 365 * (chosenYear - 5141)) % 13;
                    int beginNahual =
                        (startNahual + 365 * (chosenYear - 5141)) % 20;
                    int beginKinIndex =
                        (startKinIndex + 365 * (chosenYear - 5141)) % 260;

                    int cBaktun =
                        13 + (365 * (chosenYear - 5141) + dDays) ~/ 144000 % 14;
                    int cKatun =
                        (365 * (chosenYear - 5141) + dDays) ~/ 7200 % 20;
                    int cTun =
                        (365 * (chosenYear - 5141) + dDays - cKatun * 7200) ~/
                        360 %
                        20;
                    int cWinal =
                        (365 * (chosenYear - 5141) +
                            dDays -
                            cKatun * 7200 -
                            cTun * 360) ~/
                        20 %
                        18;
                    int cKin =
                        (365 * (chosenYear - 5141) +
                            dDays -
                            cKatun * 7200 -
                            cTun * 360 -
                            cWinal * 20) %
                        20;

                    DateTime chosenBeginGregorianDate = startDate.add(
                      Duration(days: 365 * (chosenYear - 5141)),
                    );

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
                          beginLongCount: [cBaktun, cKatun, cTun, cWinal, cKin],
                          chosenBeginGregorianDate: chosenBeginGregorianDate,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: sizeButtonTheYear.height,
                    width: sizeButtonTheYear.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
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
                          mainColor: mainColor,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/shape_button_left_bottom.png',
                    height: sizeButtonDateCalculator.height,
                    width: sizeButtonDateCalculator.width,
                    color: mainColor,
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ),
              Positioned(
                top: posButtonCholqij.top,
                left: posButtonCholqij.left,
                child: GestureDetector(
                  onTap: () {
                    int sTone = getTone(
                      ((offsetGearTones + (angleTime + finalAngle) / 13 * 20) *
                              180 /
                              pi) %
                          360,
                    ); // [celery] calculation correct
                    int sNahual = getNahual(
                      ((offsetGearNahuales + angleTime + finalAngle) *
                              180 /
                              pi) %
                          360,
                    ); // [celery] calculation correct
                    int cKinIndex = getKinNumber(sTone, sNahual);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cholqij(
                          backgroundImage: backgroundImage,
                          mainColor: mainColor,
                          cKinIndex: cKinIndex,
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    int chosenTone = getTone(
                      ((offsetGearTones + (angleTime + finalAngle) / 13 * 20) *
                              180 /
                              pi) %
                          360,
                    ); // [celery] calculation correct

                    int chosenNahual = getNahual(
                      ((offsetGearNahuales + angleTime + finalAngle) *
                              180 /
                              pi) %
                          360,
                    ); // [celery] calculation correct

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, _) =>
                            CharacterChoice(
                              backgroundImage: backgroundImage,
                              mainColor: mainColor,
                              chosenTone: chosenTone,
                              chosenNahual: chosenNahual,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    height: sizeButtonCholqij.height,
                    width: sizeButtonCholqij.width,
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
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
                            (startTone + 365 * (chosenYear - 5141)) % 13;
                        int beginNahual =
                            (startNahual + 365 * (chosenYear - 5141)) % 20;

                        int chosenTone = getTone(
                          ((offsetGearTones +
                                      (angleTime + finalAngle) / 13 * 20) *
                                  180 /
                                  pi) %
                              360,
                        ); // [celery] calculation correct

                        int chosenNahual = getNahual(
                          ((offsetGearNahuales + angleTime + finalAngle) *
                                  180 /
                                  pi) %
                              360,
                        ); // [celery] calculation correct

                        int dYear = getDeltaYear(
                          (-offsetGearHaab * 9 / pi +
                                  ((angleTime + finalAngle) * 180 / pi) / 365) *
                              20,
                        ); // [celery] calculation correct

                        DateTime chosenGregorianDate = startDate.add(
                          Duration(
                            days: 365 * (currYear - 5141 + dYear) + chosenDay,
                          ),
                        );

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
                                sKin,
                              ],
                              chosenGregorianDate: chosenGregorianDate,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        int beginTone =
                            (startTone + 365 * (chosenYear - 5141)) % 13;
                        int beginNahual =
                            (startNahual + 365 * (chosenYear - 5141)) % 20;

                        int chosenTone = getTone(
                          ((offsetGearTones +
                                      (angleTime + finalAngle) / 13 * 20) *
                                  180 /
                                  pi) %
                              360,
                        ); // [celery] calculation correct

                        int chosenNahual = getNahual(
                          ((offsetGearNahuales + angleTime + finalAngle) *
                                  180 /
                                  pi) %
                              360,
                        ); // [celery] calculation correct

                        int dYear = getDeltaYear(
                          (-offsetGearHaab * 9 / pi +
                                  ((angleTime + finalAngle) * 180 / pi) / 365) *
                              20,
                        ); // [celery] calculation correct

                        DateTime chosenGregorianDate = startDate.add(
                          Duration(
                            days: 365 * (currYear - 5141 + dYear) + chosenDay,
                          ),
                        );

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, _) =>
                                DateSelection(
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
                                    sKin,
                                  ],
                                  chosenGregorianDate: chosenGregorianDate,
                                ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Text(
                            strTextToneNahual,
                            textAlign: TextAlign.center,
                            style: textStyleToneNahualStroke,
                          ),
                          Text(
                            strTextToneNahual,
                            textAlign: TextAlign.center,
                            style: textStyleToneNahualText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: posBoxLongCount.top - navigationBarHeight,
                    left: posBoxLongCount.left,
                    child: SizedBox(
                      height: sizeBoxLongCount.height,
                      width: sizeBoxLongCount.width,
                      child: Row(
                        children: [
                          Padding(
                            padding: paddingSandstones,
                            child: tunContainer(
                              sizeSandstones,
                              sizeNumbers,
                              celery,
                              sBaktun,
                            ),
                          ),
                          Padding(
                            padding: paddingSandstones,
                            child: tunContainer(
                              sizeSandstones,
                              sizeNumbers,
                              celery,
                              sKatun,
                            ),
                          ),
                          Padding(
                            padding: paddingSandstones,
                            child: tunContainer(
                              sizeSandstones,
                              sizeNumbers,
                              celery,
                              sTun,
                            ),
                          ),
                          Padding(
                            padding: paddingSandstones,
                            child: tunContainer(
                              sizeSandstones,
                              sizeNumbers,
                              celery,
                              sWinal,
                            ),
                          ),
                          tunContainer(
                            sizeSandstones,
                            sizeNumbers,
                            celery,
                            sKin,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            color: mainColor.withValues(alpha: 0.5),
                            border: Border.all(
                              width: borderWidthSettings,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(borderRadiusSettings),
                              bottomLeft: Radius.circular(borderRadiusSettings),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*                                                                          */
  /* Build - END                                                              */
  /* ------------------------------------------------------------------------ */

  void showBackupOptions(BuildContext context, Color mainColor) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.download, color: Colors.white),
                title: const Text('Save to Downloads (Local)'),
                tileColor: mainColor,
                textColor: Colors.white,
                onTap: () async {
                  Navigator.pop(context);
                  await saveBackupToDownloads();
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.white),
                title: const Text('Share / Cloud Backup'),
                tileColor: mainColor,
                textColor: Colors.white,
                onTap: () async {
                  Navigator.pop(context);
                  await backupDatabases(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  debugPrint('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    debugPrint('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    debugPrint(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}

Future<void> checkAndroidNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    debugPrint('Requesting notification permission...');
    final res = await Permission.notification.request();
    debugPrint(
      'Notification permission ${res.isGranted ? '' : 'not '}granted.',
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> _launchPrivacyPolicy() async {
  final Uri urlPrivacyPolicy = Uri.parse(
    'https://sites.google.com/view/privacy-policy-of-maya',
  );
  if (!await launchUrl(urlPrivacyPolicy)) {
    throw Exception('Could not launch $urlPrivacyPolicy');
  }
}

Future<void> _launchGitLab() async {
  final Uri urlGitLab = Uri.parse('https://gitlab.com/morgenfrost/maya');
  if (!await launchUrl(urlGitLab)) {
    throw Exception('Could not launch $urlGitLab');
  }
}
