import 'package:flutter/material.dart';
import './timer/timer.dart';

class TimerScreens extends StatelessWidget {
  const TimerScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimerW(),
        TimerW(),
        TimerW(),
      ],
    );
  }
}
