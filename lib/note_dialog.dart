import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'items.dart';
import 'providers/dayitems.dart';

class NoteDialog extends StatefulWidget {
  final int yearIndex;
  final int dayIndex;
  final String? note;
  final bool flagCreateChange;
  const NoteDialog(
      {super.key,
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
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Stack(children: [
              Positioned(
                  top: size.width * 0.055555556, // 20
                  left: size.width * 0.055555556, // 20
                  child: Container(
                      height: size.width * 0.972222222, // 350
                      width: size.width * 0.888888889, // 320
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/green.jpg'),
                              fit: BoxFit.cover),
                          //color: Colors.green[700],
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle),
                      child: Stack(children: [
                        Positioned(
                            top: size.width * 0.027777778, // 10
                            left: size.width * 0.027777778, // 10
                            child: SizedBox(
                                height: size.width * 0.777777778, // 280
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
                                        labelText: 'Note'.tr,
                                        labelStyle: const TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w300),
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                    controller: _noteController))),
                        Positioned(
                            top: size.width * 0.833333333, // 300
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
                                            .pop(widget.note);
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                        )),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 20)),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.green[400])),
                                    child: Text('Cancel'.tr)))),
                        Positioned(
                            top: size.width * 0.833333333, // 300
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
                                                noteItem(
                                                    widget.yearIndex,
                                                    widget.dayIndex,
                                                    _noteController.text,
                                                    true,
                                                    0));
                                      } else {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(_noteController.text);
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
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
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 20)),
                                        overlayColor:
                                            MaterialStateProperty.all(Colors.green[400])),
                                    child: Text('Ok'.tr))))
                      ])))
            ])));
  }
}
