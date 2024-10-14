import 'package:flutter/material.dart';
import 'package:arrow_path/arrow_path.dart';

import '../helper/maya_images.dart';

class Relationship extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  const Relationship(
      {super.key, required this.backgroundImage, required this.mainColor});

  @override
  State<Relationship> createState() => _RelationshipState();
}

class _RelationshipState extends State<Relationship> {
  int toneA = 0;
  int toneB = 0;
  int nahualA = 0;
  int nahualB = 0;

  int finalNahual = 0;
  int finalTone = 0;

  bool result = false;

  @override
  void initState() {
    super.initState();
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
                    image: widget.backgroundImage, fit: BoxFit.cover),
              ),
              child: Stack(children: [
                Positioned(
                  top: size.height * 0.08,
                  child: SizedBox(
                    height: size.height * 0.7,
                    width: size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: size.width * 0.126,
                              child: ListWheelScrollView(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: size.width * 0.2,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (int index) {
                                    // update the UI on selected item changes
                                    setState(() {
                                      toneA = index;
                                    });
                                  },
                                  children: [
                                    for (int i = 0; i < 13; i++)
                                      Container(
                                          width: size.width * 0.126,
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
                                                height: size.width * 0.17,
                                                child: MayaImages()
                                                    .imageToneWhiteVertical[i]),
                                          ))
                                  ])),
                          SizedBox(
                              width: size.width * 0.214,
                              child: ListWheelScrollView(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: size.width * 0.2,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (int index) {
                                    // update the UI on selected item changes
                                    setState(() {
                                      nahualA = index;
                                    });
                                  },
                                  children: [
                                    for (int i = 0; i < 20; i++)
                                      Container(
                                          width: size.width * 0.214,
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
                                                width: size.width * 0.2,
                                                child: MayaImages()
                                                    .signNahual[(i + 10) % 20]),
                                          ))
                                  ])),
                          resultArrow(
                              size, result, finalTone, (finalNahual + 10) % 20),
                          SizedBox(
                              width: size.width * 0.126,
                              child: ListWheelScrollView(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: size.width * 0.2,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (int index) {
                                    // update the UI on selected item changes
                                    setState(() {
                                      toneB = index;
                                    });
                                  },
                                  children: [
                                    for (int i = 0; i < 13; i++)
                                      Container(
                                          width: size.width * 0.126,
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
                                                height: size.width * 0.17,
                                                child: MayaImages()
                                                    .imageToneWhiteVertical[i]),
                                          ))
                                  ])),
                          SizedBox(
                              width: size.width * 0.214,
                              child: ListWheelScrollView(
                                  physics: const FixedExtentScrollPhysics(),
                                  itemExtent: size.width * 0.2,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (int index) {
                                    // update the UI on selected item changes
                                    setState(() {
                                      nahualB = index;
                                    });
                                  },
                                  children: [
                                    for (int i = 0; i < 20; i++)
                                      Container(
                                          width: size.width * 0.214,
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
                                                width: size.width * 0.2,
                                                child: MayaImages()
                                                    .signNahual[(i + 10) % 20]),
                                          ))
                                  ]))
                        ]),
                  ),
                ),
                Positioned(
                    left: size.width * 0.35,
                    top: size.height * 0.7,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            finalNahual = (nahualA + nahualB + 1) % 20;
                            finalTone = (toneA + toneB + 1) % 13;
                            result = true;
                          });
                        },
                        child: Container(
                            height: size.width * 0.3,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        widget.mainColor, BlendMode.modulate),
                                    image: const AssetImage(
                                        'assets/images/bg_pattern_three.jpg'),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: Colors.white,
                                    width: size.width * 0.011),
                                shape: BoxShape.circle),
                            child: Center(
                                child: Container(
                                    height: size.width * 0.14,
                                    width: size.width * 0.14,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white,
                                            width: size.width * 0.011),
                                        shape: BoxShape.circle))))))
              ]))),
    );
  }
}

Widget resultArrow(Size size, bool result, int tone, int nahual) {
  if (result) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.052),
      child: SizedBox(
        height: size.width * 0.34,
        width: size.width * 0.24,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width * 0.2,
                  child: MayaImages().imageToneWhiteCurvedBottom[tone]),
              MayaImages().signNahual[nahual],
            ]),
      ),
    );
  } else {
    return SizedBox(
      //height: 0,
      width: size.width * 0.24,
      child: CustomPaint(
        painter: ArrowPainter(),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 5.0;

    {
      Path path = Path();
      path.relativeLineTo(size.width, 0);
      path = ArrowPath.addTip(path);
      path = ArrowPath.addTip(path, isBackward: true);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => false;
}
