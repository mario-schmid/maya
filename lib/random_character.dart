import 'package:flutter/material.dart';
import 'package:maya/helper/maya_images.dart';

class RandomCharacter extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final int tone;
  final int nahual;
  const RandomCharacter(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.tone,
      required this.nahual});

  @override
  State<RandomCharacter> createState() => _RandomCharacterState();
}

class _RandomCharacterState extends State<RandomCharacter>
    with TickerProviderStateMixin {
  late Color color;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this, value: 0.2);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _controller.forward();

    int value = widget.nahual % 4;
    switch (value) {
      case 0:
        color = Color(0xffb30000);
        break;
      case 1:
        color = Color(0xffb3b3b3);
        break;
      case 2:
        color = Color(0xff001eb3);
        break;
      case 3:
        color = Color(0xffb3b300);
        break;
      default:
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: Stack(children: [
            Center(
              child: SizedBox(
                  height: size.width * 0.72,
                  width: size.width * 0.72,
                  child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 22,
                    strokeCap: StrokeCap.round,
                  )),
            ),
            Center(
              child: GestureDetector(
                  child: ScaleTransition(
                scale: _animation,
                child: SizedBox(
                    width: size.width * 0.3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: size.width * 0.3 / 1.142857143,
                              child: MayaImages()
                                  .imageToneWhiteCurved[widget.tone]),
                          SizedBox(height: size.width * 0.01),
                          MayaImages().signNahual[widget.nahual]
                        ])),
              )),
            )
          ])),
    );
  }
}
