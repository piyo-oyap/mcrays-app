import 'package:flutter/material.dart';

class ControlPumpButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row (
      children: <Widget>[
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump In"),
            onPressed: () {},
            padding: EdgeInsets.all(10.0),
          ),
        ),
        
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump Out"),
            onPressed: () {},
            padding: EdgeInsets.all(10.0),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}