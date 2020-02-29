import 'package:aquaphonics/message_communication.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class HomeGrid extends StatefulWidget {
  final int _gridBGColor = 0xFF64DCEA;
  final TextStyle _gridTopText = TextStyle(fontSize: 20,fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Colors.white);
  final TextStyle _gridMiddleText = TextStyle(fontSize: 60,fontFamily: "Open Sans", fontWeight: FontWeight.w800, color: Colors.white);
  final TextStyle _gridUnitText = TextStyle(fontSize: 15,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);
  final TextStyle _gridLastUpdatedText = TextStyle(fontSize: 13,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);

  final HomeGridNames type;

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
    _label = _getLabelFromEnum(widget.type);
    _unit = _getUnitFromEnum(widget.type);
    _value = "---";
    _lastUpdated = DateTime.now().toString();
  }

  @override
  void dispose() {
    messageCom.addUpdateListener(_onDataReceived);
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
    if (isJson(data) && data["type"] == "non-realtime") {
      String value;
      String lastUpdated;
      switch (widget.type) {
        case HomeGridNames.Alkalinity:

        case HomeGridNames.Ammonia:

        case HomeGridNames.Chlorine:

        case HomeGridNames.Nitrate:

        default:
        break;
      }
      setState(() {
        _value = value;
        _lastUpdated = lastUpdated;
      });
    }
  }

  String _getLabelFromEnum(HomeGridNames type) {
    switch (type) {
      case HomeGridNames.Alkalinity:
        return "Alkalinity";
      case HomeGridNames.Ammonia:
        return "Ammonia";
      case HomeGridNames.Chlorine:
        return "Chlorine";
      case HomeGridNames.Nitrate:
        return "Nitrate";
      default:
        throw Exception("Enum out of range");
    }
  }

  String _getUnitFromEnum(HomeGridNames type) {
    switch (type) {
      case HomeGridNames.Alkalinity:
        return "pH";
      case HomeGridNames.Ammonia:
      case HomeGridNames.Chlorine:
      case HomeGridNames.Nitrate:
        return "ppa";
      default:
        throw Exception("Enum out of range");
    }
  }
}

enum HomeGridNames {// units:
  Alkalinity,       // pH
  Ammonia,          // ppa
  Chlorine,         // ppa
  Nitrate,          // ppa
}