import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'helper/images.dart';
import 'maya_cross_container.dart';
import 'methods/get_kin_nummber.dart';
import 'methods/update_list.dart';
import 'providers/dayitems.dart';
import 'selection_dialog.dart';

class TheDay extends StatefulWidget {
  final int chosenYear;
  final int chosenDay;
  final String strHaabDate;
  final int chosenTone;
  final int chosenNahual;
  final List<int> chosenLongCount;
  final DateTime chosenGregorianDate;
  const TheDay(
      {super.key,
      required this.chosenYear,
      required this.chosenDay,
      required this.strHaabDate,
      required this.chosenTone,
      required this.chosenNahual,
      required this.chosenLongCount,
      required this.chosenGregorianDate});

  @override
  State<TheDay> createState() => _TheDayState();
}

class _TheDayState extends State<TheDay> {
  late DateFormat dateFormat;

  BoxDecoration boxDecoration = BoxDecoration(
      color: const Color.fromARGB(127, 41, 41, 163),
      border: Border.all(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle);

  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16);

  late Image imageTone;
  late Image imageNahual;

  late int chosenKinIndex;
  late int trecena;

  @override
  void initState() {
    initializeDateFormatting();
    String languageCode = Get.locale.toString();
    dateFormat = DateFormat("E dd.MM.yyyy", languageCode);
    chosenKinIndex = getKinNummber(widget.chosenTone, widget.chosenNahual);
    trecena = chosenKinIndex ~/ 13;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
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
                child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(10, statusBarHeight + 10, 10, 10),
                    child: SizedBox(
                        height: 160,
                        child: Column(children: [
                          Row(children: [
                            GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                      context: context,
                                      //barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return Align(
                                            alignment: const Alignment(0, 0.4),
                                            child: mayaCrossContainer(
                                                size,
                                                widget.chosenTone,
                                                widget.chosenNahual));
                                      });
                                },
                                child: Container(
                                    height: 150,
                                    width: 120,
                                    decoration: boxDecoration,
                                    child: Column(children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6.833, bottom: 4),
                                          child: SizedBox(
                                              height: 37,
                                              width: 80,
                                              child: imageToneWhiteCurvedBottom[
                                                  widget.chosenTone])),
                                      SizedBox(
                                          height: 93.333,
                                          width: 100,
                                          child:
                                              signNahual[widget.chosenNahual])
                                    ]))),
                            Column(children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      (size.width - 140) / 33 - 0.000666667,
                                      0,
                                      0,
                                      0),
                                  child: Row(children: [
                                    Container(
                                        height: 33.333,
                                        width: (size.width - 140) /
                                            3.882352941 /*56.667*/,
                                        decoration: boxDecoration,
                                        child: Center(
                                            child: Text(
                                          ('${trecena + 1}' /*widget.chosenDay + 1*/),
                                          style: textStyle,
                                        ))),
                                    Container(
                                        height: 40,
                                        width: (size.width - 140) / 2.2 /*100*/,
                                        decoration: boxDecoration,
                                        child: Center(
                                            child: Text(
                                          widget.strHaabDate,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ))),
                                    Container(
                                        height: 33.333,
                                        width: (size.width - 140) /
                                            3.882352941 /*56.667*/,
                                        decoration: boxDecoration,
                                        child: Center(
                                            child: Text(
                                          '${chosenKinIndex + 1}',
                                          style: textStyle,
                                        )))
                                  ])),
                              Padding(
                                  //padding: const EdgeInsets.all(10),
                                  padding: EdgeInsets.fromLTRB(
                                      (size.width - 140) / 22,
                                      10,
                                      (size.width - 140) / 22,
                                      10),
                                  child: Container(
                                      height: 33.333,
                                      width: (size.width - 140) /
                                          1.466666667 /*150*/,
                                      decoration: boxDecoration,
                                      child: Center(
                                          child: Text(
                                        '${widget.chosenLongCount[0]}.${widget.chosenLongCount[1]}.${widget.chosenLongCount[2]}.${widget.chosenLongCount[3]}.${widget.chosenLongCount[4]}',
                                        style: textStyle,
                                      )))),
                              Row(children: [
                                Container(
                                    height: 33.333,
                                    width: (size.width - 140) /
                                        1.466666667 /*150*/,
                                    decoration: boxDecoration,
                                    child: Center(
                                        child: Text(
                                            dateFormat.format(
                                                widget.chosenGregorianDate),
                                            style: textStyle))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: (size.width - 140) / 27.5),
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return selectionDialog(
                                                      context,
                                                      widget.chosenYear,
                                                      widget.chosenDay);
                                                });
                                          },
                                          child: Image.asset(
                                              'assets/images/button_add.png'),
                                        )))
                              ])
                            ])
                          ]),
                          const Divider(
                              color: Colors.white,
                              height: 25,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0),
                          Consumer<DayItems>(builder: (context, data, child) {
                            return SizedBox(
                                height:
                                    size.height - 160 - statusBarHeight - 35,
                                child: ReorderableListView(
                                    shrinkWrap: true,
                                    children: data.dayItems[widget.chosenYear]
                                        [widget.chosenDay],
                                    onReorder: (int oldIndex, int newIndex) {
                                      setState(() {
                                        updateList(
                                            oldIndex,
                                            newIndex,
                                            widget.chosenYear,
                                            widget.chosenDay);
                                      });
                                    }));
                          })
                        ]))))));
  }
}
