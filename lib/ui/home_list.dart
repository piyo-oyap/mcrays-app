import 'package:flutter/material.dart';

class HomeListView extends StatefulWidget {
  final HomeListNames type;

  HomeListView({@required this.type});

  @override
  State<StatefulWidget> createState() => _HomeListView();
}

class _HomeListView extends State<HomeListView> {
  String label;
  @override
  Widget build(BuildContext context) {
    label = _getNameFromEnum(widget.type);
    
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(child: Text("$label"),),
          Text("100"),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      color: Color(0xFF64EAA2),
      height: 50,
    );
  }

  static String _getNameFromEnum(HomeListNames type) {
    switch (type) {
      case HomeListNames.WaterTemp:
        return "Water Temperature";
      case HomeListNames.WaterLevelAqua:
        return "Water Level Aquarium";
      case HomeListNames.WaterLevelTank:
        return "Water Level Tank";
      case HomeListNames.AirTemp:
        return "Air Temperature";
      case HomeListNames.AirHumid:
        return "Air Humidity";
      case HomeListNames.RemainingFeeds:
        return "Remaining Feeds";
      default:
        throw Exception("Enum out of range");
    }
  }
}

enum HomeListNames {
  WaterTemp,
  WaterLevelAqua,
  WaterLevelTank,
  AirTemp,
  AirHumid,
  RemainingFeeds,
  HomeListNamesCount,
}