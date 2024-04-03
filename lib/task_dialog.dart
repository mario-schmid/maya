import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  void initState() {
    _taskController.text = widget.task!;

    super.initState();
  }

  final _taskController = TextEditingController();

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
            body: Stack(children: [
              Positioned(
                  top: size.width * 0.638888889, // 230
                  left: size.width * 0.055555556, // 20
                  child: Container(
                      height: size.width * 0.388888889, // 140
                      width: size.width * 0.888888889, // 320
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.blue, BlendMode.modulate),
                              image: AssetImage('assets/images/grey.png'),
                              fit: BoxFit.cover),
                          //color: Colors.indigo[700],
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle),
                      child: Stack(children: [
                        Positioned(
                            top: size.width * 0.027777778, // 10
                            left: size.width * 0.027777778, // 10
                            child: SizedBox(
                                height: size.width * 0.194444444, // 70
                                width: size.width * 0.833333334, // 300
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    keyboardType: TextInputType.multiline,
                                    minLines: null,
                                    maxLines: null,
                                    expands: true,
                                    style: const TextStyle(color: Colors.white),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2)),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white54,
                                                width: 1)),
                                        filled: false,
                                        labelText: 'Task'.tr,
                                        labelStyle: const TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w300),
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                    controller: _taskController))),
                        Positioned(
                            top: size.width * 0.25, // 90
                            left: size.width * 0.166666667, // 60
                            child: SizedBox(
                                height: size.width * 0.111111111, // 40
                                width: size.width * 0.333333333, // 120
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.flagCreateChange) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      } else {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(widget.task);
                                      }
                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white),
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white, width: 1)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        textStyle:
                                            MaterialStateProperty.all(const TextStyle(fontSize: 18)),
                                        overlayColor: MaterialStateProperty.all(Colors.indigo[400])),
                                    child: Text('Cancel'.tr)))),
                        Positioned(
                            top: size.width * 0.25, // 90
                            left: size.width * 0.527777778, // 190
                            child: SizedBox(
                                height: size.width * 0.111111111, // 40
                                width: size.width * 0.333333333, // 120
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
                                                    _taskController.text,
                                                    false,
                                                    true,
                                                    0));
                                      } else {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(_taskController.text);
                                      }
                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white),
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white, width: 1)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        textStyle:
                                            MaterialStateProperty.all(const TextStyle(fontSize: 18)),
                                        overlayColor: MaterialStateProperty.all(Colors.indigo[400])),
                                    child: Text('Ok'.tr))))
                      ])))
            ])));
  }
}
