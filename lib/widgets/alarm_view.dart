import 'package:alarm_clock/widgets/alarm_control.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Widget
import './alarm_item.dart';

// Services
import '../services/task_service.dart';
import '../services/alarm_box.dart';
import '../services/alarm_box_item.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  final _myAlarms = Hive.box<AlarmBoxItem>("alarmsBox");

  @override
  void initState() {
    // TaskService().initForegroundTask();
    // TaskService().requestPermissionForAndroid();
    // TaskService().startForegroundTask();
    super.initState();
  }

  void updateState() {
    setState(() {
      print("update");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder(
          valueListenable: _myAlarms.listenable(),
          builder: (context, Box box, _) {
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  var alarm = box.getAt(index);
                  return AlarmItem(alarm, index, updateState);
                });
          }),
    );
  }
}
