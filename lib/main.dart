import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

// Screens
import '../screens/home_page.dart';
import '../screens/alarm_ring.dart';

// Service
import './services/alarm_box_item.dart';
import './services/foreground_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Iintilzaing Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmBoxItemAdapter());
  await Hive.openBox<AlarmBoxItem>("alarmsBox");
  ForegroundService().permission();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF5F5F5),
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const AlarmClock());
}

class AlarmClock extends StatelessWidget {
  const AlarmClock({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alarm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/alarm_ring", page: () => const AlarmRingScreen()),
      ],
      // routes: {
      //   "/": (context) => const HomeScreen(),
      //   "/alarm_ring": (context) => const AlarmRingScreen(),
      // },
    );
  }
}
