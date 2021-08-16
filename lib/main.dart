import 'package:flutter/material.dart';
import './screens/timers_screens.dart';
import 'screens/timer_config_screen.dart';
import './utils/colors.dart';

void main() {
  runApp(MaterialApp(
    title: "Timer",
    home: MyApp(),
    theme: ThemeData(
        primaryColor: primaryColor,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          primary: accentColor,
          textStyle: TextStyle(fontSize: 16, color: Colors.black12),
        )),
        cardColor: scaffoldColor,
        scaffoldBackgroundColor: Colors.indigo[100]),
    routes: {TimerConfig.routeName: (context) => TimerConfig()},
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: TimerScreens(),
    );
  }
}
