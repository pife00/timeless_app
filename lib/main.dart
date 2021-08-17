import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import './screens/timers_screens.dart';
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
  ));
}

final audioPlayer = AssetsAudioPlayer();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void play() {
    audioPlayer.open(
      Audio("assets/audios/rin.mp3"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Timer"),
        ),
        body: TextButton(
          child: Text('Press me'),
          onPressed: play,
        ));
    // TimerScreens()
  }
}
