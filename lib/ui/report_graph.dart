import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ReportGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportGraph.withSampleData();
}

class _ReportGraph extends State<ReportGraph> {
  List<charts.Series> seriesList;
  _ReportGraph(this.seriesList);

  factory _ReportGraph.withSampleData() {
    return new _ReportGraph(
      _createSampleData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: charts.LocalDateTimeFactory(),
      
    );
  }

  static List<charts.Series<TimeSeriesReading, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesReading(new DateTime(2017, 9, 19), 5),
      new TimeSeriesReading(new DateTime(2017, 9, 26), 25),
      new TimeSeriesReading(new DateTime(2017, 10, 3), 100),
      new TimeSeriesReading(new DateTime(2017, 10, 10), 75),
    ];

    final data2 = [
      new TimeSeriesReading(new DateTime(2017, 9, 19), 15),
      new TimeSeriesReading(new DateTime(2017, 9, 26), 5),
      new TimeSeriesReading(new DateTime(2017, 10, 3), 50),
      new TimeSeriesReading(new DateTime(2017, 10, 10), 175),
    ];

    return [
      new charts.Series<TimeSeriesReading, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesReading sales, _) => sales.time,
        measureFn: (TimeSeriesReading sales, _) => sales.reading,
        data: data,
      ),
      new charts.Series<TimeSeriesReading, DateTime>(
        id: 'Sales 2wo',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesReading sales, _) => sales.time,
        measureFn: (TimeSeriesReading sales, _) => sales.reading,
        data: data2,
      ),
    ];
  }
}

class TimeSeriesReading {
  final DateTime time;
  final double reading;
  TimeSeriesReading(this.time, this.reading);
}
