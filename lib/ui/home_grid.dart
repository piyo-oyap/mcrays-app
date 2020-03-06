import 'package:aquaphonics/message_communication.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:aquaphonics/datafield.dart';

class HomeGrid extends StatefulWidget {
  final int _gridBGColor = 0xFF64DCEA;
  final TextStyle _gridTopText = TextStyle(fontSize: 20,fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Colors.white);
  final TextStyle _gridMiddleText = TextStyle(fontSize: 60,fontFamily: "Open Sans", fontWeight: FontWeight.w800, color: Colors.white);
  final TextStyle _gridUnitText = TextStyle(fontSize: 15,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);
  final TextStyle _gridLastUpdatedText = TextStyle(fontSize: 13,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);

  final DataField type;

  HomeGrid({@required this.type});

  @override
  State<StatefulWidget> createState() => _HomeGrid();
}

class _HomeGrid extends State<HomeGrid> {
  String _label;
  String _unit;
  String _value;
  String _lastUpdated;

  @override
  void initState() {
    super.initState();
    messageCom.addUpdateListener(_onDataReceived);
    _label = DataFieldStrings[widget.type];
    _unit = DataFieldSuffixes[widget.type];
    _value = "---";
    _lastUpdated = "---";
  }

  @override
  void dispose() {
    messageCom.removeUpdateListener(_onDataReceived);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Text("$_label", style: widget._gridTopText),
          Text("$_value", style: widget._gridMiddleText),
          Text("$_unit", style: widget._gridUnitText),
          // TODO: tweak lastUpdated text style, perhaps make it a bit smaller
          Text("$_lastUpdated", style: widget._gridLastUpdatedText, textAlign: TextAlign.center,),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      color: Color(widget._gridBGColor),
    );
  }

  void _onDataReceived(data) {
    if (data["type"] == "non-realtime") {
      String datatype = widget.type.toString().split(".").last;
      var content = data["content"];
      if (content[datatype] == null) return;
      String value = content[datatype].toString();
      String lastUpdated = DateTime.fromMillisecondsSinceEpoch(data["content"]["lastUpdated"]).toString();
      
      
      setState(() {
        _value = value;
        _lastUpdated = lastUpdated;
      });
    }
  }
}