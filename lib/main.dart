import 'package:flutter/material.dart';
import './screens/timers_screens.dart';
import './utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      theme: ThemeData(
          primaryColor: Colors.indigo[600],
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: accentColor,
            textStyle: TextStyle(fontSize: 16, color: Colors.black12),
          )),
          cardColor: Colors.indigo[50],
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 18,color: Colors.indigo[600])
          ),
          scaffoldBackgroundColor: Colors.indigo[50]),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Timer"),
          ),
          body: TimerScreens()),
    );
  }
}
