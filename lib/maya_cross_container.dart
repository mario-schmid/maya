import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/maya_base.dart';
import '../helper/maya_image.dart';

Container mayaCrossContainer(
  Size size,
  ImageProvider backgroundImage,
  Color mainColor,
  String themeNahuales,
  int tone,
  int nahual,
) {
  final BoxDecoration mainBoxDecoration = BoxDecoration(
    image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  final boxDecoration = BoxDecoration(
    color: mainColor.withValues(alpha: 0.5),
    border: Border.all(color: Colors.white, width: size.width * 0.0028),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
  );

  final TextStyle textStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: size.width * 0.03,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );

  final Size sizeContainer = Size(size.width * 0.26, size.width * 0.26);
  final double heightTone = size.width * 0.058;
  final double heightNahual = size.width * 0.155;
  final double paddingToneNahual = size.width * 0.01;

  final List<int> tonesDirections = getDirectionTones(tone);
  final List<int> nahualesDirections = getDirectionsNahuales(nahual);

  return Container(
    decoration: mainBoxDecoration,
    height: size.width * 0.96,
    width: size.width * 0.96,
    padding: EdgeInsets.all(size.width * 0.01),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Past'.tr, style: textStyle),
        Container(
          decoration: boxDecoration,
          height: sizeContainer.height,
          width: sizeContainer.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: paddingToneNahual),
              SizedBox(
                height: heightTone,
                child: MayaImage.imageToneWhiteCurvedBottom[tonesDirections[0]],
              ),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                height: heightNahual,
                child: MayaBase.getNahual(themeNahuales, nahualesDirections[0]),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: Text('masculine'.tr, style: textStyle),
            ),
            Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightTone,
                    child: MayaImage
                        .imageToneWhiteCurvedBottom[tonesDirections[2]],
                  ),
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightNahual,
                    child: MayaBase.getNahual(
                      themeNahuales,
                      nahualesDirections[2],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightTone,
                    child: MayaImage.imageToneWhiteCurvedBottom[tone],
                  ),
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightNahual,
                    child: MayaBase.getNahual(themeNahuales, nahual),
                  ),
                ],
              ),
            ),
            Container(
              decoration: boxDecoration,
              height: sizeContainer.height,
              width: sizeContainer.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightTone,
                    child: MayaImage
                        .imageToneWhiteCurvedBottom[tonesDirections[3]],
                  ),
                  SizedBox(height: paddingToneNahual),
                  SizedBox(
                    height: heightNahual,
                    child: MayaBase.getNahual(
                      themeNahuales,
                      nahualesDirections[3],
                    ),
                  ),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Text('feminine'.tr, style: textStyle),
            ),
          ],
        ),
        Container(
          decoration: boxDecoration,
          height: sizeContainer.height,
          width: sizeContainer.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: paddingToneNahual),
              SizedBox(
                height: heightTone,
                child: MayaImage.imageToneWhiteCurvedBottom[tonesDirections[1]],
              ),
              SizedBox(height: paddingToneNahual),
              SizedBox(
                height: heightNahual,
                child: MayaBase.getNahual(themeNahuales, nahualesDirections[1]),
              ),
            ],
          ),
        ),
        Text('Future'.tr, style: textStyle),
      ],
    ),
  );
}

List<int> getDirectionTones(int tone) {
  return [(tone + 5) % 13, (tone + 8) % 13, (tone + 7) % 13, (tone + 6) % 13];
}

List<int> getDirectionsNahuales(int nahual) {
  return [
    (nahual + 12) % 20,
    (nahual + 8) % 20,
    (nahual + 14) % 20,
    (nahual + 6) % 20,
  ];
}
