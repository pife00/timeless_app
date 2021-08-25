import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class NumberPick extends StatefulWidget {
  int _currentValue;
  Function getValue;
  VoidCallback finish;

  NumberPick(this._currentValue, this.getValue, this.finish);

  @override
  _NumberPickState createState() => _NumberPickState();
}

class _NumberPickState extends State<NumberPick> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            child: NumberPicker(
                value: widget._currentValue,
                minValue: 1,
                maxValue: 500,
                onChanged: (value) {
                  setState(() {
                    widget._currentValue = value;
                  });
                  widget.getValue(widget._currentValue);
                })),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () => setState(() {
                      if (widget._currentValue < 10) {
                      } else {
                        widget._currentValue = widget._currentValue - 10;
                      }
                    }),
                icon: Icon(Icons.remove, color: Colors.indigo[600])),
            Text(
              '10',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            IconButton(
                onPressed: () => setState(() {
                      widget._currentValue = widget._currentValue + 10;
                    }),
                icon: Icon(
                  Icons.add,
                  color: Colors.indigo[600],
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => setState(() {
                widget._currentValue = 15;
              }),
              child: Text('15'),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => setState(() {
                widget._currentValue = 30;
              }),
              child: Text('30'),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => setState(() {
                widget._currentValue = 60;
              }),
              child: Text('60'),
            ),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(onPressed: widget.finish, child: Text('OK'))
            ],
          ),
        )
      ],
    );
  }
}
