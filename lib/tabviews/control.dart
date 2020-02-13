import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aquaphonics/message_communication.dart';

class Control extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ControlSliders(),
          Row(
            children: <Widget>[
              const Text("Feed"),
              RaisedButton(
                onPressed: manualFeed(context),
                child: Text("Do it"),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
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

class ControlSliders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        SliderWidget(name: "Fan", id: SliderID.fan),
        SliderWidget(name: "Light", id: SliderID.light),
        SliderWidget(name: "Water", id: SliderID.water),
      ],
    );
  }
}

class SliderWidget extends StatefulWidget {
  final String name;
  final SliderID id;
  SliderWidget({@required this.name, @required this.id});

  @override
  State<StatefulWidget> createState() => _SliderWidget();
}

class _SliderWidget extends State<SliderWidget> {
  
  double _value = 0.0;
  void _setValue(double value) => setState(() => _value = value);
  void _sendToServer(double value) => messageCom.sendRaw(value.round().toString());

  void _onDataReceived(json) {
    String command = json["content"];
    if ((command.startsWith("S") && widget.id == SliderID.fan)
    || (command.startsWith("L") && widget.id == SliderID.light)
    || (command.startsWith("W") && widget.id == SliderID.water)
    ) {
      double value = double.tryParse(command.substring(1));
      if (value != null)
        _setValue(value);
    }
  }

  @override
  void initState() {
    super.initState();
    messageCom.addCommandListener(_onDataReceived);
  }

  @override
  Widget build(BuildContext context) {    
    return 
    Row(
      children: <Widget>[
        Text("${widget.name}"),
        Expanded(
          child:
            Slider(
              value: _value,
              min: 0,
              max: 255,
              onChanged: _setValue,
              onChangeEnd: _sendToServer,
            ),
        ),
        Text("${_value.round()}"),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  void dispose() {
    messageCom.removeCommandListener(_onDataReceived);
    super.dispose();
  }
}

enum SliderID {
    fan,
    light,
    water,
  }

  // void dispose() {
  //   sockets.removeListener(printFromWS(context));
  //   textController.dispose();
  //   super.dispose();
  // }
