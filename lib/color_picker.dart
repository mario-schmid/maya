import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorPicker extends StatefulWidget {
  final Color mainColor;
  const ColorPicker({super.key, required this.mainColor});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color mainColor;
  final CircleColorPickerController _controller = CircleColorPickerController();

  @override
  void initState() {
    mainColor = widget.mainColor;
    _controller.color = mainColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleColorPicker(
                  controller: _controller,
                  //onChanged: (color) => mainColor = color,
                  onEnded: (color) => mainColor = color,
                  size: Size(size.width * 0.8, size.width * 0.8),
                  strokeWidth: size.width * 0.03,
                  thumbSize: size.width * 0.14),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: size.width * 0.111111111, // 40
                    width: size.width * 0.333333333, // 120
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(widget.mainColor);
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                                mainColor.withOpacity(0.5)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.white,
                              width: 1,
                            )),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 18)),
                            overlayColor: MaterialStateProperty.all(mainColor)),
                        child: Text('Cancel'.tr))),
                SizedBox(width: size.width * 0.06),
                SizedBox(
                    height: size.width * 0.111111111, // 40
                    width: size.width * 0.333333333, // 120
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(mainColor);
                          saveMainColor(mainColor.value.toString());
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                                mainColor.withOpacity(0.5)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.white,
                              width: 1,
                            )),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 18)),
                            overlayColor: MaterialStateProperty.all(mainColor)),
                        child: Text('OK'.tr)))
              ])
            ])));
  }
}

saveMainColor(mainColor) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'mainColor';
  prefs.setString(key, mainColor);
}
