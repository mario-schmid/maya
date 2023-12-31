import 'package:flutter/material.dart';

import 'helper/images.dart';
import 'maya_cross_container.dart';

class Cholqij extends StatefulWidget {
  final int cKinIndex;
  const Cholqij({super.key, required this.cKinIndex});

  @override
  State<Cholqij> createState() => _CholqijState();
}

class _CholqijState extends State<Cholqij> {
  late int col;
  late int row;

  @override
  initState() {
    col = widget.cKinIndex ~/ 20;
    row = widget.cKinIndex % 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: InteractiveViewer(
                panEnabled: true, // Set it to false to prevent panning.
                minScale: 1,
                maxScale: 4,
                child: Stack(children: [
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/leaves.jpg"),
                            fit: BoxFit.cover),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: size.width * 1.466666666,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/green.jpg'),
                                      fit: BoxFit.cover),
                                  /*color:
                                      const Color.fromARGB(255, 102, 153, 255),*/
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          size.width * 0.066666667))),
                              child: Row(children: [
                                SizedBox(
                                    width: size.width * 0.066666666,
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: size.width * 0.066666667,
                                            top: size.width * 0.066666667),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 20,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                        ),
                                        itemBuilder: (context, index) {
                                          return signNahual[index];
                                        })),
                                Container(
                                    height: size.width * 1.333333333,
                                    width: size.width * 0.866666666,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue[900]!,
                                            width: size.width * 0.001111111)),
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: size.width * 0.133333333),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 260,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 13,
                                        ),
                                        itemBuilder: (context, index) {
                                          return kinIndex(context, size, index);
                                        })),
                                SizedBox(
                                    width: size.width * 0.066666666,
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: size.width * 0.066666667,
                                            top: size.width * 0.066666667),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 20,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                        ),
                                        itemBuilder: (context, index) {
                                          return signNahual[index];
                                        }))
                              ])))),
                  Positioned(
                      top: size.height / 2 -
                          size.width * 1.466666667 / 2 +
                          size.width * 0.026666666 +
                          size.width / 15 * row,
                      left: size.width * 0.026666666 + size.width / 15 * col,
                      child: IgnorePointer(
                          child: Container(
                              height: size.width * 0.146666667,
                              width: size.width * 0.146666667,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(180, 0, 140, 0),
                                      width: size.width * 0.04),
                                  borderRadius: BorderRadius.circular(
                                      size.width * 0.027777778)))))
                ]))));
  }
}

GestureDetector kinIndex(BuildContext context, Size size, int index) {
  late AssetImage backgroundImage;

  final List<Image> imageToneBlackFlatCenter = [
    Image.asset('assets/images/tones/01_black_flat_center.png'),
    Image.asset('assets/images/tones/02_black_flat_center.png'),
    Image.asset('assets/images/tones/03_black_flat_center.png'),
    Image.asset('assets/images/tones/04_black_flat_center.png'),
    Image.asset('assets/images/tones/05_black_flat_center.png'),
    Image.asset('assets/images/tones/06_black_flat_center.png'),
    Image.asset('assets/images/tones/07_black_flat_center.png'),
    Image.asset('assets/images/tones/08_black_flat_center.png'),
    Image.asset('assets/images/tones/09_black_flat_center.png'),
    Image.asset('assets/images/tones/10_black_flat_center.png'),
    Image.asset('assets/images/tones/11_black_flat_center.png'),
    Image.asset('assets/images/tones/12_black_flat_center.png'),
    Image.asset('assets/images/tones/13_black_flat_center.png')
  ];

  int kinIndex = index % 13 * 20 + index ~/ 13;
  int tone = kinIndex % 13;
  int nahual = kinIndex % 20;
  int colorValue = (kinIndex ~/ 13) % 4;

  switch (colorValue) {
    case 0:
      backgroundImage = const AssetImage('assets/images/cholqij_field_red.jpg');
      break;
    case 1:
      backgroundImage =
          const AssetImage('assets/images/cholqij_field_white.jpg');
      break;
    case 2:
      backgroundImage =
          const AssetImage('assets/images/cholqij_field_blue.jpg');
      break;
    case 3:
      backgroundImage =
          const AssetImage('assets/images/cholqij_field_yellow.jpg');
      break;
  }

  BoxDecoration boxDecoration = BoxDecoration(
    image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
    //color: backgroundColor,
    border:
        Border.all(color: Colors.blue[900]!, width: size.width * 0.001111111),
  );

  TextStyle textStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: size.width * 0.019,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  return GestureDetector(
      onTap: () {
        showDialog<void>(
            context: context,
            //barrierDismissible: true,
            builder: (BuildContext context) {
              return Center(child: mayaCrossContainer(size, tone, nahual));
            });
      },
      child: Container(
          decoration: boxDecoration,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
                width: size.width * 0.052,
                child: imageToneBlackFlatCenter[tone]),
            Text('${kinIndex + 1}', style: textStyle)
          ])));
}
