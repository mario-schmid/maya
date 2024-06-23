import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maya/methods/get_text_size.dart';
import 'package:maya/helper/maya_style.dart';

import 'helper/maya_lists.dart';
import 'maya_cross_container.dart';
import 'methods/get_haab_date.dart';
import 'methods/get_tone_nahual.dart';

class DateCalculator extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const DateCalculator(
      {super.key, required this.backgroundImage, required this.mainColor});

  @override
  State<DateCalculator> createState() => _HomeState();
}

class _HomeState extends State<DateCalculator> {
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.backgroundImage, fit: BoxFit.cover)),
                child: Stack(children: [
                  Positioned(
                      top: 200,
                      left: size.width / 6.428571429 /*56*/,
                      child: SizedBox(
                          height: 50,
                          width: size.width / 4.5 /*80*/,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                                color: widget.mainColor.withOpacity(0.5),
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
      color: widget.mainColor.withOpacity(0.5),
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
                                    '${MayaLists().strTone[tone]} ${MayaLists().strNahual[nahual]}',
                                    style: textStyleResult))),
                        SizedBox(height: size.width * 0.02),
                        mayaCrossContainer(size, widget.backgroundImage,
                            widget.mainColor, tone, nahual),
                        SizedBox(height: size.width * 0.02),
                        Container(
                            decoration: textBoxDecorationResult,
                            height: size.width * 0.1,
                            width: size.width * 0.4,
                            child: Center(
                                child: Text(
                                    '${intHaabDate[0]} ${MayaLists().strWinal[intHaabDate[1]]} ${haabYear + 12}',
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
      Size size = GetTextSize().getTextSize(
          'Fill in all fields correctly!'.tr, MayaStyle.popUpDialogBody);
      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration:
                        MayaStyle().popUpDialogDecoration(widget.mainColor),
                    height: 93,
                    width: size.width + 52,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Invalid characters!'.tr,
                              style: MayaStyle.popUpDialogTitle),
                          Text('Fill in all fields correctly!'.tr,
                              style: MayaStyle.popUpDialogBody)
                        ])));
          });
    }
  }

  void dialog() {
    Size size = GetTextSize().getTextSize(
        '28 ${'or'.tr} 29 ${'Days'.tr}'.tr, MayaStyle.popUpDialogBody);
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration:
                      MayaStyle().popUpDialogDecoration(widget.mainColor),
                  height: 358,
                  width: 280,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Notice'.tr, style: MayaStyle.popUpDialogTitle),
                        Text('\n${'Enter valid date!'.tr}\n',
                            style: MayaStyle.popUpDialogTitle),
                        Table(
                            columnWidths: <int, TableColumnWidth>{
                              0: FixedColumnWidth(280 - 62 - size.width),
                              1: FixedColumnWidth(size.width)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Text('${'January'.tr}(1)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'February'.tr}(2)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('28 ${'or'.tr} 29 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'March'.tr}(3)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'April'.tr}(4)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('30 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'May'.tr}(5)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'June'.tr}(6)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('30 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'July'.tr}(7)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'August'.tr}(8)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'Septemper'.tr}(9)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('30 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'October'.tr}(10)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'November'.tr}(11)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('30 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                              TableRow(children: <Widget>[
                                Text('${'December'.tr}(12)',
                                    style: MayaStyle.popUpDialogBody),
                                Text('31 ${'Days'.tr}',
                                    style: MayaStyle.popUpDialogBody)
                              ]),
                            ]),
                        Text('\n${'The month from 1 to 12'.tr}',
                            style: MayaStyle.popUpDialogBody),
                        Text('The year from 1601 to 2099'.tr,
                            style: MayaStyle.popUpDialogBody)
                      ])));
        });
  }
}
