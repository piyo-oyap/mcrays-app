import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:aquaphonics/message_communication.dart';

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

class _SliderWidget extends State<SliderWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  double _value;
  void _setValue(double value) => setState(() => _value = value);
  void _sendToServer(double value) {
    String prefix;
    switch (widget.id) {
      case SliderID.fan:
        prefix = 'S';
        break;
      case SliderID.light:
        prefix = 'L';
        break;
      case SliderID.water:
        prefix = 'W';
        break;
      default:
    }

    messageCom.send("command", prefix + value.round().toString());
  }

  void _onDataReceived(command) {
    if (isJson(command)) return;      // stop parsing when content contains json

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
    _value = 0.0;
    super.initState();
    messageCom.addCommandListener(_onDataReceived);
  }

  @override
  Widget build(BuildContext context) {    
    super.build(context);
    return 
    Row(
      children: <Widget>[
        SizedBox(
          width: 45,
          child: Text("${widget.name}"),
        ),
        Expanded(
          flex: 1,
          child:
            Slider(
              value: _value,
              min: 0,
              max: 255,
              onChanged: _setValue,
              onChangeEnd: _sendToServer,
            ),
        ),
        SizedBox(
          width: 25,
          child: Text("${_value.round()}", textAlign: TextAlign.right,),
        ),
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