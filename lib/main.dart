import 'package:alarm_clock/services/alarm_box_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Screens
import './services/route_service.dart';

// Service
import './services/task_service.dart';

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Iintilzaing Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmBoxItemAdapter());
  await Hive.openBox<AlarmBoxItem>("alarmsBox");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF5F5F5),
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const AlarmClock());
}

class AlarmClock extends StatelessWidget {
  const AlarmClock({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: MaterialApp(
        title: 'Alarm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          primaryColor: Colors.blue,
          // colorScheme: const ColorScheme.light(
          //     primary: Colors.blue, background: Color(0xFFF5F5F5)),
          // useMaterial3: true,
        ),
        initialRoute: "/",
        routes: RouteService().route,
      ),
    );
  }
}
