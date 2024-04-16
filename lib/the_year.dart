import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maya/providers/dayitems.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'helper/images.dart';
import 'helper/lists.dart';
import 'maya_cross_container.dart';
import 'methods/update_list.dart';
import 'selection_dialog.dart';

class TheYear extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final int chosenYear;
  final int chosenHaabYear;
  final int chosenDay;
  final int beginTone;
  final int beginKinIndex;
  final int beginNahual;
  final List<int> beginLongCount;
  final DateTime chosenBeginGregorianDate;
  const TheYear(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.chosenYear,
      required this.chosenHaabYear,
      required this.chosenDay,
      required this.beginTone,
      required this.beginKinIndex,
      required this.beginNahual,
      required this.beginLongCount,
      required this.chosenBeginGregorianDate});

  @override
  State<TheYear> createState() => _TheYearState();
}

class _TheYearState extends State<TheYear> {
  late DateFormat dateFormat;

  late BoxDecoration tableBoxDecoration;
  late BoxDecoration addIconDecoration;

  TextStyle tableTextStyle = const TextStyle(color: Colors.white, fontSize: 14);

  late int currDay;

  int day = 0;
  int winalNr = 0;
  late int tone;
  late int nahual;

  late int kinIndex;

  late int baktun;
  late int katun;
  late int tun;
  late int winal;
  late int kin;

  late DateTime gregorianDate;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    initializeDateFormatting();
    String languageCode = Get.locale.toString();
    dateFormat = DateFormat("E dd.MM.yyyy", languageCode);

    tableBoxDecoration = BoxDecoration(
        color: widget.mainColor.withOpacity(0.5),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle);

    addIconDecoration = BoxDecoration(
        color: widget.mainColor.withOpacity(0.5),
        border: Border.all(color: Colors.white, width: 1),
        shape: BoxShape.circle);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => executeAfterWholeBuildProcess(context));
    super.initState();
  }

  Column dateColumn(Size size, int dayIndex) {
    day = dayIndex % 20;
    winalNr = dayIndex ~/ 20;
    tone = (widget.beginTone + dayIndex) % 13;
    nahual = (widget.beginNahual + dayIndex) % 20;
    kinIndex = (widget.beginKinIndex + dayIndex) % 260;

    kin = (widget.beginLongCount[4] + dayIndex) % 20;
    winal = ((widget.beginLongCount[3] + 1) * 20 + dayIndex - kin) ~/ 20 % 18;
    tun =
        ((widget.beginLongCount[2] + 1) * 360 + dayIndex - winal * 20 - kin) ~/
            360;
    katun = ((widget.beginLongCount[1] + 1) * 7200 +
            dayIndex -
            tun * 360 -
            winal * 20 -
            kin) ~/
        7200;
    baktun = 13; // TODO: baktum?

    gregorianDate =
        widget.chosenBeginGregorianDate.add(Duration(days: dayIndex));

    return Column(children: [
      Row(children: [
        Container(
            height: 39,
            width: (size.width - 100) / 4.193548387 /*62*/,
            decoration: tableBoxDecoration,
            child: Center(
                child: Text('$day',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 20)))),
        Container(
            height: 33,
            width: (size.width - 100) / 3.513513514 /*74*/,
            decoration: tableBoxDecoration,
            child:
                Center(child: Text(strWinal[winalNr], style: tableTextStyle))),
        Container(
            height: 33,
            width: (size.width - 100) / 4.193548387 /*62*/,
            decoration: tableBoxDecoration,
            child: Center(
                child: Text('${kinIndex ~/ 13 + 1}', style: tableTextStyle))),
        GestureDetector(
            onTap: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                        child: mayaCrossContainer(
                            size,
                            widget.backgroundImage,
                            widget.mainColor,
                            (widget.beginTone + dayIndex) % 13,
                            (widget.beginNahual + dayIndex) % 20));
                  });
            },
            child: SizedBox(
                child: Row(children: [
              const SizedBox(width: 4),
              SizedBox(width: 26, child: imageToneWhiteVertical[tone]),
              const SizedBox(width: 4),
              SizedBox(width: 62, child: signNahual[nahual]),
              const SizedBox(width: 4)
            ]))),
        Container(
            height: 33,
            width: (size.width - 100) / 4.193548387 /*62*/,
            decoration: tableBoxDecoration,
            child:
                Center(child: Text('${kinIndex + 1}', style: tableTextStyle)))
      ]),
      Row(key: UniqueKey(), children: [
        Container(
            height: 33,
            width: (size.width - 40) / 2 /*160*/,
            decoration: tableBoxDecoration,
            child: Center(
                child: Text('$baktun.$katun.$tun.$winal.$kin',
                    style: tableTextStyle))),
        Container(
            height: 33,
            width: (size.width - 40) / 2 /*160*/,
            decoration: tableBoxDecoration,
            child: Center(
                child: Text(dateFormat.format(gregorianDate),
                    style: tableTextStyle))),
        Container(
            height: 40,
            width: 40,
            decoration: addIconDecoration,
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return selectionDialog(
                            context,
                            widget.chosenYear,
                            dayIndex,
                            widget.chosenBeginGregorianDate
                                .add(Duration(days: dayIndex)));
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child:
                      SvgPicture.asset('assets/vector_graphics/add_icon.svg'),
                )))
      ]),
      SizedBox(
          width: size.width,
          child: Consumer<DayItems>(builder: (context, data, child) {
            return ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: data.dayItems[widget.chosenYear][dayIndex],
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    updateList(oldIndex, newIndex, widget.chosenYear, dayIndex);
                  });
                });
          }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
/*============================================================================*/
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
/*============================================================================*/
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.backgroundImage, fit: BoxFit.cover),
                ),
                child: Stack(children: [
                  Column(children: [
                    Container(
                        height: statusBarHeight,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 41, 41, 163),
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1)))),
                    SizedBox(
                        height: size.height - statusBarHeight /*- 33*/ - 40,
                        child: ScrollablePositionedList.builder(
                            padding: const EdgeInsets.only(top: 0),
                            scrollDirection: Axis.vertical,
                            itemScrollController: _scrollController,
                            itemCount: 365,
                            itemBuilder: (context, dayIndex) {
                              return SizedBox(
                                  key: UniqueKey(),
                                  child: dateColumn(size, dayIndex));
                            })),
                    SizedBox(
                      height: 40,
                      width: size.width,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    widget.mainColor, BlendMode.modulate),
                                image: const AssetImage(
                                    'assets/images/bg_pattern_one.jpg'),
                                fit: BoxFit.cover),
                          ),
                          child: MaterialButton(
                              shape: const Border(
                                  top: BorderSide(
                                      color: Colors.white, width: 1)),
                              splashColor: widget.mainColor,
                              onPressed: _scrollToHome,
                              child: const Icon(Icons.unfold_less,
                                  color: Colors.white, size: 30)),
                        ),
                      ),
                    ),
                  ]),
                  Positioned(
                      left: size.width * 0.5 - size.width * 0.166666667,
                      top: statusBarHeight,
                      child: ClipPath(
                          clipper: TriangleClipper(),
                          child: Container(
                              height: size.width * 0.111111111,
                              width: size.width * 0.333333333,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(200, 46, 125, 50),
                              ),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text('${widget.chosenHaabYear}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.05))))))
                ]))));
  }
/*============================================================================*/
/*============================================================================*/

  void executeAfterWholeBuildProcess(context) {
    _scrollController.jumpTo(index: widget.chosenDay);
  }

  void _scrollToHome() {
    _scrollController.scrollTo(
        index: widget.chosenDay,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut);
  }
}
