import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maya/helper/maya_style.dart';
import 'package:provider/provider.dart';

import 'items.dart';
import 'providers/dayitems.dart';

class TaskDialog extends StatefulWidget {
  final int yearIndex;
  final int dayIndex;
  final String? task;
  final bool flagCreateChange;
  const TaskDialog(
      {super.key,
      required this.yearIndex,
      required this.dayIndex,
      required this.task,
      required this.flagCreateChange});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _taskController = TextEditingController();

  @override
  void initState() {
    _taskController.text = widget.task!;

    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
                alignment: const Alignment(0, -0.194),
                child: Container(
                    height: size.width * 0.39,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.blue, BlendMode.modulate),
                            image:
                                AssetImage('assets/images/bg_pattern_one.jpg'),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Padding(
                        padding: EdgeInsets.all(size.width * 0.028),
                        child: SizedBox(
                            child: Column(children: [
                          SizedBox(
                              height: size.width * 0.19,
                              child: TextField(
                                  textAlignVertical: TextAlignVertical.top,
                                  keyboardType: TextInputType.multiline,
                                  minLines: null,
                                  maxLines: null,
                                  expands: true,
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.064,
                                          horizontal: size.width * 0.03),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white54, width: 1)),
                                      filled: false,
                                      labelText: 'Task'.tr,
                                      labelStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w300),
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                  controller: _taskController)),
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
                                                .dialogButtonStyle(
                                                    Colors.indigo[400]),
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
                                                Provider.of<DayItems>(context,
                                                        listen: false)
                                                    .add(
                                                        widget.yearIndex,
                                                        widget.dayIndex,
                                                        taskItem(
                                                            widget.yearIndex,
                                                            widget.dayIndex,
                                                            _taskController
                                                                .text,
                                                            false,
                                                            true,
                                                            0));
                                              } else {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop([
                                                  true,
                                                  _taskController.text
                                                ]);
                                              }
                                            },
                                            style: MayaStyle()
                                                .dialogButtonStyle(
                                                    Colors.indigo[400]),
                                            child: Text('Save'.tr))))
                              ])
                        ])))))));
  }
}
