import 'package:flutter/material.dart';

// Widgets
import '../widgets/alarm_view.dart';
import '../widgets/alarm_control.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  FloatingActionButton addAlarmButton(context) => FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            isDismissible: false,
            showDragHandle: false,
            context: context,
            builder: (context) => const ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: AlarmContorl(),
            ),
          );
        }),
        child: const Icon(Icons.alarm_add),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          leading: IconButton(
            onPressed: () => (),
            color: Colors.blue,
            iconSize: 40,
            icon: const Icon(Icons.account_circle),
          ),
          actions: [
            IconButton(
              onPressed: () => (),
              color: Colors.grey,
              iconSize: 40,
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: const AlarmView(),
        floatingActionButton: addAlarmButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
