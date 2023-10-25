import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

// Tamp date obj
import '../test/data.dart';

class AlarmCntorl extends StatefulWidget {
  final Data? alarm;
  final bool? updateMode;

  const AlarmCntorl([this.alarm, this.updateMode]);

  @override
  State<AlarmCntorl> createState() => _AlarmCntorlState(alarm, updateMode);
}

class _AlarmCntorlState extends State<AlarmCntorl> {
  final Data? alarm;
  final bool? updateMode;
  _AlarmCntorlState([this.alarm, this.updateMode]);

  TextEditingController noteController = TextEditingController(text: "Note");
  int id = DateTime.now().microsecondsSinceEpoch;
  DateTime time = DateTime.now().add(const Duration(minutes: 1));
  String note = "";
  bool isActive = true;

  @override
  void initState() {
    print(id);
    if (updateMode == true) {
      id = alarm!.id;
      time = alarm!.time;
      note = alarm!.note;
      isActive = alarm!.isActive;

      if (alarm!.note.isNotEmpty) {
        noteController = TextEditingController(text: alarm!.note);
      }
    }
    super.initState();
  }

  void onCloseButton() {
    Navigator.of(context).pop();
  }

  void onCheakButton() {
    var courentAlarm = Data(id: id, isActive: isActive, note: note, time: time);
    print(courentAlarm.toString());

    if (updateMode == true) {
    } else {
      data.add(courentAlarm);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 500,
        color: Colors.white,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,

          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const SizedBox(height: 30),
            Expanded(
              flex: 2,
              child: TimePickerSpinner(
                time: time,
                is24HourMode: true,
                isForce2Digits: true,
                itemHeight: 60,
                spacing: 35,
                onTimeChange: (newTime) => setState(() {
                  time = newTime.copyWith(second: 0);
                }),
                normalTextStyle:
                    const TextStyle(fontSize: 38, fontWeight: FontWeight.w300),
                highlightedTextStyle: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Switch(
                              value: isActive,
                              onChanged: (value) {
                                setState(() {
                                  isActive = !isActive;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Note",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextField(
                            controller: noteController,
                            onChanged: (value) => setState(() {
                                  note = noteController.text;
                                }),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.blue),
                            decoration:
                                const InputDecoration.collapsed(hintText: "")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => onCloseButton(),
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () => onCheakButton(),
                    icon: const Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.blue,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
