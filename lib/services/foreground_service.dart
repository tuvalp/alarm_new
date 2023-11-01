import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
void foregroundCallBack() {
  FlutterForegroundTask.setTaskHandler(ForegroundHandler());
}

class ForegroundHandler extends TaskHandler {
  SendPort? _sendPort;
  int newAlarm = 0;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    if (newAlarm > 0) {
      FlutterForegroundTask.wakeUpScreen();
      FlutterForegroundTask.setOnLockScreenVisibility(true);
      FlutterForegroundTask.launchApp("/alarm_ring");
      _sendPort?.send("message");
    }

    newAlarm++;
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}

  @override
  void onNotificationPressed() {}
}

class ForegroundService {
  ReceivePort? _receivePort;

  Future init(interval) async {
    FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
            channelId: "Alarms", channelName: "Alarms", isSticky: false),
        iosNotificationOptions: const IOSNotificationOptions(
            playSound: false, showNotification: false),
        foregroundTaskOptions: ForegroundTaskOptions(
            allowWakeLock: true,
            allowWifiLock: true,
            autoRunOnBoot: true,
            isOnceEvent: false,
            interval: interval));
  }

  void permission() {
    FlutterForegroundTask.requestNotificationPermission();
    FlutterForegroundTask.requestIgnoreBatteryOptimization();
    FlutterForegroundTask.openSystemAlertWindowSettings();

    Permission.notification.request();
    Permission.criticalAlerts.request();
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }

    _closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      Get.toNamed("/alarm_ring");
    });

    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }

  Future<bool> startForegroundTask(time) async {
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort);
    if (!isRegistered) {
      return false;
    }

    String formatMillisecondsToTime(int milliseconds) {
      final duration = Duration(milliseconds: milliseconds);

      final format = DateFormat('HH:mm');

      final formattedTime = format.format(DateTime.now().add(duration));

      return formattedTime;
    }

    var nextAlarm = formatMillisecondsToTime(time);

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Alarm',
        notificationText: 'your next alarm is in $nextAlarm',
        callback: foregroundCallBack,
      );
    }
  }

  Future<bool> stopForegroundTask() {
    return FlutterForegroundTask.stopService();
  }
}
