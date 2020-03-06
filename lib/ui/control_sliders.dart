import 'package:flutter/material.dart';
import 'package:aquaphonics/message_communication.dart';

class ControlSliders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        SliderWidget("Fan", id: SliderID.fan, min: -100, max: 100),
        SliderWidget("Light", id: SliderID.light, min: 0, max: 100),
        SliderWidget("Water", id: SliderID.water, min: 0, max: 100),
      ],
    );
  }
}

class SliderWidget extends StatefulWidget {
  final String name;
  final SliderID id;
  final double min;
  final double max;
  SliderWidget(this.name, {@required this.id, this.min = 0, this.max = 100});

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
              min: widget.min,
              max: widget.max,
              onChanged: _setValue,
              onChangeEnd: _sendToServer,
            ),
        ),
        SizedBox(
          width: 28,
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