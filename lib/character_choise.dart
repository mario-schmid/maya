import 'package:flutter/material.dart';
import 'package:maya/helper/maya_images.dart';
import 'package:maya/maya_cross_container.dart';

class CharacterChoise extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;

  final int chosenTone;
  final int chosenNahual;
  const CharacterChoise(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.chosenTone,
      required this.chosenNahual});

  @override
  State<CharacterChoise> createState() => _CharacterChoiseState();
}

class _CharacterChoiseState extends State<CharacterChoise> {
  late FixedExtentScrollController _controllerTone;
  late FixedExtentScrollController _controllerNahual;

  late int initTone;
  late int indexTone;
  late int initNahual;
  late int indexNahual;

  @override
  void initState() {
    initTone = widget.chosenTone;
    indexTone = widget.chosenTone;
    initNahual = widget.chosenNahual;
    indexNahual = widget.chosenNahual;

    _controllerTone = FixedExtentScrollController(initialItem: initTone);
    _controllerNahual = FixedExtentScrollController(initialItem: initNahual);
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
                showDialog<void>(
                    context: context,
                    //barrierDismissible: true,
                    builder: (BuildContext context) {
                      return Center(
                          child: mayaCrossContainer(
                              size,
                              widget.backgroundImage,
                              widget.mainColor,
                              indexTone,
                              indexNahual));
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
                                                            .imageToneWhiteFlatCenter[
                                                        i]))),
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
                                                  child: MayaImages()
                                                      .signNahual[i])))
                                    ]))
                            ]))
                  ]),
            )));
  }
}
