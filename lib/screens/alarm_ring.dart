import 'package:flutter/material.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../services/alarm_box.dart';

class AlarmRingScreen extends StatefulWidget {
  const AlarmRingScreen({super.key});

  @override
  State<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends State<AlarmRingScreen> {
  @override
  void initState() {
    ringtonePlay();
    super.initState();
  }

  void ringtonePlay() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.alarm,
      looping: true,
      volume: 1,
      asAlarm: true,
    );

    Vibration.vibrate(pattern: [500, 3000], duration: 60000);
  }

  void onStopButtonClick() {
    AlarmBoxService().setAlarms();
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    Get.toNamed("/");
  }

  void onSnozButtonClick() {
    AlarmBoxService().setSnooz();
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    Get.toNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yMMMMEEEEd').format(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 82, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            Flexible(
                child: Center(
              child: TextButton(
                onPressed: () => onSnozButtonClick(),
                child: Container(
                  width: 170,
                  height: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(color: Colors.blue, width: 2),
                    color: Colors.transparent,
                  ),
                  child: const Text(
                    "Snooz",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ),
            )),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 150),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    padding: const EdgeInsets.all(10),
                    textStyle: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w200),
                  ),
                  child: const Text(
                    "Stop",
                  ),
                  onPressed: () => onStopButtonClick(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
