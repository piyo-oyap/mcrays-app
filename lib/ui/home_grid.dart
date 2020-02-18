import 'package:flutter/material.dart';

class HomeGrid extends StatefulWidget {
  final int _gridBGColor = 0xFF64DCEA;
  final TextStyle _gridTopText = TextStyle(fontSize: 20,fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Colors.white);
  final TextStyle _gridMiddleText = TextStyle(fontSize: 60,fontFamily: "Open Sans", fontWeight: FontWeight.w800, color: Colors.white);
  final TextStyle _gridBottomText = TextStyle(fontSize: 15,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);

  final HomeGridNames type;

  HomeGrid({@required this.type});

  @override
  State<StatefulWidget> createState() => _HomeGrid();
}

class _HomeGrid extends State<HomeGrid> {
  String label;
  String unit;
  String value;
  String lastUpdated;

  @override
  void initState() {
    super.initState();
    label = _getLabelFromEnum(widget.type);
    unit = _getUnitFromEnum(widget.type);
    value = "---";
    lastUpdated = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Text("$label", style: widget._gridTopText),
          Text("$value", style: widget._gridMiddleText),
          Text("$unit", style: widget._gridBottomText),
          // TODO: tweak lastUpdated text style, perhaps make it a bit smaller
          Text("$lastUpdated", style: widget._gridBottomText, textAlign: TextAlign.center,),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      color: Color(widget._gridBGColor),
    );
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