import 'package:flutter/material.dart';

import '../helper/maya_images.dart';
import '../helper/maya_lists.dart';
import '../methods/get_haab_date.dart';
import '../the_day.dart';

class DateSelection extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final int chosenYear;
  final int chosenDay;
  final int chosenTone;
  final int chosenNahual;
  final int beginTone;
  final int beginNahual;
  final List<int> chosenLongCount;
  final DateTime chosenGregorianDate;
  const DateSelection(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.chosenYear,
      required this.chosenDay,
      required this.chosenTone,
      required this.chosenNahual,
      required this.beginTone,
      required this.beginNahual,
      required this.chosenLongCount,
      required this.chosenGregorianDate});

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  bool wayeb = false;
  late final List<int> haabDate;

  late int longCount;

  late FixedExtentScrollController _controllerHaabDay;
  late FixedExtentScrollController _controllerHaabWinal;
  late FixedExtentScrollController _controllerHaabYear;

  late int indexDay;
  late int indexWinal;
  late int indexYear;

  @override
  void initState() {
    haabDate = getHaabDate(widget.chosenDay);
    if (haabDate[1] == 18) {
      wayeb = true;
    }

    longCount = widget.chosenLongCount[0] * 144000 +
        widget.chosenLongCount[1] * 7200 +
        widget.chosenLongCount[2] * 360 +
        widget.chosenLongCount[3] * 20 +
        widget.chosenLongCount[4];

    indexDay = haabDate[0];
    indexWinal = haabDate[1];
    indexYear = 108;

    _controllerHaabDay = FixedExtentScrollController(initialItem: indexDay);
    _controllerHaabWinal = FixedExtentScrollController(initialItem: indexWinal);
    _controllerHaabYear = FixedExtentScrollController(initialItem: indexYear);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),
            body: GestureDetector(
              onTap: () {
                showDay(context);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: size.height * 1,
                        width: size.width * 0.3,
                        child: ListWheelScrollView(
                            controller: _controllerHaabDay,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: size.width * 0.2,
                            diameterRatio: 1.2,
                            onSelectedItemChanged: (int index) {
                              indexDay = index;
                            },
                            children: [
                              if (wayeb) ...[
                                for (int i = 0; i < 5; i++)
                                  Container(
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  widget.mainColor,
                                                  BlendMode.modulate),
                                              image: const AssetImage(
                                                  'assets/images/bg_pattern_three.jpg'),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 0.02))),
                                      child: Center(
                                        child: SizedBox(
                                            width: size.width * 0.18,
                                            child: MayaImages()
                                                .imageToneWhiteFlatCenter[i]),
                                      ))
                              ] else ...[
                                for (int i = 0; i < 20; i++)
                                  Container(
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  widget.mainColor,
                                                  BlendMode.modulate),
                                              image: const AssetImage(
                                                  'assets/images/bg_pattern_three.jpg'),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 0.02))),
                                      child: Center(
                                        child: SizedBox(
                                            width: size.width * 0.18,
                                            child: MayaImages()
                                                .imageToneWhiteFlatCenter[i]),
                                      ))
                              ]
                            ])),
                    SizedBox(
                        height: size.height * 1,
                        width: size.width * 0.3,
                        child: ListWheelScrollView(
                            controller: _controllerHaabWinal,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: size.width * 0.2,
                            diameterRatio: 1.2,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                indexWinal = index;
                                if (index == 18) {
                                  wayeb = true;
                                  indexDay > 4 ? indexDay = 4 : null;
                                } else {
                                  wayeb = false;
                                }
                              });
                            },
                            children: [
                              for (int i = 0; i < 19; i++)
                                Container(
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                                widget.mainColor,
                                                BlendMode.modulate),
                                            image: const AssetImage(
                                                'assets/images/bg_pattern_three.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                size.width * 0.02))),
                                    child: Center(
                                      child: Text(MayaLists().strWinal[i],
                                          style: TextStyle(
                                              fontFamily: 'Robot',
                                              color: Colors.white,
                                              fontSize: size.width * 0.06,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none)),
                                    ))
                            ])),
                    SizedBox(
                        height: size.height * 1,
                        width: size.width * 0.3,
                        child: ListWheelScrollView(
                            controller: _controllerHaabYear,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: size.width * 0.2,
                            diameterRatio: 1.2,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                indexYear = index;
                              });
                            },
                            children: [
                              for (int i = -108; i < 109; i++)
                                Container(
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                        image: (widget.chosenYear + i + 12) %
                                                    52 ==
                                                0
                                            ? const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/sandstone_date_selection.jpg'),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    widget.mainColor,
                                                    BlendMode.modulate),
                                                image: const AssetImage(
                                                    'assets/images/bg_pattern_three.jpg'),
                                                fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                size.width * 0.02))),
                                    child: Center(
                                      child: Text(
                                          '${widget.chosenYear + i + 12}',
                                          style: TextStyle(
                                              fontFamily: 'Robot',
                                              color: Colors.white,
                                              fontSize: size.width * 0.06,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none)),
                                    ))
                            ]))
                  ]),
            )));
  }

  void showDay(BuildContext context) {
    //Navigator.of(context, rootNavigator: true).pop();
    int newChosenDay = indexWinal * 20 + indexDay;
    int dChosenYear = indexYear - 108;
    int dDays = dChosenYear * 365 + newChosenDay - widget.chosenDay;

    int baktun = (longCount + dDays) ~/ 144000 % 14;
    int katun = (longCount - baktun * 144000 + dDays) ~/ 7200 % 20;
    int tun = (longCount - baktun * 144000 - katun * 7200 + dDays) ~/ 360 % 20;
    int winal =
        (longCount - baktun * 144000 - katun * 7200 - tun * 360 + dDays) ~/
            20 %
            18;
    int kin = (longCount -
            baktun * 144000 -
            katun * 7200 -
            tun * 360 -
            winal * 20 +
            dDays) %
        20;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheDay(
                backgroundImage: widget.backgroundImage,
                mainColor: widget.mainColor,
                chosenYear: widget.chosenYear + dChosenYear,
                chosenDay: newChosenDay,
                chosenTone: (widget.chosenTone +
                        dChosenYear * 365 -
                        widget.chosenDay +
                        newChosenDay) %
                    13,
                chosenNahual: (widget.chosenNahual +
                        dChosenYear * 365 -
                        widget.chosenDay +
                        newChosenDay) %
                    20,
                beginTone: (widget.beginTone + dChosenYear * 365) % 13,
                beginNahual: (widget.beginNahual + dChosenYear * 365) % 20,
                chosenLongCount: [
                  baktun,
                  katun,
                  tun,
                  winal,
                  kin,
                ],
                chosenGregorianDate:
                    widget.chosenGregorianDate.add(Duration(days: dDays)))));
  }
}
