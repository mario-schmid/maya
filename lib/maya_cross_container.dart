import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/maya_images.dart';

Container mayaCrossContainer(Size size, ImageProvider backgroundImage,
    Color mainColor, int tone, int nahual) {
  final BoxDecoration mainBoxDecoration = BoxDecoration(
    image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  final boxDecoration = BoxDecoration(
    color: mainColor.withOpacity(0.5),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  final TextStyle textStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: size.width * 0.03,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  final Size sizeContainer = Size(size.width * 0.25, size.width * 0.25);
  final double heightTone = size.width * 0.058;
  final double heightNahual = size.width * 0.155;
  final double paddingToneNahual = size.width * 0.01;
  final double padding = size.width * 0.01;
  final double sizeTextBox = size.width * 0.0922;

  final List<int> tonesDirections = getDirectionTones(tone);
  final List<int> nahualesDirections = getDirectionsNahuales(nahual);

  return Container(
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
                  child: MayaImages()
                      .imageToneWhiteCurvedBottom[tonesDirections[0]]),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightNahual,
                  child: MayaImages().signNahual[nahualesDirections[0]])
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
                    child: MayaImages()
                        .imageToneWhiteCurvedBottom[tonesDirections[2]]),
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightNahual,
                    child: MayaImages().signNahual[nahualesDirections[2]])
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
                    child: MayaImages().imageToneWhiteCurvedBottom[tone]),
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightNahual,
                    child: MayaImages().signNahual[nahual])
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
                    child: MayaImages()
                        .imageToneWhiteCurvedBottom[tonesDirections[3]]),
                SizedBox(height: paddingToneNahual),
                SizedBox(
                    height: heightNahual,
                    child: MayaImages().signNahual[nahualesDirections[3]])
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
                  child: MayaImages()
                      .imageToneWhiteCurvedBottom[tonesDirections[1]]),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                  height: heightNahual,
                  child: MayaImages().signNahual[nahualesDirections[1]])
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
