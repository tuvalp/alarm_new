import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// temp Date item
import '../test/data.dart';

// Widget
import './alarm_control.dart';
import './alarm_delete.dart';

class AlarmItem extends StatelessWidget {
  final Data alarm;

  const AlarmItem(this.alarm, {super.key});

  void moreButtonClick(context) {
    showModalBottomSheet(context: context, builder: (context) => AlarmDelete());
  }

  void itemClick(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: AlarmCntorl(alarm, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => itemClick(context),
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(bottom: 15, top: 15, right: 5, left: 25),
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('HH:mm').format(alarm.time),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    )),
                alarm.note != ""
                    ? Text(alarm.note,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey,
                        ))
                    : Container(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Switch(
                  value: alarm.isActive,
                  onChanged: (value) {},
                ),
                IconButton(
                    onPressed: () => moreButtonClick(context),
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
