import 'package:flutter/material.dart';
import 'package:aquaphonics/message_communication.dart';
import 'package:string_validator/string_validator.dart';

class HomeListView extends StatefulWidget {
  final HomeListNames type;

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
    _label = _getNameFromEnum(widget.type);
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

  void _onDataReceived(data) { {
    if (isJson(data) && data["type"] == "realtime") {
      String value;
      switch (widget.type) {
        case HomeListNames.WaterTemp:
          value = "C°";
          break;
        case HomeListNames.WaterLevelAqua:
          value = "%";
          break;
        case HomeListNames.WaterLevelTank:
          value = "%";
          break;
        case HomeListNames.AirTemp:
          value = "C°";
          break;
        case HomeListNames.AirHumid:
          value = "%";
          break;
        case HomeListNames.RemainingFeeds:
          value = "%";
          break;
        default:
          throw Exception("Enum out of range");
        }
        setState(() => _value = value);
      }
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