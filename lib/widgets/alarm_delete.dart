import 'package:flutter/material.dart';

// Service
import '../services/alarm_box.dart';

class AlarmDelete extends StatelessWidget {
  final int index;
  AlarmBoxService alarmBoxService = AlarmBoxService();
  AlarmDelete(this.index);

  void onDeleteClick(context) {
    alarmBoxService.Delete(index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: IconButton(
          iconSize: 65,
          alignment: Alignment.center,
          onPressed: () => onDeleteClick(context),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
