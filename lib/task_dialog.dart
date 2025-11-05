import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../data/maya_day.dart';
import '../data/maya_location.dart';
import '../database_handler.dart';
import '../helper/maya_style.dart';
import '../providers/mayadata.dart';

class TaskDialog extends StatefulWidget {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final int? elementIndex;
  final String description;
  final bool create;
  const TaskDialog({
    super.key,
    required this.mainColor,
    required this.yearIndex,
    required this.dayIndex,
    required this.elementIndex,
    required this.description,
    required this.create,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _taskController = TextEditingController();

  @override
  void initState() {
    _taskController.text = widget.description;

    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
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
          alignment: const Alignment(0, -0.194),
          child: Container(
            height: size.width * 0.39,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              image: const DecorationImage(
                colorFilter: ColorFilter.mode(Colors.blue, BlendMode.modulate),
                image: AssetImage('assets/images/bg_pattern_one.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.028),
              child: SizedBox(
                child: Column(
                  children: [
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
                            horizontal: size.width * 0.03,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1,
                            ),
                          ),
                          filled: false,
                          labelText: 'Task'.tr,
                          labelStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        controller: _taskController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.width * 0.028,
                            right: size.width * 0.028,
                          ),
                          child: SizedBox(
                            height: size.width * 0.1,
                            width: size.width * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              },
                              style: MayaStyle().transparentButtonStyle(
                                Colors.indigo[400],
                              ),
                              child: Text('Cancel'.tr),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 0.028),
                          child: SizedBox(
                            height: size.width * 0.1,
                            width: size.width * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.create) {
                                  final String uuid = Uuid().v1();
                                  final MayaData data = MayaData();

                                  data.mayaData[widget.yearIndex] ??=
                                      <int, Day>{};

                                  final Day dayData;
                                  if (data.mayaData[widget.yearIndex]![widget
                                          .dayIndex] ==
                                      null) {
                                    data.mayaData[widget.yearIndex]![widget
                                            .dayIndex] =
                                        Day();
                                    dayData =
                                        data.mayaData[widget.yearIndex]![widget
                                            .dayIndex]!;
                                    DatabaseHandlerArrangements()
                                        .insertArrangement(
                                          widget.yearIndex,
                                          widget.dayIndex,
                                          '',
                                        );
                                  } else {
                                    dayData =
                                        data.mayaData[widget.yearIndex]![widget
                                            .dayIndex]!;
                                  }

                                  final int eIndex = dayData.taskList.length;

                                  dayData.arrangement.add(
                                    Location('task', eIndex),
                                  );

                                  List<Map<String, dynamic>> arrangementMaps =
                                      dayData.arrangement
                                          .map(
                                            (arrangement) =>
                                                arrangement.toJson(),
                                          )
                                          .toList();

                                  DatabaseHandlerArrangements()
                                      .updateArrangement(
                                        widget.yearIndex,
                                        widget.dayIndex,
                                        jsonEncode(arrangementMaps),
                                      );

                                  Provider.of<MayaData>(
                                    context,
                                    listen: false,
                                  ).addTask(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    uuid,
                                    _taskController.text,
                                  );

                                  DatabaseHandlerTasks().insertTask(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    eIndex,
                                    uuid,
                                    _taskController.text,
                                    false,
                                  );

                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                } else {
                                  Provider.of<MayaData>(
                                    context,
                                    listen: false,
                                  ).updateTask(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    _taskController.text,
                                  );

                                  DatabaseHandlerTasks().updateTaskDescription(
                                    widget.yearIndex,
                                    widget.dayIndex,
                                    widget.elementIndex!,
                                    _taskController.text,
                                  );

                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                }
                              },
                              style: MayaStyle().transparentButtonStyle(
                                Colors.indigo[400],
                              ),
                              child: Text('Save'.tr),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
