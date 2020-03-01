import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

enum DataField {
  Alkalinity,
  Ammonia,
  Chlorine,
  Nitrate,
  WaterLevelAquarium,
  WaterLevelTank,
  WaterTemp,
  AirTemp,
  AirHumidity,
  Feeds,
}

class DataFieldState {
  factory DataFieldState() {
    DataFieldState instance = new DataFieldState();
    instance.state = {};
    for (var item in DataField.values) {
      instance.state[item] = false;
    }
    return instance;
  }

  Map<DataField, bool> state;

}

class DataFieldStateWidget extends InheritedWidget{
  final StreamedValue<DataFieldState> data;

  DataFieldStateWidget({Widget child, this.data}) : super(child: child);

  @override
  bool updateShouldNotify(DataFieldStateWidget oldWidget) => oldWidget.data.value != data.value;

  static DataFieldStateWidget of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}