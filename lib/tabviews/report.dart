import 'package:aquaphonics/ui/gui_helper.dart';
import 'package:flutter/material.dart';
import 'package:aquaphonics/ui/report_graph.dart';
import 'package:aquaphonics/datafield.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Divider(),
    ];
    widgets.add(ReportGraph(DataField.Alkalinity));
    // bool isFirst = true;
    // for (var item in DataField.values) {
    //   if (isFirst) {isFirst = false;}
    //   else {widgets.add(SizedBox(height: GuiHelper.calculateHeightProportionalToScreen(context, 0.05),));}
    //   widgets.add(ReportGraph(item));
      
    // }

    return Scaffold(
      body: ListView(
        children: widgets,
      ),
    );
  }
}

