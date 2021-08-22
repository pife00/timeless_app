import 'package:background/models/timers.dart';
import 'package:flutter/material.dart';
import './widget_local/timer.dart';
import 'package:provider/provider.dart';
import '../provider/timers_provider.dart';

class TimerScreens extends StatefulWidget {
  @override
  _TimerScreensState createState() => _TimerScreensState();
}

class _TimerScreensState extends State<TimerScreens> {
  int _currentTimers = 4;

  void addNewTimer() {
    setState(() {
      _currentTimers++;
    });
    final pcs = Provider.of<TimerProvider>(context);

    String name = 'PC' + (_currentTimers).toString();

    var newTimer = Timers(name: name);
    pcs.addTimer(newTimer);
  }

  @override
  Widget build(BuildContext context) {
    final pcs = Provider.of<TimerProvider>(context);
    final computers = pcs.items;
    return Scaffold(
      body: ListView(
          padding: EdgeInsets.all(2),
          children: computers.map((el) {
            return TimerW(el.name);
          }).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTimer,
        backgroundColor: Colors.indigo[600],
        child: Icon(Icons.add),
      ),
    );
  }
}
