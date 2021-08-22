import 'package:flutter/cupertino.dart';
import '../models/timers.dart';

class TimerProvider with ChangeNotifier {
  List<Timers> _items = [
    Timers(name: "PC" + 1.toString()),
    Timers(name: "PC" + 2.toString()),
    Timers(name: "PC" + 3.toString()),
    Timers(name: "PC" + 4.toString())
  ];

  List<Timers> get items => [..._items];

  void addTimer(Timers newTimer) {
    items.add(newTimer);
    notifyListeners();
  }
}
