import 'package:background/models/audio_assets.dart';
import '../timer_config_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'dart:isolate';
import 'package:intl/intl.dart';

Timer? timer;

timerTick(SendPort sendPort) {
  int count = 0;
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    count++;
    sendPort.send(count);
  });
}

class TimerW extends StatefulWidget {
  final String name;

  TimerW(this.name);

  @override
  _TimerWState createState() => _TimerWState();
}

class _TimerWState extends State<TimerW> with WidgetsBindingObserver {
  AudioPlayer audio = AudioPlayer();

  int minutes = 0;
  int seconds = 0;
  String futureEnd = '';
  int secondsTotal = 0;
  bool session = false;
  bool timeEnd = true;

  String timerShow = "00 : 00";

  bool isActive = false;
  Isolate? isolate;
  ReceivePort? _receivePort;

  late AppLifecycleState _notification;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    if (_notification == AppLifecycleState.paused) {
      if (minutes > 0) {
        stop();
        start();
      }
    }

    if (_notification == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    _receivePort?.close();
    isolate?.kill();
    print('dispose here');
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void start() async {
    if (minutes > 0) {
      _receivePort = ReceivePort();

      try {
        isolate = await Isolate.spawn(timerTick, _receivePort!.sendPort);

        _receivePort?.listen((count) {
          timerHandler(count);
        });
      } catch (e) {
        print(e);
      }
    } else {
      setState(() => isActive = !isActive);
    }
  }

  void timerHandler(int count) {
    if (session == false) {
      var t = DateTime.now();

      setState(() {
        session = true;
        secondsTotal = minutes * 60;
        var nearEnd = t.add(Duration(milliseconds: (secondsTotal * 1000)));
        var twelve = DateFormat("h:mma").format(nearEnd);
        futureEnd = '$twelve';
      });
    }

    if (seconds < secondsTotal) {
      setState(() {
        seconds++;
        timerShow = prettyShowTimer(seconds);
      });
      if (seconds == secondsTotal) {
        setState(() {
          timerShow = '00 : 00';
        });
        setState(() {
          isActive = !isActive;
        });
        finish();
        dialog(context);
        audio.play();
      }
    }
  }

  String prettyShowTimer(int numb) {
    //var hours = (numb / secondsTotal).floor();
    var totalMinutes = secondsTotal / 60;
    var minutes = ((totalMinutes).toInt() - (numb / 60).floor()) - 1;
    var seconds = ((numb % 60) - 60) * -1;

    if (minutes < 0) {
      minutes = 0;
    }

    //var displayH = hours < 10 ? '0$hours' : null;
    var displayM = minutes < 10 ? '0$minutes' : minutes;
    var displayS = seconds < 10 ? '0$seconds' : seconds;

    String union = "$displayM : $displayS";

    return union;
  }

  void stop() {
    if (session == true) {
      _receivePort?.close();
      isolate?.kill();
    }
  }

  void finish() {
    if (session == true) {
      _receivePort?.close();
      isolate?.kill();
      if (seconds == secondsTotal) {
        setState(() {
          session = false;
        });
      }
    }
  }

  void reset() {
    setState(() {
      minutes = 0;
      seconds = 0;
      session = false;
      secondsTotal = 0;
      futureEnd = '';
      timerShow = '00 : 00';
    });
  }

  void getMinutes(int minutes) {
    setState(() {
      this.minutes = minutes;
      minutes < 10 ? timerShow = "0$minutes : 00" : timerShow = "$minutes : 00";
    });
  }

  void enterConfig(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return TimerConfig(getMinutes);
        });
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Time end ${widget.name}"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  audio.stop();
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Card(
        color: isActive ? Colors.white : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Color.fromRGBO(102, 163, 255, 0.30))),
        child: Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  enterConfig(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height / 5,
                    width: 175,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.name,
                            style: Theme.of(context).textTheme.headline6),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '$timerShow',
                            style: TextStyle(
                                fontSize: 50,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(minutes > 0 ? '${minutes}M' : '',
                                  style: Theme.of(context).textTheme.headline6),
                              Text(futureEnd != '' ? '$futureEnd' : '',
                                  style: Theme.of(context).textTheme.headline6),
                            ],
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
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
