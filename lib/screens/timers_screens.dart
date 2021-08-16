

import 'package:background/models/timers.dart';
import 'package:flutter/material.dart';
import './widget_local/timer.dart';

class TimerScreens extends StatefulWidget {
  @override
  _TimerScreensState createState() => _TimerScreensState();
}

class _TimerScreensState extends State<TimerScreens> {
  int _currentTimers = 4;

  List<Timers> computers = [
    Timers(name: "PC" + 1.toString()),
    Timers(name: "PC" + 2.toString()),
    Timers(name: "PC" + 3.toString()),
    Timers(name: "PC" + 4.toString())
  ];

  void addNewTimer() {
    setState(() {
      _currentTimers++;
    });

    String name = 'PC' + (_currentTimers).toString();

    var newTimer = Timers(name: name);

    setState(() {
      computers.add(newTimer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        padding: EdgeInsets.all(2),
        children:computers.map((el){
          return TimerW(el.name);
        }).toList()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTimer,
        backgroundColor: Colors.indigo[600],
        child: Icon(Icons.add),
      ),
    );
  }
}
