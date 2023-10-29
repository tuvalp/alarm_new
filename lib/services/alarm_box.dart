import 'package:hive_flutter/hive_flutter.dart';

import './alarm_box_item.dart';
import './foreground_service.dart';

class AlarmBoxService {
  final alarmBox = Hive.box<AlarmBoxItem>("alarmsBox");

  static int getMillisecondsToAlarm(DateTime now, DateTime alarmTime) {
    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    int milliseconds = alarmTime.difference(now).inMilliseconds;
    return milliseconds;
  }

  void setAlarms() async {
    var timeList = [];
    await ForegroundService().stopForegroundTask();

    for (var index = 0; index < alarmBox.length; index++) {
      var alarm = alarmBox.getAt(index);
      if (alarm!.isActive == true) {
        var milliseconds = getMillisecondsToAlarm(DateTime.now(), alarm.time);
        timeList.add(milliseconds);
      }
    }

    timeList.sort();
    if (timeList.isNotEmpty) {
      print(timeList);
      ForegroundService().init(timeList[0]);
      await ForegroundService().startForegroundTask(timeList[0]);
    }
  }

  void setSnooz() async {
    await ForegroundService().stopForegroundTask();
    ForegroundService().init(180000);
    await ForegroundService().startForegroundTask(180000);
  }

  void Add(AlarmBoxItem alarm) {
    alarmBox.add(alarm);
    setAlarms();
  }

  void Update(AlarmBoxItem alarm, index) {
    alarmBox.putAt(index, alarm);
    setAlarms();
  }

  void Delete(index) {
    alarmBox.deleteAt(index);
    setAlarms();
  }
}
