import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';

import '../helper/maya_style.dart';
import '../helper/shared_prefs.dart';

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
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleColorPicker(
              controller: _controller,
              onEnded: (color) => mainColor = color,
              size: Size(size.width * 0.8, size.width * 0.8),
              strokeWidth: size.width * 0.03,
              thumbSize: size.width * 0.14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.111111111,
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop(widget.mainColor);
                    },
                    style: MayaStyle().settingsButtonStyleRadish(
                      size,
                      widget.mainColor,
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: TextStyle(fontSize: size.width * 0.046),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),
                SizedBox(
                  height: size.width * 0.111111111,
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(mainColor);
                      SharedPrefs.saveMainColor(
                        '0x${mainColor.toARGB32().toRadixString(16)}',
                      );
                    },
                    style: MayaStyle().settingsButtonStyleRadish(
                      size,
                      widget.mainColor,
                    ),
                    child: Text(
                      'Save'.tr,
                      style: TextStyle(fontSize: size.width * 0.046),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
