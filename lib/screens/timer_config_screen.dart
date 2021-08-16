import 'package:background/screens/widget_local/number_pick.dart';
import 'package:flutter/material.dart';

class TimerConfig extends StatefulWidget {
  static String routeName = "/timer-config";
  final Function getMinutes;

  TimerConfig(this.getMinutes);

  @override
  _TimerConfigState createState() => _TimerConfigState();
}

class _TimerConfigState extends State<TimerConfig> {
  var nameItems = ['one', 'two', 'three'];
  var dummyValue = 'one';
  int _currentValue = 15;

  void _getValue(int value){
    setState(() {
      _currentValue = value;
    });
  }

  _passValue(){
    widget.getMinutes(_currentValue);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
   
    return Card(
        child: NumberPick(_currentValue,_getValue,_passValue)
      );
  }
}
