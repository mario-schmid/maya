import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../helper/maya_image.dart';
import '../helper/maya_list.dart';
import '../listview_builder.dart';
import '../maya_cross_container.dart';
import '../providers/mayadata.dart';
import '../selection_dialog.dart';

class TheYear extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final int chosenYear;
  final int chosenDay;
  final int beginKinIndex;
  final int beginTone;
  final int beginNahual;
  final List<int> beginLongCount;
  final DateTime chosenBeginGregorianDate;
  const TheYear({
    super.key,
    required this.backgroundImage,
    required this.mainColor,
    required this.chosenYear,
    required this.chosenDay,
    required this.beginKinIndex,
    required this.beginTone,
    required this.beginNahual,
    required this.beginLongCount,
    required this.chosenBeginGregorianDate,
  });

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
  //int dYear = 0;
  int winalNr = 0;
  late int tone;
  late int nahual;

  late int kinIndex;
  int currentItem = 0;

  late int longCount;

  late int baktun;
  late int katun;
  late int tun;
  late int winal;
  late int kin;

  late DateTime gregorianDate;

  final ItemScrollController _itemScrollController = ItemScrollController();
  // TODO: remove by the way
  /*final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();*/

  @override
  void initState() {
    initializeDateFormatting();
    String languageCode = Get.locale.toString();
    dateFormat = DateFormat("E dd.MM.yyyy", languageCode);
    
    // TODO: remove by the way
    /*_itemPositionsListener.itemPositions.addListener(() {
      int itemPositionsFirst =
          _itemPositionsListener.itemPositions.value.first.index;
      int itemPositionsLast =
          _itemPositionsListener.itemPositions.value.last.index;
      setState(() {
        if (itemPositionsLast < 39 && itemPositionsFirst != 0) {
          dYear = -1;
        }
        if (itemPositionsLast > 405) {
          dYear = 1;
        }
        if (itemPositionsLast > 39 && itemPositionsLast < 405) {
          dYear = 0;
        }
      });
    });*/

    longCount =
        widget.beginLongCount[0] * 144000 +
        widget.beginLongCount[1] * 7200 +
        widget.beginLongCount[2] * 360 +
        widget.beginLongCount[3] * 20 +
        widget.beginLongCount[4];

    tableBoxDecoration = BoxDecoration(
      color: widget.mainColor.withValues(alpha: 0.5),
      border: Border.all(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );

    addIconDecoration = BoxDecoration(
      color: widget.mainColor.withValues(alpha: 0.5),
      border: Border.all(color: Colors.white, width: 1),
      shape: BoxShape.circle,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => executeAfterWholeBuildProcess(),
    );
    super.initState();
  }

  Column dateColumn(Size size, int dayIndex) {
    day = (dayIndex % 365) % 20;
    winalNr = (dayIndex % 365) ~/ 20;
    tone = (widget.beginTone + dayIndex) % 13;
    nahual = (widget.beginNahual + dayIndex) % 20;
    kinIndex = (widget.beginKinIndex + dayIndex) % 260;

    baktun = (longCount + dayIndex) ~/ 144000 % 14;
    katun = (longCount - baktun * 144000 + dayIndex) ~/ 7200 % 20;
    tun = (longCount - baktun * 144000 - katun * 7200 + dayIndex) ~/ 360 % 20;
    winal =
        (longCount - baktun * 144000 - katun * 7200 - tun * 360 + dayIndex) ~/
        20 %
        18;
    kin =
        (longCount -
            baktun * 144000 -
            katun * 7200 -
            tun * 360 -
            winal * 20 +
            dayIndex) %
        20;

    gregorianDate = widget.chosenBeginGregorianDate.add(
      Duration(days: dayIndex),
    );

    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 39,
              width: (size.width - 108) / 4.193548387 /*62*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  '$day',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(width: 4),
            Container(
              height: 33,
              width: (size.width - 108) / 3.513513514 /*74*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  MayaList.strWinal[winalNr % 19],
                  style: tableTextStyle,
                ),
              ),
            ),
            SizedBox(width: 4),
            Container(
              height: 33,
              width: (size.width - 108) / 4.193548387 /*62*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  '${((winalNr + 1) * 20 + day - 20) % 365 + 1}',
                  style: tableTextStyle,
                ),
              ),
            ),
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
                        (widget.beginNahual + dayIndex) % 20,
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 26,
                      child: MayaImage.imageToneWhiteVertical[tone],
                    ),
                    const SizedBox(width: 4),
                    SizedBox(width: 62, child: MayaImage.signNahual[nahual]),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
            Container(
              height: 33,
              width: (size.width - 108) / 4.193548387 /*62*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  '${(kinIndex - 150) % 260 + 1}',
                  style: tableTextStyle,
                ),
              ),
            ),
          ],
        ),
        Row(
          key: UniqueKey(),
          children: [
            Container(
              height: 33,
              width: (size.width - 50) / 2 /*160*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  '$baktun.$katun.$tun.$winal.$kin',
                  style: tableTextStyle,
                ),
              ),
            ),
            SizedBox(width: 4),
            Container(
              height: 33,
              width: (size.width - 50) / 2 /*160*/,
              decoration: tableBoxDecoration,
              child: Center(
                child: Text(
                  dateFormat.format(gregorianDate),
                  style: tableTextStyle,
                ),
              ),
            ),
            SizedBox(width: 4),
            SizedBox(
              height: 42,
              width: 42,
              child: Material(
                color: widget.mainColor.withValues(alpha: 0.5),
                shape: CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                ),
                child: InkWell(
                  customBorder: CircleBorder(),
                  splashColor: widget.mainColor,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return selectionDialog(
                          context,
                          widget.mainColor,
                          (widget.chosenYear + dayIndex / 365).toInt(),
                          dayIndex % 365,
                          widget.chosenBeginGregorianDate.add(
                            Duration(days: dayIndex),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add, color: Colors.white, size: 28.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.width,
          child: Consumer<MayaData>(
            builder: (context, data, child) {
              final int cYear = (widget.chosenYear + dayIndex / 365).toInt();
              final int cDay = dayIndex % 365;

              if (data.mayaData.containsKey(cYear)) {
                if (data.mayaData[cYear]!.containsKey(cDay)) {
                  return listViewBuilder(
                    EdgeInsets.zero,
                    NeverScrollableScrollPhysics(),
                    size,
                    widget.mainColor,
                    cYear,
                    cDay,
                    data,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /*============================================================================*/
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
    /*============================================================================*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.lerp(widget.mainColor, Colors.black, 0.3),
          foregroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height - statusBarHeight - 1,
                    child: ScrollablePositionedList.builder(
                      padding: const EdgeInsets.only(top: 0),
                      scrollDirection: Axis.vertical,
                      itemScrollController: _itemScrollController,
                      // TODO: remove by the way!
                      //itemPositionsListener: _itemPositionsListener,
                      itemCount: 445,
                      itemBuilder: (context, dayIndex) {
                        return SizedBox(
                          key: UniqueKey(),
                          child: dateColumn(size, dayIndex - 40),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: size.width * 0.08,
                    width: size.width * 0.32,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(200, 46, 125, 50),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '${widget.chosenYear}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: navigationBarHeight + 5),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: FloatingActionButton(
                      backgroundColor: widget.mainColor.withValues(alpha: 0.5),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                      ),
                      onPressed: () {
                        _scrollToHome();
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.unfold_less,
                          color: Colors.white,
                          size: 30,
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
    );
  }
  /*============================================================================*/
  /*============================================================================*/

  void executeAfterWholeBuildProcess() {
    _itemScrollController.jumpTo(index: widget.chosenDay + 40);
  }

  void _scrollToHome() {
    _itemScrollController.scrollTo(
      index: widget.chosenDay + 40,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
