import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class NumberPick extends StatefulWidget {
  int _currentValue;
  Function getValue;
  VoidCallback finish;

  NumberPick(this._currentValue, this.getValue,this.finish);

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
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[TextButton(
              onPressed:widget.finish, 
              child: Text('OK'))],
          ),
        )
      ],
    );
  }

  
}
