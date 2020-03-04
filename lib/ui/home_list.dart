import 'package:flutter/material.dart';
import 'package:aquaphonics/message_communication.dart';
import 'package:string_validator/string_validator.dart';
import 'package:aquaphonics/datafield.dart';

class HomeListView extends StatefulWidget {
  final DataField type;

  HomeListView({@required this.type});

  @override
  State<StatefulWidget> createState() => _HomeListView();
}

class _HomeListView extends State<HomeListView> {
  String _label;
  String _value;

  @override
  void initState() {
    super.initState();
    _label = DataFieldStrings[widget.type];
    _value = "---";
    messageCom.addUpdateListener(_onDataReceived);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(child: Text("$_label")),
          Text("$_value"),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      color: Color(0xFF64EAA2),
      height: 50,
    );
  }

  @override
  void dispose() {
    messageCom.removeUpdateListener(_onDataReceived);
    super.dispose();
  }

  void _onDataReceived(data) { 
    if (data["type"] == "realtime") {
      String value = data["content"][widget.type.toString().split(".").last].toString();
      if (isNumeric(value)) {
        value = value + DataFieldSuffixes[widget.type];
      
        setState(() => _value = value);
      }
      
    }
  }
}