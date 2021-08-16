import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimerConfig extends StatefulWidget {
  static String routeName = "/timer-config";

  @override
  _TimerConfigState createState() => _TimerConfigState();
}

class _TimerConfigState extends State<TimerConfig> {
  var nameItems = ['one', 'two', 'three'];
  var dummyValue = 'one';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final _timerConfigPc = routeArgs['PC'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Config PC ' + _timerConfigPc.toString()),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Time",
                ),
                style: TextStyle(),
              ),
            ),
            Container(
              child: DropdownButton<String>(
                value: dummyValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dummyValue = newValue!;
                  });
                },
                items: nameItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {}, child: Text('Accept'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
