import 'package:flutter/material.dart';

// Temp date
import '../test/data.dart';

// Widget
import './alarm_item.dart';

// Services
import '../services/task_service.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  @override
  void initState() {
    TaskService().initForegroundTask();
    TaskService().requestPermissionForAndroid();
    TaskService().startForegroundTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var alarm = data[index];
            return AlarmItem(alarm);
          }),
    );
  }
}
