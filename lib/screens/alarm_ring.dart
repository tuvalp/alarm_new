import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

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
    //Vibration.vibrate(duration: 60000);
  }

  void onStopButtonClick() {
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    Navigator.pop(context);
  }

  void onSnozButtonClick() {}

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
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    color: Colors.blue,
                  ),
                  child: const Text(
                    "Snoz",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )),
            Flexible(
              // child: Align(
              //   alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(top: 200),
                width: double.infinity,
                child: OutlinedButton(
                  child: const Text("Stop",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
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
