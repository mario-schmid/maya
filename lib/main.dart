import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maya/data/event.dart';
import 'package:maya/data/task.dart';
import 'package:maya/helper/images.dart';
import 'package:maya/helper/lists.dart';
import 'package:maya/methods/get_delda_year.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:maya/providers/ischecked.dart';
import 'package:maya/providers/yeardata.dart';
import 'package:maya/relationship.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cholqij.dart';
import 'classes/position.dart';
import 'color_picker.dart';
import 'data/day.dart';
import 'database_handler.dart';
import 'date_calculator.dart';
import 'globals.dart';
import 'helper/locale_string.dart';
import 'items.dart';
import 'methods/get_haab_date.dart';
import 'methods/get_kin_nummber.dart';
import 'methods/get_nahual.dart';
import 'methods/get_tone.dart';
import 'the_day.dart';
import 'the_year.dart';
import 'time_format.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MayaApp());
}

class MayaApp extends StatelessWidget {
  const MayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DayItems()),
          ChangeNotifierProvider(create: (context) => IsChecked()),
          ChangeNotifierProvider(create: (context) => YearData())
        ],
        child: GetMaterialApp(
            navigatorKey: navigatorKey,
            translations: LocaleString(),
            locale: const Locale('en', 'GB'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Roboto'),
            home: const Home()));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  /* ------------------------------------------------------------------------ */
  /* Assets for precacheImage                                                 */
  /*                                                                          */
  final List<String> assets = [
    'assets/images/shape_button_left_bottom.png',
    'assets/images/shape_button_left_top.png',
    'assets/images/shape_right_bottom.png',
    'assets/images/shape_right_top.png',
    'assets/images/shape_button_moon.png',
    'assets/images/gearNahuales.png',
    'assets/images/gearTones.png',
    'assets/images/leaves.jpg',
    'assets/images/sandstone.png',
    'assets/images/sandstoneCircle.png',
    'assets/images/sandstoneForm_bottom.png',
    'assets/images/sandstoneForm_top.png',
    'assets/images/sandstoneMoon.png',
    'assets/images/shape_section_winal_wayeb.png',
    'assets/images/shape_section_winal.png',
    'assets/images/trecenaBlue.png',
    'assets/images/trecenaRed.png',
    'assets/images/trecenaWhite.png',
    'assets/images/trecenaYellow.png',
    //
    'assets/images/icons/hunabku.png',
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
    'assets/images/grey.png',
    'assets/images/grey_small.png',
    //
    'assets/images/cholqij_field_red.jpg',
    'assets/images/cholqij_field_white.jpg',
    'assets/images/cholqij_field_blue.jpg',
    'assets/images/cholqij_field_yellow.jpg'
  ];
  /*                                                                          */
  /* Assets for precacheImage - END                                           */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* Positions and Sizes                                             */
  /*                                                                          */
  late Size sizeBoxTime;
  late Position posBoxTime;
  //
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
  late Size sizeWheelNahuales; // 393.333
  late Position posWheelNahuales;
  //
  late Size sizeSignNahual;
  late Offset offsetSignNahual;
  //
  late Size sizeWheelHaab; // 6661.333
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
  late Size sizeSignTone;
  late Offset offsetSignTone;
  //
  late Size sizeSandstoneCircle;
  late Position posSandstoneCircle;
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
  /* Positions and Sizes - END                                       */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* Varibles                                                                 */
  /*                                                                          */
  DateTime now = DateTime.now();

  final Future<Iterable<List<Object?>>> _eventList =
      DatabaseHandlerEvents().retrieveEvents();
  final Future<Iterable<List<Object?>>> _noteList =
      DatabaseHandlerNotes().retrieveNotes();
  final Future<Iterable<List<Object?>>> _taskList =
      DatabaseHandlerTasks().retrieveTasks();
  final Future<Iterable<List<Object?>>> _arrangementList =
      DatabaseHandlerArrangements().retrieveArrangements();

  List<List<dynamic>> eList = [];
  List<List<dynamic>> nList = [];
  List<List<dynamic>> tList = [];
  List<List<dynamic>> aList = [];

  late DateTime startDate;
  String currTime = '';

  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;
  double prevAngle = 0.0;

  double mAngle = 0.0;
  double iRounds = 0.0;
  int nAngle = 0;

  late int baktun, cBaktun;
  late int katun, cKatun;
  late int tun, cTun;
  late int winal, cWinal;
  late int kin, cKin;

  late int currDay;
  late int chosenDay;
  late int xDayTotal;

  late int currYear;
  late int chosenYear;
  late int currHaabYear;
  late int chosenHaabYear;
  int nYear = 1;

  late int tone;
  late int cTone;

  late int nahual;
  late int cNahual;

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

  final List<Image> imageToneWhiteFlatCenter = [
    Image.asset('assets/images/tones/00_white_center.png'),
    Image.asset('assets/images/tones/01_white_flat_center.png'),
    Image.asset('assets/images/tones/02_white_flat_center.png'),
    Image.asset('assets/images/tones/03_white_flat_center.png'),
    Image.asset('assets/images/tones/04_white_flat_center.png'),
    Image.asset('assets/images/tones/05_white_flat_center.png'),
    Image.asset('assets/images/tones/06_white_flat_center.png'),
    Image.asset('assets/images/tones/07_white_flat_center.png'),
    Image.asset('assets/images/tones/08_white_flat_center.png'),
    Image.asset('assets/images/tones/09_white_flat_center.png'),
    Image.asset('assets/images/tones/10_white_flat_center.png'),
    Image.asset('assets/images/tones/11_white_flat_center.png'),
    Image.asset('assets/images/tones/12_white_flat_center.png'),
    Image.asset('assets/images/tones/13_white_flat_center.png'),
    Image.asset('assets/images/tones/14_white_flat_center.png'),
    Image.asset('assets/images/tones/15_white_flat_center.png'),
    Image.asset('assets/images/tones/16_white_flat_center.png'),
    Image.asset('assets/images/tones/17_white_flat_center.png'),
    Image.asset('assets/images/tones/18_white_flat_center.png'),
    Image.asset('assets/images/tones/19_white_flat_center.png')
  ];

  final List<Image> trecenaMask = [
    Image.asset('assets/images/trecenaRed.png'),
    Image.asset('assets/images/trecenaWhite.png'),
    Image.asset('assets/images/trecenaBlue.png'),
    Image.asset('assets/images/trecenaYellow.png')
  ];

  final Uri githubURL = Uri.parse('https://github.com/mario-schmid/maya');

  late AnimationController _controller;
  late Animation<double> _animation;
  /*                                                                          */
  /* Varibles - END                                                           */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* initState                                                                */
  /*                                                                          */
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controller.addListener(() {
      setState(() {
        finalAngle = _animation.value;
        oldAngle = _animation.value;
      });
    });

    loadTimeFormat();
    loadLanguage();
    loadMainColor();
    loadBgFilePath();

    Future.delayed(
        Duration(
            milliseconds: 85320000 - now.millisecondsSinceEpoch % 86400000),
        () {
      scheduletask();
      Timer.periodic(const Duration(days: 1), (Timer timer) {
        scheduletask();
      });
    });

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final DateTime now = DateTime.now();
      setState(() {
        //currTime = ("${now.hour}:${now.minute}:${now.second}");
        currTime = TimeFormat().getTimeFormat.format(now);
      });
    });

    startDate = DateTime.parse('2013-02-21 00:00:00');

    final int daysGoneBy =
        (now.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch) ~/
            86400000;

    const int dDays = 62;
    baktun = 13; // TODO baktum?
    katun = (daysGoneBy + dDays) ~/ 7200;
    tun = (daysGoneBy + dDays - katun * 7200) ~/ 360;
    winal = (daysGoneBy + dDays - katun * 7200 - tun * 360) ~/ 20;
    kin = daysGoneBy + dDays - katun * 7200 - tun * 360 - winal * 20;

    cBaktun = baktun;
    cKatun = katun;
    cTun = tun;
    cWinal = winal;
    cKin = kin;

    currDay = daysGoneBy % 365;
    chosenDay = currDay;
    xDayTotal = currDay;

    currYear = daysGoneBy ~/ 365;
    chosenYear = currYear;
    currHaabYear = currYear + 5129;
    chosenHaabYear = currHaabYear;

    for (int i = 0; i <= currYear + 1; i++) {
      YearData().yearData.add(List.generate(365, (index) => Day()));
      IsChecked()
          .isChecked
          .add(List.generate(365, (index) => List.empty(growable: true)));
      DayItems().dayItems.add(List.generate(
          365, (index) => List<Dismissible>.empty(growable: true)));
      arrayIndex.add(List.generate(
          365,
          (index) =>
              List.generate(5, (index) => List<int>.empty(growable: true))));
    }
    loadData();

    tone = (startTone + daysGoneBy) % 13;
    cTone = tone;

    nahual = (startNahual + daysGoneBy) % 20;
    cNahual = nahual;

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

    strTextToneNahual = '${strTone[tone]}\n${strNahual[nahual]}';

    super.initState();
  }
  /*                                                                          */
  /* initState - END                                                          */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* didChangeDependencies - precacheImage                                    */
  /*                                                                          */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var asset in assets) {
      precacheImage(AssetImage(asset), context);
    }
  }
  /*                                                                          */
  /* didChangeDependencies - precacheImage - END                              */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* loadData                                                                 */
  /*                                                                          */
  loadData() async {
    eList = (await _eventList).toList();
    nList = (await _noteList).toList();
    tList = (await _taskList).toList();
    aList = (await _arrangementList).toList();

    for (int i = 0; i < eList.length; i++) {
      YearData()
          .yearData[eList[i][0]][eList[i][1]]
          .eventList
          .add(Event([eList[i][3], eList[i][4], eList[i][5], eList[i][6]]));
    }
    for (int i = 0; i < nList.length; i++) {
      YearData().yearData[nList[i][0]][nList[i][1]].noteList.add(nList[i][3]);
    }
    for (int i = 0; i < tList.length; i++) {
      YearData()
          .yearData[tList[i][0]][tList[i][1]]
          .taskList
          .add(Task(tList[i][3], tList[i][4] == 0 ? false : true));

      IsChecked()
          .isChecked[tList[i][0]][tList[i][1]]
          .add(tList[i][4] == 0 ? false : true);
    }

    for (int i = 0; i < aList.length; i++) {
      int l = 0;
      int m = 0;
      int n = 0;
      String removedBrackets = aList[i][2].substring(1, aList[i][2].length - 1);
      List<String> strArrangements = removedBrackets.split(',');
      List<int> arrangements =
          strArrangements.map((data) => int.parse(data)).toList();
      for (int j = 0; j < arrangements.length; j++) {
        if (arrangements[j] == 0) {
          DayItems().dayItems[aList[i][0]][aList[i][1]].add(eventItem(
              aList[i][0],
              aList[i][1],
              eList[l][3],
              eList[l][4],
              eList[l][5],
              eList[l][6],
              false,
              l));
          l++;
        }
        if (arrangements[j] == 1) {
          DayItems()
              .dayItems[aList[i][0]][aList[i][1]]
              .add(noteItem(aList[i][0], aList[i][1], nList[m][3], false, m));
          m++;
        }
        if (arrangements[j] == 2) {
          DayItems().dayItems[aList[i][0]][aList[i][1]].add(taskItem(
              aList[i][0],
              aList[i][1],
              tList[n][3],
              tList[n][4] == 0 ? false : true,
              false,
              n));
          n++;
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
  /* loadMainColor                                                           */
  /*                                                                          */
  loadMainColor() async {
    Future<Object> mainColorFuture = readMainColor();
    String strMainColor = (await mainColorFuture).toString();
    mainColor = Color(int.parse(strMainColor));
  }
  /*                                                                          */
  /* loadMainColor - END                                                      */
  /* ------------------------------------------------------------------------ */

  late String? bgFilePath;
  ImageProvider backgroundImage = const AssetImage('assets/images/leaves.jpg');

  /* ------------------------------------------------------------------------ */
  /* loadBgFilePath                                                           */
  /*                                                                          */
  loadBgFilePath() async {
    backgroundImage = await readBgFilePath();
  }
  /*                                                                          */
  /* loadBgFilePath - END                                                      */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* scheduletask                                                             */
  /*                                                                          */
  scheduletask() {
    setState(() {
      currDay++;
      if (currDay > 364) {
        currDay = 0;
        currYear++;
      }
      chosenDay++;
      if (chosenDay > 364) {
        chosenDay = 0;
        chosenYear++;
        chosenHaabYear++;
      }
      xDayTotal = chosenDay; // TODO: check if correct!

      now = now.add(const Duration(days: 1));
      offsetGearNahuales += 1 / 10 * pi;
      trecenaOffsetAngle += 1 / 10 * pi;
      offsetGearTones += 2 / 13 * pi;
      offsetGearHaab -= 2 / 365 * pi;
      tone++;
      if (tone > 12) {
        tone = 0;
      }
      cTone++;
      if (cTone > 12) {
        cTone = 0;
      }
      nahual++;
      if (nahual > 19) {
        nahual = 0;
      }
      cNahual++;
      if (cNahual > 19) {
        cNahual = 0;
      }

      strTextToneNahual = '${strTone[cTone]}\n${strNahual[cNahual]}';

      kin++;
      if (kin > 19) {
        kin = 0;
        winal++;
        if (winal > 17) {
          winal = 0;
          tun++;
          if (tun > 19) {
            tun = 0;
            katun++;
            if (katun > 19) {
              katun = 0;
            }
          }
        }
      }

      cKin++;
      if (cKin > 19) {
        cKin = 0;
        cWinal++;
        if (cWinal > 17) {
          cWinal = 0;
          cTun++;
          if (cTun > 19) {
            cTun = 0;
            cKatun++;
            if (cKatun > 19) {
              cKatun = 0;
            }
          }
        }
      }
    });
  }
  /*                                                                          */
  /* scheduletask - END                                                       */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* reset                                                                    */
  /*                                                                          */
  reset() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
      }
      upsetAngle = 0.0;
      finalAngle = 0.0;
      oldAngle = 0.0;
      //prevAngle = 0.0;

      iRounds = 0;
      mAngle = 0.0;

      nTrecenaColor = trecenaColor;
      nTrecenaAngle = 0;
      dTrecenaAngle = 0.0;
      iTrecena = 1;

      currTrecenaMask = trecenaMask[trecenaColor];

      cTone = tone;
      cNahual = nahual;
      nAngle = 0;

      strTextToneNahual = '${strTone[tone]}\n${strNahual[nahual]}';

      baktun = cBaktun;
      katun = cKatun;
      tun = cTun;
      winal = cWinal;
      kin = cKin;

      nYear = 1;
      chosenDay = currDay;
      xDayTotal = currDay;
      chosenYear = currYear;
      chosenHaabYear = currHaabYear;
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
                      padding: EdgeInsets.all(size.width * 0.03),
                      child: Image(
                          image: const AssetImage(
                              "assets/images/icons/hunabku.png"),
                          height: size.width * 0.34,
                          width: size.width * 0.34))),
              Divider(
                  color: Colors.white,
                  height: 0,
                  thickness: size.width * 0.003,
                  indent: 0,
                  endIndent: 0),
              SizedBox(height: size.width * 0.03),
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
                GestureDetector(
                    onTap: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      mainColor = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ColorPicker(mainColor: mainColor);
                          });
                    },
                    onLongPress: () {
                      mainColor = const Color(0xff0000ff);
                      deleteMainColor();
                    },
                    child: Container(
                      height: size.width * 0.1,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.5),
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.01),
                          shape: BoxShape.rectangle),
                      child: SvgPicture.asset(
                          "assets/vector_graphics/rby_icon.svg"),
                    )),
                SizedBox(width: size.width * 0.06),
                GestureDetector(
                    onTap: () async {
                      const params = OpenFileDialogParams(
                        dialogType: OpenFileDialogType.image,
                        sourceType: SourceType.photoLibrary,
                      );
                      bgFilePath =
                          await FlutterFileDialog.pickFile(params: params);
                      saveBgFilePath(bgFilePath);
                      backgroundImage = FileImage(File(bgFilePath!));
                    },
                    onLongPress: () {
                      backgroundImage =
                          const AssetImage('assets/images/leaves.jpg');
                      deleteBgImagePath();
                    },
                    child: Container(
                      height: size.width * 0.1,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.5),
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.01),
                          shape: BoxShape.rectangle),
                      child: SvgPicture.asset(
                          "assets/vector_graphics/image_icon.svg"),
                    ))
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
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                shape: MaterialStateProperty.all<
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
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                const MaterialStatePropertyAll(Colors.red),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.014)))),
                    ))
              ])
            ])));
  }
  /*                                                                          */
  /* Drawer - END                                                             */
  /* ------------------------------------------------------------------------ */

  /* ------------------------------------------------------------------------ */
  /* Build                                                                    */
  /*                                                                          */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.height / size.width >= 692 / 360) {
      //
      sizeBoxTime = Size(size.width * 0.555555556, size.width * 0.088888889);
      posBoxTime = Position(size.width * 0.111111111,
          size.width - sizeBoxTime.width - size.width * 0.280555556);
      //
      textStyleTime = TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.066666667,
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
      posWheelNahuales = Position(
          (size.height - sizeWheelNahuales.height) / 2,
          size.width -
              sizeWheelNahuales.width -
              size.width * 0.113888889); // -41
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
      sizeSandstoneCircle =
          Size(size.width * 0.269727778, size.width * 0.269727778);
      posSandstoneCircle = Position(
          (size.height - size.width * 0.269727778) / 2,
          size.width - sizeSandstoneCircle.width - size.width * 0.391062037);
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
      texttextStyleToneNahual =
          TextStyle(color: Colors.white, fontSize: size.width * 0.05);
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
      sizeBoxTime = Size(size.height * 0.289017341, size.height * 0.046242775);
      posBoxTime = Position(size.height * 0.057803468,
          size.width - sizeBoxTime.width - size.height * 0.145953757);
      //
      textStyleTime = TextStyle(
          color: Colors.white,
          fontSize: size.height * 0.034682081,
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
      sizeSandstoneCircle =
          Size(size.height * 0.140320809, size.height * 0.140320809);
      posSandstoneCircle = Position(
          (size.height - sizeSandstoneCircle.height) / 2,
          size.width - sizeSandstoneCircle.width - size.height * 0.203442678);
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
      texttextStyleToneNahual =
          TextStyle(color: Colors.white, fontSize: size.height * 0.026011561);
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
    return Scaffold(
        endDrawer: _customDrawer(context, size),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
            child: Stack(children: [
              Positioned(
                  top: posBoxTime.top,
                  left: posBoxTime.left,
                  child: SizedBox(
                      height: sizeBoxTime.height,
                      width: sizeBoxTime.width,
                      child: Text(currTime,
                          textAlign: TextAlign.center, style: textStyleTime))),
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
                          finalAngle /
                              9 *
                              pi /
                              365, // offsetGearHaab - finalAngle / 180 * pi / 365 * 20
                      child: SizedBox(
                          height: sizeWheelHaab.height,
                          width: sizeWheelHaab.width,
                          child: Stack(children: [
                            for (int i = 0; i < 18; i++)
                              Positioned(
                                  top: posSectionFieldWinal.top,
                                  left: posSectionFieldWinal.left,
                                  child: Transform.rotate(
                                      angle:
                                          360 / 365 * (10 + i * 20) / 180 * pi,
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
                                                          child:
                                                              imageToneWhiteFlatCenter[
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
                                                                      strWinal[i],
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
                                                        child:
                                                            imageToneWhiteFlatCenter[
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
                                                      child:
                                                          imageToneWhiteFlatCenter[
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
                                                                    strWinal[
                                                                        18],
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
                                                                  strWinal[0],
                                                                  style:
                                                                      textStyleStrWinal))))))
                                        ]))))
                          ])))),
              Positioned(
                  top: posWheelHaab.top,
                  left: posWheelHaab.left,
                  child: Transform.rotate(
                      angle: offsetGearHaab -
                          finalAngle /
                              9 *
                              pi /
                              365, // offsetGearHaab - finalAngle / 180 * pi / 365 * 20
                      child: SizedBox(
                          height: sizeWheelHaab.height,
                          width: sizeWheelHaab.width,
                          child: Consumer<YearData>(
                              builder: (context, data, child) {
                            return Stack(children: [
                              for (int i = -20; i < 21; i++)
                                if (data.yearData[(currYear + (xDayTotal + i) / 365).floor()][(xDayTotal + i) % 365].eventList.any((element) => element.event != null) ||
                                    data.yearData[(currYear + (xDayTotal + i) / 365).floor()][(xDayTotal + i) % 365].noteList
                                        .any((element) => element != null) ||
                                    data.yearData[(currYear + (xDayTotal + i) / 365).floor()][(xDayTotal + i) % 365].taskList
                                        .any((element) =>
                                            element.isChecked == false))
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
                                                  color: const Color.fromARGB(32, 255, 255, 255),
                                                  border: Border.all(color: Colors.white, width: 1),
                                                  borderRadius: BorderRadius.circular(5),
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
                      angle: offsetGearNahuales + finalAngle / 180 * pi,
                      child: Image.asset('assets/images/gearNahuales.png',
                          height: sizeWheelNahuales.height,
                          width: sizeWheelNahuales.width,
                          color: mainColor,
                          colorBlendMode: BlendMode.modulate))),
              Positioned(
                  top: posWheelNahuales.top,
                  left: posWheelNahuales.left,
                  child: Transform.rotate(
                      angle: trecenaOffsetAngle +
                          (dTrecenaAngle + finalAngle) / 180 * pi,
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
                              if (_controller.isAnimating) {
                                _controller.stop();
                              }
                              final touchPositionFromCenter =
                                  details.localPosition -
                                      centerOfGestureDetector;
                              upsetAngle = oldAngle -
                                  touchPositionFromCenter.direction * 180 / pi;
                            },
                            onPanUpdate: (details) {
                              final touchPositionFromCenter =
                                  details.localPosition -
                                      centerOfGestureDetector;
                              setState(() {
                                prevAngle = finalAngle;

                                finalAngle = touchPositionFromCenter.direction *
                                        180 /
                                        pi +
                                    upsetAngle;

                                finalAngle = (finalAngle + 360) % 360;

                                if (finalAngle + mAngle - prevAngle < -300) {
                                  iRounds++;
                                  mAngle = 360 * iRounds;
                                }

                                if (finalAngle + mAngle - prevAngle > 300) {
                                  mAngle = 360 * iRounds - 360;
                                  iRounds--;
                                }

                                finalAngle = finalAngle + mAngle;

                                // get angle HaabGear
                                double angle = -offsetGearHaab * 180 / pi +
                                    finalAngle / 365 * 20;

                                // get chosenDayTotal, chosenDay
                                int chosenDayTotal =
                                    ((angle + 180 / 365) * 365 / 360).floor();
                                chosenDay = chosenDayTotal % 365;

                                // get chosenYear, chosenHaabYear
                                chosenYear = currYear +
                                    ((angle + 180 / 365) / 360).floor();
                                chosenHaabYear = chosenYear + 5129;

                                if (chosenDayTotal % 10 == 0) {
                                  xDayTotal = chosenDayTotal;
                                }

                                // increase Tone Name, Nahual Name and the Long Count
                                if (finalAngle > 18 * nAngle + 18 - 9) {
                                  cTone++;
                                  cNahual++;
                                  nAngle++;

                                  if (cTone > 12) {
                                    cTone = 0;
                                  }
                                  if (cNahual > 19) {
                                    cNahual = 0;
                                  }

                                  strTextToneNahual =
                                      '${strTone[cTone]}\n${strNahual[cNahual]}';

                                  kin++;
                                  if (kin > 19) {
                                    kin = 0;
                                    winal++;
                                    if (winal > 17) {
                                      winal = 0;
                                      tun++;
                                      if (tun > 19) {
                                        tun = 0;
                                        katun++;
                                        if (katun > 19) {
                                          katun = 0;
                                        }
                                      }
                                    }
                                  }
                                }

                                // decrease Tone Name, Nahual Name and the Long Count
                                if (finalAngle < 18 * nAngle - 18 + 9) {
                                  cTone--;
                                  cNahual--;
                                  nAngle--;

                                  if (cTone < 0) {
                                    cTone = 12;
                                  }
                                  if (cNahual < 0) {
                                    cNahual = 19;
                                  }

                                  strTextToneNahual =
                                      '${strTone[cTone]}\n${strNahual[cNahual]}';

                                  kin--;
                                  if (kin < 0) {
                                    kin = 19;
                                    winal--;
                                    if (winal < 0) {
                                      winal = 17;
                                      tun--;
                                      if (tun < 0) {
                                        tun = 19;
                                        katun--;
                                        if (katun < 0) {
                                          katun = 19;
                                        }
                                      }
                                    }
                                  }
                                }

                                // change Trecena
                                if (finalAngle >
                                    234 * iTrecena - diffAngle * 18 - 9) {
                                  nTrecenaColor++;
                                  if (nTrecenaColor > 3) {
                                    nTrecenaColor = 0;
                                  }
                                  if (nTrecenaColor == 0) {
                                    nTrecenaAngle++;
                                    dTrecenaAngle = 144.0 * nTrecenaAngle;
                                  }
                                  currTrecenaMask = trecenaMask[nTrecenaColor];
                                  iTrecena++;
                                }
                                if (finalAngle <
                                    234 * iTrecena - 234 - diffAngle * 18 - 9) {
                                  nTrecenaColor--;
                                  if (nTrecenaColor < 0) {
                                    nTrecenaColor = 3;
                                  }
                                  if (nTrecenaColor == 3) {
                                    nTrecenaAngle--;
                                    dTrecenaAngle = 144.0 * nTrecenaAngle;
                                  }
                                  currTrecenaMask = trecenaMask[nTrecenaColor];
                                  iTrecena--;
                                }
                              });
                            },
                            onPanEnd: (details) {
                              _animation = _controller.drive(Tween(
                                  begin: finalAngle,
                                  end: (finalAngle / 18).roundToDouble() * 18));
                              _controller.reset();
                              _controller.forward();
                            },
                            child: Transform.rotate(
                                angle:
                                    offsetGearNahuales + finalAngle / 180 * pi,
                                child: Stack(children: [
                                  for (int i = 0; i < 20; i++)
                                    Align(
                                        alignment: const Alignment(0.904, 0),
                                        child: Transform.rotate(
                                            origin: offsetSignNahual,
                                            angle:
                                                -18 / 180 * pi * i.toDouble(),
                                            child: SizedBox(
                                                height: sizeSignNahual.height,
                                                width: sizeSignNahual.width,
                                                child: signNahual[i])))
                                ])));
                      }))),
              Positioned(
                  top: posButtonReset.top,
                  left: posButtonReset.left,
                  child: GestureDetector(
                      onTap: () {
                        reset();
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
                      angle: offsetGearTones + finalAngle / 180 * pi / 13 * 20,
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
                                        angle: -27.692307692 /
                                            180 *
                                            pi *
                                            i.toDouble(),
                                        child: SizedBox(
                                            height: sizeSignTone.height,
                                            width: sizeSignTone.width,
                                            child: imageToneWhiteVertical[i])))
                            ])
                          ])))),
              Positioned(
                  top: posSandstoneCircle.top,
                  left: posSandstoneCircle.left,
                  child: Image.asset("assets/images/sandstoneCircle.png",
                      height: sizeSandstoneCircle.height,
                      width: sizeSandstoneCircle.width)),
              Positioned(
                  // links oben
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
                  // rechts oben
                  top: posButtonTheYear.top,
                  left: posButtonTheYear.left,
                  child: GestureDetector(
                      onTap: () {
                        int beginTone = (startTone + 365 * chosenYear) % 13;
                        int beginNahual = (startNahual + 365 * chosenYear) % 20;
                        int beginKinIndex =
                            (startKinIndex + 365 * chosenYear) % 260;

                        const int dDays = 62;
                        int sBaktun = 13; // ?
                        int sKatun = (365 * chosenYear + dDays) ~/ 7200;
                        int sTun =
                            (365 * chosenYear + dDays - sKatun * 7200) ~/ 360;
                        int sWinal = (365 * chosenYear +
                                dDays -
                                sKatun * 7200 -
                                sTun * 360) ~/
                            20;
                        int sKin = 365 * chosenYear +
                            dDays -
                            sKatun * 7200 -
                            sTun * 360 -
                            sWinal * 20;

                        DateTime chosenBeginGregorianDate =
                            startDate.add(Duration(days: 365 * (chosenYear)));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TheYear(
                                      backgroundImage: backgroundImage,
                                      mainColor: mainColor,
                                      chosenYear: chosenYear,
                                      chosenHaabYear: chosenHaabYear,
                                      chosenDay: chosenDay,
                                      beginTone: beginTone,
                                      beginNahual: beginNahual,
                                      beginKinIndex: beginKinIndex,
                                      beginLongCount: [
                                        sBaktun,
                                        sKatun,
                                        sTun,
                                        sWinal,
                                        sKin
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
                  // links unten
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
                  // rechts unten
                  top: posButtonCholqij.top,
                  left: posButtonCholqij.left,
                  child: GestureDetector(
                      onTap: () {
                        int cTone = getTone((offsetGearTones * 180 / pi +
                                finalAngle / 13 * 20) %
                            360);
                        int cNahual = getNahuales(
                            (offsetGearNahuales * 180 / pi + finalAngle) % 360);
                        int cKinIndex = getKinNummber(cTone, cNahual);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cholqij(
                                    backgroundImage: backgroundImage,
                                    mainColor: mainColor,
                                    cKinIndex: cKinIndex)));
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
                                List<int> intHaabDate = getHaabDate(chosenDay);

                                int chosenTone = getTone(
                                    (offsetGearTones * 180 / pi +
                                            finalAngle / 13 * 20) %
                                        360);

                                int chosenNahual = getNahuales(
                                    (offsetGearNahuales * 180 / pi +
                                            finalAngle) %
                                        360);

                                int dYear = getDeldaYear(
                                    -offsetGearHaab * 180 / pi +
                                        finalAngle / 365 * 20);

                                DateTime chosenGregorianDate = startDate.add(
                                    Duration(
                                        days: 365 * (currYear + dYear) +
                                            chosenDay));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TheDay(
                                            backgroundImage: backgroundImage,
                                            mainColor: mainColor,
                                            chosenYear: chosenYear,
                                            chosenDay: chosenDay,
                                            strHaabDate:
                                                '${intHaabDate[0].toString().padLeft(2, '0')}.${(intHaabDate[1] + 1).toString().padLeft(2, '0')}',
                                            chosenTone: chosenTone,
                                            chosenNahual: chosenNahual,
                                            chosenLongCount: [
                                              baktun,
                                              katun,
                                              tun,
                                              winal,
                                              kin
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
                              child: Image.asset('assets/images/sandstone.png',
                                  height: sizeSandstones.height,
                                  /*50*/ width: sizeSandstones.width)),
                          Padding(
                              padding: paddingSandstones,
                              child: Image.asset('assets/images/sandstone.png',
                                  height: sizeSandstones.height,
                                  /*50*/ width: sizeSandstones.width)),
                          Padding(
                              padding: paddingSandstones,
                              child: Image.asset('assets/images/sandstone.png',
                                  height: sizeSandstones.height,
                                  /*50*/ width: sizeSandstones.width)),
                          Padding(
                              padding: paddingSandstones,
                              child: Image.asset('assets/images/sandstone.png',
                                  height: sizeSandstones.height,
                                  /*50*/ width: sizeSandstones.width)),
                          Image.asset('assets/images/sandstone.png',
                              height: sizeSandstones.height,
                              /*50*/ width: sizeSandstones.width)
                        ]))),
                Positioned(
                    top: posBoxLongCount.top,
                    left: posBoxLongCount.left,
                    child: SizedBox(
                        height: sizeBoxLongCount.height,
                        width: sizeBoxLongCount.width,
                        child: Row(children: [
                          Padding(
                              padding: paddingNummbersBaktun,
                              child: SizedBox(
                                  width: sizeNummbers.width,
                                  child: imageToneWhiteFlatBottom[baktun])),
                          Padding(
                              padding: paddingNummbersKatun,
                              child: SizedBox(
                                  width: sizeNummbers.width,
                                  child: imageToneWhiteFlatBottom[katun])),
                          Padding(
                              padding: paddingNummbersTun,
                              child: SizedBox(
                                  width: sizeNummbers.width,
                                  child: imageToneWhiteFlatBottom[tun])),
                          Padding(
                              padding: paddingNummbersWinal,
                              child: SizedBox(
                                  width: sizeNummbers.width,
                                  child: imageToneWhiteFlatBottom[winal])),
                          Padding(
                              padding: paddingNummbersKin,
                              child: SizedBox(
                                  width: sizeNummbers.width,
                                  child: imageToneWhiteFlatBottom[kin]))
                        ])))
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
  String bgfilePath = prefs.getString(key) ?? '';
  if (bgfilePath.isEmpty) {
    return const AssetImage('assets/images/leaves.jpg');
  } else {
    return FileImage(File(bgfilePath));
  }
}

saveBgFilePath(bgFilePath) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'bgFilePath';
  prefs.setString(key, bgFilePath);
}

deleteBgImagePath() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('bgFilePath');
}
