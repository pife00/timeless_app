import 'package:background/models/timers.dart';
import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier{

  List<Timers> _timers =[
    Timers(name: "PC" + 1.toString()),
    Timers(name: "PC" + 2.toString()),
    Timers(name: "PC" + 3.toString()),
    Timers(name: "PC" + 4.toString())
  ];

  List<Timers> get timers => [..._timers];

  addTimer(Timers newTimer){
    
    _timers.add(newTimer);
    notifyListeners();
  }
}