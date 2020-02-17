import 'package:flutter/material.dart';
import 'package:aquaphonics/ui/control_sliders.dart';
import 'package:aquaphonics/ui/control_number_input.dart';

class Control extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ControlSliders(),
          Divider(),
          NumberInput(),
        ],
      ),
    );
  }

  Function manualFeed(BuildContext context) {
    
    return () {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(""),),);
    };
  }
  
}
