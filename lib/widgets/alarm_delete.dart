import 'package:flutter/material.dart';

class AlarmDelete extends StatelessWidget {
  const AlarmDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Center(
        child: IconButton(
          iconSize: 65,
          alignment: Alignment.center,
          onPressed: () => (),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
