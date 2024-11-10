import 'package:flutter/material.dart';

import '../helper/maya_images.dart';
import '../maya_cross_container.dart';

class CharacterChoice extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;

  final int chosenTone;
  final int chosenNahual;
  const CharacterChoice(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.chosenTone,
      required this.chosenNahual});

  @override
  State<CharacterChoice> createState() => _CharacterChoiceState();
}

class _CharacterChoiceState extends State<CharacterChoice> {
  late FixedExtentScrollController _controllerTone;
  late FixedExtentScrollController _controllerNahual;

  late int initTone;
  late int indexTone;
  late int initNahual;
  late int indexNahual;

  @override
  void initState() {
    initTone = (widget.chosenTone + 6) % 13;
    indexTone = (widget.chosenTone + 6) % 13;
    initNahual = (widget.chosenNahual + 10) % 20;
    indexNahual = (widget.chosenNahual + 10) % 20;

    _controllerTone = FixedExtentScrollController(initialItem: initTone);
    _controllerNahual = FixedExtentScrollController(initialItem: initNahual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.7),
            body: GestureDetector(
              onTap: () {
                showDialog<void>(
                    context: context,
                    //barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Center(
                          child: mayaCrossContainer(
                              size,
                              widget.backgroundImage,
                              widget.mainColor,
                              (indexTone + 7) % 13,
                              (indexNahual + 10) % 20));
                    });
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: size.height * 1,
                        width: size.width * 0.4,
                        child: ListWheelScrollView(
                            controller: _controllerTone,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: size.width * 0.32,
                            diameterRatio: 1.4,
                            onSelectedItemChanged: (int index) {
                              indexTone = index;
                            },
                            children: [
                              for (int i = 1; i < 14; i++)
                                SizedBox(
                                    width: size.width * 0.32,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: Image.asset(
                                                'assets/images/leaves.png',
                                                colorBlendMode:
                                                    BlendMode.modulate,
                                                color: widget.mainColor)),
                                        Center(
                                            child: SizedBox(
                                                width: size.width * 0.2,
                                                child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: MayaImages()
                                                        .imageToneWhiteFlatCenter[i <
                                                            7
                                                        ? (i + 7) % 14
                                                        : (i + 8) % 14]))),
                                      ],
                                    ))
                            ])),
                    SizedBox(
                        height: size.height * 1,
                        width: size.width * 0.4,
                        child: ListWheelScrollView(
                            controller: _controllerNahual,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: size.width * 0.32,
                            diameterRatio: 1.4,
                            onSelectedItemChanged: (int index) {
                              indexNahual = index;
                            },
                            children: [
                              for (int i = 0; i < 20; i++)
                                SizedBox(
                                    width: size.width * 0.32,
                                    child: Stack(children: [
                                      Center(
                                          child: Image.asset(
                                              'assets/images/leaves.png',
                                              colorBlendMode:
                                                  BlendMode.modulate,
                                              color: widget.mainColor)),
                                      Center(
                                          child: SizedBox(
                                              width: size.width * 0.22,
                                              child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child:
                                                      MayaImages().signNahual[
                                                          (i + 10) % 20])))
                                    ]))
                            ]))
                  ]),
            )));
  }
}
