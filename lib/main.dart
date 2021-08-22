import 'package:flutter/material.dart';
import './screens/timers_screens.dart';
import './utils/colors.dart';
import 'provider/timers_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ,
      child: MaterialApp(
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
                headline6: TextStyle(fontSize: 18, color: Colors.indigo[600])),
            scaffoldBackgroundColor: Colors.indigo[50]),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Timer"),
            ),
            body: TimerScreens()),
      ),
    );
  }
}
