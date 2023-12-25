import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/lists.dart';
import 'maya_cross_container.dart';
import 'methods/get_haab_date.dart';
import 'methods/get_tone_nahual.dart';

class DateCalculator extends StatefulWidget {
  const DateCalculator({super.key});

  @override
  State<DateCalculator> createState() => _HomeState();
}

class _HomeState extends State<DateCalculator> {
  final BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.green[700],
      border: Border.all(width: 1, color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(10)));

  final TextStyle styleHeadline = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  final TextStyle textStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  final controllerDay = TextEditingController();
  final controllerMonth = TextEditingController();
  final controllerYear = TextEditingController();

  @override
  void dispose() {
    controllerDay.dispose();
    controllerMonth.dispose();
    controllerYear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/leaves.jpg"),
                        fit: BoxFit.cover)),
                child: Stack(children: [
                  Positioned(
                      top: 200,
                      left: size.width / 6.428571429 /*56*/,
                      child: SizedBox(
                          height: 50,
                          width: size.width / 4.5 /*80*/,
                          child: TextField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: false,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white24, width: 1.0)),
                                  filled: false,
                                  labelText: 'Day'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.white24,
                                      fontWeight: FontWeight.w300),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              controller: controllerDay))),
                  Positioned(
                      top: 200,
                      left: size.width / 2.571428571 /*140*/,
                      child: SizedBox(
                          height: 50,
                          width: size.width / 4.5 /*80*/,
                          child: TextField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: false,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white24, width: 1.0)),
                                  filled: false,
                                  labelText: 'Month'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.white24,
                                      fontWeight: FontWeight.w300),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              controller: controllerMonth))),
                  Positioned(
                      top: 200,
                      left: size.width / 1.607142857 /*224*/,
                      child: SizedBox(
                          height: 50,
                          width: size.width / 4.5 /*80*/,
                          child: TextField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: false,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white24, width: 1.0)),
                                  filled: false,
                                  labelText: 'Year'.tr,
                                  labelStyle: const TextStyle(
                                      color: Colors.white24,
                                      fontWeight: FontWeight.w300),
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              controller: controllerYear))),
                  Positioned(
                      top: 305,
                      left: (size.width - 150) / 2 /*105*/,
                      child: GestureDetector(
                          onTap: () {
                            calculateAndShowResult(size);
                          },
                          child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(127, 41, 41, 163),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text('Calculate'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24))))))
                ]))));
  }

  void calculateAndShowResult(Size size) {
    final BoxDecoration textBoxDecorationResult = BoxDecoration(
      color: const Color.fromARGB(243, 41, 41, 163),
      border: Border.all(color: Colors.white, width: size.width * 0.0028),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );

    final TextStyle textStyleResult = TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none);

    try {
      int day = int.parse(controllerDay.text);
      int month = int.parse(controllerMonth.text);
      int jear = int.parse(controllerYear.text);

      int january = 31;
      int february = 28; // 29
      int march = 31;
      int april = 30;
      int may = 31;
      int june = 30;
      int july = 31;
      int august = 31;
      int september = 30;
      int october = 31;
      int november = 30;
      int december = 31;

      int beginKinNr = 229;
      int beginHaabYear = 4717;
      int beginHaabDays = 213;
      int beginLongCount = 1721530;

      if (jear % 4 == 0) {
        february = 29;
      }
      if (jear % 100 == 0) {
        february = 28;
      }
      if (jear % 400 == 0) {
        february = 29;
      }

      if (jear < 1601 ||
          jear > 2099 ||
          month < 1 ||
          month > 12 ||
          month == 1 && (day < 1 || day > january) ||
          month == 2 && (day < 1 || day > february) ||
          month == 3 && (day < 1 || day > march) ||
          month == 4 && (day < 1 || day > april) ||
          month == 5 && (day < 1 || day > may) ||
          month == 6 && (day < 1 || day > june) ||
          month == 7 && (day < 1 || day > july) ||
          month == 8 && (day < 1 || day > august) ||
          month == 9 && (day < 1 || day > september) ||
          month == 10 && (day < 1 || day > october) ||
          month == 11 && (day < 1 || day > november) ||
          month == 12 && (day < 1 || day > december)) {
        dialog();
      } else {
        int days = 0;
        for (int i = 1601; i < jear; i++) {
          days += 365;
          if (i % 4 == 0) {
            days += 1;
          }
          if (i % 100 == 0) {
            days -= 1;
          }
          if (i % 400 == 0) {
            days += 1;
          }
        }

        var monthNr = [
          0,
          0 + january,
          january + february,
          january + february + march,
          january + february + march + april,
          january + february + march + april + may,
          january + february + march + april + may + june,
          january + february + march + april + may + june + july,
          january + february + march + april + may + june + july + august,
          january +
              february +
              march +
              april +
              may +
              june +
              july +
              august +
              september,
          january +
              february +
              march +
              april +
              may +
              june +
              july +
              august +
              september +
              october,
          january +
              february +
              march +
              april +
              may +
              june +
              july +
              august +
              september +
              october +
              november
        ];

        int dayOfTheYear = monthNr[month - 1] + day;
        int daysTotal = days + dayOfTheYear;

        int kinNr = (beginKinNr + daysTotal) % 260;

        var toneNahual = getToneNahual(kinNr);

        int tone = toneNahual[0];
        int nahual = toneNahual[1];

        int haabYear =
            (beginHaabYear + (daysTotal - beginHaabDays + 61) ~/ 365);
        int haabDays = (beginHaabDays + daysTotal) % 365;

        int longCount = beginLongCount + daysTotal;

        int baktun = longCount ~/ 144000;
        int katun = (longCount - baktun * 144000) ~/ 7200;
        int tun = (longCount - baktun * 144000 - katun * 7200) ~/ 360;
        int winal =
            (longCount - baktun * 144000 - katun * 7200 - tun * 360) ~/ 20;
        int kin =
            longCount - baktun * 144000 - katun * 7200 - tun * 360 - winal * 20;

        List<int> intHaabDate = getHaabDate(haabDays);

        showDialog<void>(
            context: context,
            //barrierDismissible: true,
            builder: (BuildContext context) {
              return Center(
                  child: SizedBox(
                      height: size.width * 1.3228,
                      child: Column(children: [
                        Container(
                            decoration: textBoxDecorationResult,
                            height: size.width * 0.1,
                            width: size.width * 0.4,
                            child: Center(
                                child: Text(
                                    '${strTone[tone]} ${strNahual[nahual]}',
                                    style: textStyleResult))),
                        SizedBox(height: size.width * 0.02),
                        mayaCrossContainer(size, tone, nahual),
                        SizedBox(height: size.width * 0.02),
                        Container(
                            decoration: textBoxDecorationResult,
                            height: size.width * 0.1,
                            width: size.width * 0.4,
                            child: Center(
                                child: Text(
                                    '${intHaabDate[0]} ${strWinal[intHaabDate[1]]} $haabYear',
                                    style: textStyleResult))),
                        SizedBox(height: size.width * 0.02),
                        Container(
                            decoration: textBoxDecorationResult,
                            height: size.width * 0.1,
                            width: size.width * 0.4,
                            child: Center(
                                child: Text('$baktun.$katun.$tun.$winal.$kin',
                                    style: textStyleResult)))
                      ])));
            });
      }
    } catch (e) {
      Size size = getTextSize('Fill in all fields correctly!'.tr, textStyle);
      showDialog<void>(
          context: context,
          //barrierDismissible: true,
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: boxDecoration,
                    height: 93,
                    width: size.width + 42,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Invalid characters!'.tr, style: styleHeadline),
                          Text('\n${'Fill in all fields correctly!'.tr}',
                              style: textStyle)
                        ])));
          });
    }
  }

  void dialog() {
    Size size = getTextSize('28 ${'or'.tr} 29 ${'Days'.tr}'.tr, textStyle);
    showDialog<void>(
        context: context,
        //barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: boxDecoration,
                  height: 349,
                  width: 260,
                  child: Column(children: [
                    Text('Notice'.tr, style: styleHeadline),
                    Text('\n${'Enter valid date!'.tr}\n', style: textStyle),
                    Table(
                        columnWidths: <int, TableColumnWidth>{
                          0: FixedColumnWidth(260 - 42 - size.width),
                          1: FixedColumnWidth(size.width)
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Text('${'January'.tr}(1)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'February'.tr}(2)', style: textStyle),
                            Text('28 ${'or'.tr} 29 ${'Days'.tr}',
                                style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'March'.tr}(3)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'April'.tr}(4)', style: textStyle),
                            Text('30 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'May'.tr}(5)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'June'.tr}(6)', style: textStyle),
                            Text('30 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'July'.tr}(7)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'August'.tr}(8)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'Septemper'.tr}(9)', style: textStyle),
                            Text('30 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'October'.tr}(10)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'November'.tr}(11)', style: textStyle),
                            Text('30 ${'Days'.tr}', style: textStyle)
                          ]),
                          TableRow(children: <Widget>[
                            Text('${'December'.tr}(12)', style: textStyle),
                            Text('31 ${'Days'.tr}', style: textStyle)
                          ]),
                        ]),
                    Text('\n${'The month from 1 to 12'.tr}', style: textStyle),
                    Text('The year from 1601 to 2099'.tr, style: textStyle)
                  ])));
        });
  }
}

Size getTextSize(String text, TextStyle textStyle) {
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: double.infinity,
  );
  return textPainter.size;
}
