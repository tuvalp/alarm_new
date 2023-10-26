import 'package:hive_flutter/hive_flutter.dart';
import './alarm_box_item.dart';

class AlarmBoxService {
  final alarmBox = Hive.box<AlarmBoxItem>("alarmsBox");

  void Add(AlarmBoxItem alarm) {
    alarmBox.add(alarm);
  }

  void Update(AlarmBoxItem alarm, index) {
    alarmBox.putAt(index, alarm);
  }

  void Delete(index) {
    alarmBox.deleteAt(index);
  }
}
