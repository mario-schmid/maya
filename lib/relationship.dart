import 'package:flutter/material.dart';
import 'package:arrow_path/arrow_path.dart';

import 'helper/images.dart';

class Relationship extends StatelessWidget {
  const Relationship({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/leaves.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Stack(children: [
              Column(children: [
                SizedBox(height: size.height * 0.08),
                Row(children: [
                  SizedBox(width: size.width * 0.01),
                  SizedBox(
                      height: size.height * 0.7,
                      width: size.width * 0.14,
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
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/green.jpg'),
                                          fit: BoxFit.cover),
                                      /*color: const Color.fromARGB(
                                          255, 102, 153, 255),*/
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.02))),
                                  child: imageToneWhiteVertical[i])
                          ])),
                  SizedBox(width: size.width * 0.01),
                  SizedBox(
                      height: size.height * 0.7,
                      width: size.width * 0.2,
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
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/green.jpg'),
                                          fit: BoxFit.cover),
                                      /*color: const Color.fromARGB(
                                          255, 102, 153, 255),*/
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.02))),
                                  child: signNahual[(i + 10) % 20])
                          ])),
                  SizedBox(width: size.width * 0.02),
                  SizedBox(
                      width: size.width * 0.24,
                      child: resultArrow(
                          size, result, finalTone, (finalNahual + 10) % 20)),
                  SizedBox(width: size.width * 0.02),
                  SizedBox(
                      height: size.height * 0.7,
                      width: size.width * 0.14,
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
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/green.jpg'),
                                          fit: BoxFit.cover),
                                      /*color: const Color.fromARGB(
                                          255, 102, 153, 255),*/
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.02))),
                                  child: imageToneWhiteVertical[i])
                          ])),
                  SizedBox(width: size.width * 0.01),
                  SizedBox(
                      height: size.height * 0.7,
                      width: size.width * 0.2,
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
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/green.jpg'),
                                          fit: BoxFit.cover),
                                      /*color: const Color.fromARGB(
                                          255, 102, 153, 255),*/
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.02))),
                                  child: signNahual[(i + 10) % 20])
                          ]))
                ])
              ]),
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
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/green.jpg'),
                                  fit: BoxFit.cover),
                              /*color: const Color.fromARGB(255, 102, 153, 255),*/
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
            ])));
  }
}

Widget resultArrow(Size size, bool result, int tone, int nahual) {
  if (result) {
    return Column(children: [
      SizedBox(
          height: size.width * 0.1, child: imageToneWhiteCurvedBottom[tone]),
      SizedBox(height: size.width * 0.01),
      signNahual[nahual],
      SizedBox(height: size.width * 0.11)
    ]);
  } else {
    return CustomPaint(
      painter: ArrowPainter(),
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
