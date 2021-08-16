import 'package:background/utils/colors.dart';

import '../timer_config_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerW extends StatefulWidget {
  @override
  _TimerWState createState() => _TimerWState();
}

class _TimerWState extends State<TimerW> {
  int minutes = 1;
  int seconds = 0;
  int secondsTotal = 0;
  bool session = false;

  String name = "PC 1";
  String timerShow = "00 : 00";
  Timer? _timer;

  bool isActive = false;

  void start() {
    if (session == false) {
      secondsTotal = minutes * 60;
    }

    if (seconds < secondsTotal) {
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          seconds++;
          timerShow = prettyShowTimer(seconds);
        });
        if (seconds == secondsTotal) {
          stop();
        }
      });
    }
  }

  String prettyShowTimer(int numb) {
    //var hours = (numb / secondsTotal).floor();
    var minutes = (numb / 60).floor();
    var seconds = numb % 60;

    //var displayH = hours < 10 ? '0$hours' : null;
    var displayM = minutes < 10 ? '0$minutes' : minutes;
    var displayS = seconds < 10 ? '0$seconds' : seconds;

    String union = "$displayM : $displayS";

    return union;
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    setState(() {
      seconds = 0;
      secondsTotal = 0;
      timerShow = '00 : 00';
    });
  }

  void enterConfig(BuildContext context) {
    Navigator.pushNamed(context, TimerConfig.routeName, arguments: {'PC': '1'});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1.5, left: 3, right: 3),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  enterConfig(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 110,
                    width: 175,
                    child: Column(
                      children: <Widget>[
                        Text(name),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '$timerShow',
                            style: TextStyle(
                                fontSize: 50,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                      onLongPress: reset,
                      child: Icon(
                        Icons.restart_alt,
                        size: 29,
                        color: Colors.indigo[600],
                      )),
                  Switch(
                      value: isActive,
                      activeColor: Colors.indigo[600],
                      inactiveThumbColor: Colors.indigo[400],
                      inactiveTrackColor: Colors.indigo[100],
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                        isActive ? start() : stop();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
