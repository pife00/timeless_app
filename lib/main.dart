import 'package:background/models/audio_assets.dart';
import 'package:flutter/material.dart';
import './screens/timers_screens.dart';
import './utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final audio = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      theme: ThemeData(
          primaryColor: primaryColor,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: accentColor,
            textStyle: TextStyle(fontSize: 16, color: Colors.black12),
          )),
          cardColor: scaffoldColor,
          scaffoldBackgroundColor: Colors.indigo[100]),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Timer"),
          ),
          body: TimerScreens()),
    );
  }
}
