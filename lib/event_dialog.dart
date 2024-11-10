import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../helper/maya_style.dart';
import '../maya_items.dart';
import '../providers/dayitems.dart';
import '../time_format.dart';

class EventDialog extends StatefulWidget {
  final Color mainColor;
  final int yearIndex;
  final int dayIndex;
  final String begin;
  final String end;
  final String title;
  final String description;
  final bool flagCreateChange;
  const EventDialog(
      {super.key,
      required this.mainColor,
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
            _time = '$_hour:$_minute $_period';
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
            _time = '$_hour:$_minute';
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
            _time = '$_hour:$_minute $_period';
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
            _time = '$_hour:$_minute';
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
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
                alignment: const Alignment(0, -0.9),
                child: Container(
                    height: size.width * 0.98,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.orange, BlendMode.modulate),
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
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: size.width * 0.028),
                            child: SizedBox(
                                height: size.width * 0.14,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: size.width * 0.266,
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.046),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.width * 0.034,
                                                      horizontal:
                                                          size.width * 0.03),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.white,
                                                              width: 2)),
                                                  enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white54,
                                                          width: 1)),
                                                  filled: false,
                                                  labelText: 'Beginning'.tr,
                                                  labelStyle: const TextStyle(
                                                      color: Colors.white54,
                                                      fontWeight: FontWeight.w300),
                                                  floatingLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                                              controller: _timeBeginController)),
                                      IconButton(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.028,
                                              right: size.width * 0.028),
                                          icon: SvgPicture.asset(
                                            "assets/vector/clock_icon.svg",
                                            height: size.width * 0.11,
                                          ),
                                          onPressed: () {
                                            _selectBeginTime(context);
                                          }),
                                      SizedBox(
                                          width: size.width * 0.266,
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.046),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.width * 0.034,
                                                      horizontal:
                                                          size.width * 0.03),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2)),
                                                  enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white54,
                                                          width: 1)),
                                                  filled: false,
                                                  labelText: 'End'.tr,
                                                  labelStyle: const TextStyle(
                                                      color: Colors.white54,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  floatingLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                                              controller: _timeEndController)),
                                      IconButton(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.028),
                                          icon: SvgPicture.asset(
                                            "assets/vector/clock_icon.svg",
                                            height: size.width * 0.11,
                                          ),
                                          onPressed: () {
                                            _selectEndTime(context);
                                          })
                                    ])),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.width * 0.028),
                              child: SizedBox(
                                  height: size.width * 0.14,
                                  child: TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: size.width * 0.036,
                                              horizontal: size.width * 0.03),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white54,
                                                      width: 1)),
                                          filled: false,
                                          labelText: 'Title'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w300),
                                          floatingLabelStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300)),
                                      controller: _titleController))),
                          SizedBox(
                              height: size.width * 0.454,
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
                                          vertical: size.width * 0.036,
                                          horizontal: size.width * 0.03),
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
                                  controller: _descriptionController)),
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
                                                    Colors.amber[400]),
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
                                                        MayaItems(
                                                                mainColor: widget
                                                                    .mainColor,
                                                                yearIndex:
                                                                    widget
                                                                        .yearIndex,
                                                                dayIndex: widget
                                                                    .dayIndex,
                                                                newListItem:
                                                                    true,
                                                                index: 0)
                                                            .event(
                                                                _timeBeginController
                                                                    .text,
                                                                _timeEndController
                                                                    .text,
                                                                _titleController
                                                                    .text,
                                                                _descriptionController
                                                                    .text));
                                              } else {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop([
                                                  true,
                                                  [
                                                    _timeBeginController.text,
                                                    _timeEndController.text,
                                                    _titleController.text,
                                                    _descriptionController.text
                                                  ]
                                                ]);
                                              }
                                            },
                                            style: MayaStyle()
                                                .transparentButtonStyle(
                                                    Colors.amber[400]),
                                            child: Text('Save'.tr))))
                              ])
                        ])))))));
  }
}
