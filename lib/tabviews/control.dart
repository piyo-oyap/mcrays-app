import 'package:flutter/material.dart';
import 'package:aquaphonics/ui/control_sliders.dart';
import 'package:aquaphonics/ui/control_pump_buttons.dart';
import 'package:aquaphonics/ui/control_number_input.dart';

class Control extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    // messageCom // TODO: send request to server for slider values

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ControlSliders(),
          ControlPumpButtons(),
          Divider(),          
          NumberInput(),
          Divider(),
        ],
      ),
    );
  }
  
}
