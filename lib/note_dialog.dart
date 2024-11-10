import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../helper/maya_style.dart';
import '../maya_items.dart';
import '../providers/dayitems.dart';

class NoteDialog extends StatefulWidget {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final String? note;
  final bool flagCreateChange;
  const NoteDialog(
      {super.key,
      required this.mainColor,
      required this.yearIndex,
      required this.dayIndex,
      required this.note,
      required this.flagCreateChange});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  @override
  void initState() {
    _noteController.text = widget.note!;

    super.initState();
  }

  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
                alignment: const Alignment(0, -0.9),
                child: SizedBox(
                    child: Container(
                        height: size.width * 0.98,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.green, BlendMode.modulate),
                                image: AssetImage(
                                    'assets/images/bg_pattern_one.jpg'),
                                fit: BoxFit.cover),
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle),
                        child: Padding(
                            padding: EdgeInsets.all(size.width * 0.028),
                            child: SizedBox(
                                child: Column(children: [
                              SizedBox(
                                  height: size.width * 0.79,
                                  child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      keyboardType: TextInputType.multiline,
                                      minLines: null,
                                      maxLines: null,
                                      expands: true,
                                      style: const TextStyle(
                                          color: Colors.white),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: size.width * 0.036,
                                              horizontal: size.width * 0.03),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 2)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54,
                                                      width: 1)),
                                          filled: false,
                                          labelText: 'Note'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w300),
                                          floatingLabelStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300)),
                                      controller: _noteController)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.028,
                                            right: size.width * 0.028),
                                        child: SizedBox(
                                            height: size.width * 0.1,
                                            width: size.width * 0.3,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (widget.flagCreateChange) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  } else {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop([false]);
                                                  }
                                                },
                                                style: MayaStyle()
                                                    .transparentButtonStyle(
                                                        Colors.green[400]),
                                                child: Text('Cancel'.tr)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.028),
                                        child: SizedBox(
                                            height: size.width * 0.1,
                                            width: size.width * 0.3,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (widget.flagCreateChange) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    Provider.of<DayItems>(
                                                            context,
                                                            listen: false)
                                                        .add(
                                                            widget.yearIndex,
                                                            widget.dayIndex,
                                                            MayaItems(
                                                                    mainColor:
                                                                        widget
                                                                            .mainColor,
                                                                    yearIndex:
                                                                        widget
                                                                            .yearIndex,
                                                                    dayIndex: widget
                                                                        .dayIndex,
                                                                    newListItem:
                                                                        true,
                                                                    index: 0)
                                                                .note(
                                                                    _noteController
                                                                        .text));
                                                  } else {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop([
                                                      true,
                                                      _noteController.text
                                                    ]);
                                                  }
                                                },
                                                style: MayaStyle()
                                                    .transparentButtonStyle(
                                                        Colors.green[400]),
                                                child: Text('Save'.tr))))
                                  ])
                            ]))))))));
  }
}
