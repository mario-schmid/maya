import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/images.dart';

Container mayaCrossContainer(Size size, int tone, int nahual) {
  BoxDecoration mainBoxDecoration = BoxDecoration(
    image: const DecorationImage(
        image: AssetImage("assets/images/leaves.jpg"), fit: BoxFit.cover),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  BoxDecoration boxDecoration = BoxDecoration(
    color: const Color.fromARGB(127, 41, 41, 163),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  TextStyle textStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: size.width * 0.034,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  Size sizeContainer = Size(size.width * 0.25, size.width * 0.25);
  double heightTone = size.width * 0.058;
  double heightNahual = size.width * 0.155;
  double paddingToneNahual = size.width * 0.01;
  double padding = size.width * 0.01;
  double sizeTextBox = size.width * 0.0782;

  List<int> tonesDirections = getDirectionTones(tone);
  List<int> nahualesDirections = getDirectionsNahuales(nahual);

  return Container(
      padding: const EdgeInsets.all(5),
      decoration: mainBoxDecoration,
      height: size.width * 0.96,
      width: size.width * 0.96,
      child: Column(children: [
        SizedBox(
            height: sizeTextBox,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('west'.tr, style: textStyle),
                  Text('Past'.tr, style: textStyle)
                ])),
        Container(
            decoration: boxDecoration,
            height: sizeContainer.height,
            width: sizeContainer.width,
            child: Column(children: [
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightTone,
                  child: imageToneWhiteCurvedBottom[tonesDirections[0]]),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightNahual,
                  child: signNahual[nahualesDirections[0]])
            ])),
        SizedBox(height: padding),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: sizeTextBox,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RotatedBox(
                    quarterTurns: -1,
                    child: Text('south'.tr, style: textStyle)),
                RotatedBox(
                    quarterTurns: -1,
                    child: Text('masculine'.tr, style: textStyle))
              ])),
          Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(children: [
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightTone,
                    child: imageToneWhiteCurvedBottom[tonesDirections[2]]),
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightNahual,
                    child: signNahual[nahualesDirections[2]])
              ])),
          SizedBox(width: padding),
          Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(children: [
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightTone,
                    child: imageToneWhiteCurvedBottom[tone]),
                SizedBox(height: paddingToneNahual),
                SizedBox(height: heightNahual, child: signNahual[nahual])
              ])),
          SizedBox(width: padding),
          Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(children: [
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightTone,
                    child: imageToneWhiteCurvedBottom[tonesDirections[3]]),
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightNahual,
                    child: signNahual[nahualesDirections[3]])
              ])),
          SizedBox(
              width: sizeTextBox,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RotatedBox(
                    quarterTurns: 1,
                    child: Text('feminine'.tr, style: textStyle)),
                RotatedBox(
                    quarterTurns: 1, child: Text('north'.tr, style: textStyle))
              ])),
        ]),
        SizedBox(height: padding),
        Container(
            decoration: boxDecoration,
            height: sizeContainer.height,
            width: sizeContainer.width,
            child: Column(children: [
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightTone,
                  child: imageToneWhiteCurvedBottom[tonesDirections[1]]),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightNahual,
                  child: signNahual[nahualesDirections[1]])
            ])),
        SizedBox(
            height: sizeTextBox,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('east'.tr, style: textStyle),
                  Text('Future'.tr, style: textStyle)
                ]))
      ]));
}

List<int> getDirectionTones(int tone) {
  return [(tone + 5) % 13, (tone + 8) % 13, (tone + 7) % 13, (tone + 6) % 13];
}

List<int> getDirectionsNahuales(int nahual) {
  return [
    (nahual + 12) % 20,
    (nahual + 8) % 20,
    (nahual + 14) % 20,
    (nahual + 6) % 20
  ];
}
