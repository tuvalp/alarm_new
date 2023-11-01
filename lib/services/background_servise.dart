import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:alarm_clock/services/foreground_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';

class BackgroundService {
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  print("Start");
  Timer.periodic(const Duration(seconds: 15), (timer) async {
    print("background");
    if (DateTime.now().hour == 18 && DateTime.now().minute == 14) {
      ForegroundService().init(1000);
      FlutterForegroundTask.launchApp();
      ForegroundService().startForegroundTask(1000);
      service.invoke("AlarmRing");

      print("clock");
    }
  });

  service.on("AlarmRing").listen((event) {
    Get.toNamed("/alarm_ring");
    print("invok");
  });
}
