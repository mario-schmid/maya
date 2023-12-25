import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maya/time_format.dart';
import 'package:provider/provider.dart';

import 'items.dart';
import 'providers/dayitems.dart';

class EventDialog extends StatefulWidget {
  final int yearIndex;
  final int dayIndex;
  final String begin;
  final String end;
  final String title;
  final String description;
  final bool flagCreateChange;
  const EventDialog(
      {super.key,
      required this.yearIndex,
      required this.dayIndex,
      required this.begin,
      required this.end,
      required this.title,
      required this.description,
      required this.flagCreateChange});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  String _hour = '', _minute = '', _time = '', _period = '';

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  @override
  initState() {
    _timeBeginController.text = widget.begin;
    _timeEndController.text = widget.end;
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;

    super.initState();
  }

  Future<void> _selectBeginTime(BuildContext context) async {
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (context, Widget? child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!);
            });
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _period = selectedTime.period.name;
            _time = '$_hour : $_minute $_period';
            _timeBeginController.text = _time;
          });
        }
        break;
      case 'HH:mm:ss':
        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (context, Widget? child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!);
            });
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _time = '$_hour : $_minute';
            _timeBeginController.text = _time;
          });
        }
        break;
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    switch (TimeFormat().getTimeFormat.pattern) {
      case 'h:mm a':
        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (context, Widget? child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!);
            });
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _period = selectedTime.period.name;
            _time = '$_hour : $_minute $_period';
            _timeEndController.text = _time;
          });
        }
        break;
      case 'HH:mm:ss':
        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (context, Widget? child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!);
            });
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString().padLeft(2, '0');
            _minute = selectedTime.minute.toString().padLeft(2, '0');
            _time = '$_hour : $_minute';
            _timeEndController.text = _time;
          });
        }
        break;
    }
  }

  final _timeBeginController = TextEditingController();
  final _timeEndController = TextEditingController();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _timeBeginController.dispose();
    _timeEndController.dispose();

    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.055555556,
                    size.width * 0.055555556, size.width * 0.055555556, 0),
                child: Container(
                    height: size.width * 0.972222222, // 350
                    width: size.width * 0.888888889, // 320
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/images/orange.jpg'),
                            fit: BoxFit.cover),
                        //color: Colors.amber[700],
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle),
                    child: Stack(children: [
                      Positioned(
                          top: size.width * 0.027777778, // 10
                          left: size.width * 0.027777778, // 10
                          child: SizedBox(
                              height: size.width * 0.138888889, // 50
                              width: size.width * 0.25, // 90
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: size.width * 0.011111111),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white54, width: 1)),
                                      filled: false,
                                      labelText: 'Beginning'.tr,
                                      labelStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w300),
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                  controller: _timeBeginController))),
                      Positioned(
                          top: 2, // 2
                          left: size.width * 0.269444444, // 97
                          child: IconButton(
                              icon: Icon(Icons.schedule,
                                  size: size.width * 0.138888889,
                                  color: Colors.white),
                              onPressed: () {
                                _selectBeginTime(context);
                              })),
                      Positioned(
                          top: size.width * 0.027777778, // 10
                          left: size.width * 0.444444444, // 160
                          child: SizedBox(
                              height: size.width * 0.138888889, // 50
                              width: size.width * 0.25, // 90
                              child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: size.width * 0.011111111),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white54, width: 1)),
                                      filled: false,
                                      labelText: 'End'.tr,
                                      labelStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w300),
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                  controller: _timeEndController))),
                      Positioned(
                          top: 2, // 2
                          left: size.width * 0.686111111, // 247
                          child: IconButton(
                              icon: Icon(Icons.schedule,
                                  size: size.width * 0.138888889,
                                  color: Colors.white),
                              onPressed: () {
                                _selectEndTime(context);
                              })),
                      Positioned(
                          top: size.width * 0.194444444, // 70
                          left: size.width * 0.027777778, // 10
                          child: SizedBox(
                              height: size.width * 0.138888889, // 50
                              width: size.width * 0.833333334, // 300
                              child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white54, width: 1)),
                                      filled: false,
                                      labelText: 'Title'.tr,
                                      labelStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w300),
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                  controller: _titleController))),
                      Positioned(
                          top: size.width * 0.361111111, // 130
                          left: size.width * 0.027777778, // 10
                          child: SizedBox(
                              height: size.width * 0.444444444, // 160
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
                                              color: Colors.white54, width: 1)),
                                      filled: false,
                                      labelText: 'Description'.tr,
                                      labelStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w300),
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                  controller: _descriptionController))),
                      Positioned(
                          top: size.width * 0.833333333, // 300
                          left: size.width * 0.166666667, // 60
                          child: SizedBox(
                            height: size.width * 0.111111111, // 40
                            width: size.width * 0.333333333, // 120
                            child: ElevatedButton(
                                onPressed: () {
                                  if (widget.flagCreateChange) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  } else {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop([
                                      widget.begin,
                                      widget.end,
                                      widget.title,
                                      widget.description
                                    ]);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Colors.white, width: 1)),
                                    shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(fontSize: 20)),
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.amber[400])),
                                child: Text('Cancel'.tr)),
                          )),
                      Positioned(
                          top: size.width * 0.833333333, // 300
                          left: size.width * 0.527777778, // 190
                          child: SizedBox(
                              height: size.width * 0.111111111, // 40
                              width: size.width * 0.333333333, // 120
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (widget.flagCreateChange) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      Provider.of<DayItems>(context,
                                              listen: false)
                                          .add(
                                              widget.yearIndex,
                                              widget.dayIndex,
                                              eventItem(
                                                  widget.yearIndex,
                                                  widget.dayIndex,
                                                  _timeBeginController.text,
                                                  _timeEndController.text,
                                                  _titleController.text,
                                                  _descriptionController.text,
                                                  true,
                                                  0));
                                    } else {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop([
                                        _timeBeginController.text,
                                        _timeEndController.text,
                                        _titleController.text,
                                        _descriptionController.text
                                      ]);
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
                                            color: Colors.white, width: 1),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      textStyle: MaterialStateProperty.all(
                                          const TextStyle(fontSize: 20)),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.amber[400])),
                                  child: Text('Ok'.tr))))
                    ])))));
  }
}
