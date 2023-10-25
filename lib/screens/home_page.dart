import 'package:flutter/material.dart';

// Widgets
import '../widgets/alarm_view.dart';
import '../widgets/alarm_control.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  FloatingActionButton addAlarmButton(context) => FloatingActionButton(
        onPressed: (() {
          //Navigator.pushNamed(context, "/alarm_ring");
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) => const ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: AlarmCntorl(),
            ),
          );
        }),
        child: const Icon(Icons.alarm_add),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AlarmView(),
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
