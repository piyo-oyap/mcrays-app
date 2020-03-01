import 'package:flutter/material.dart';
import 'package:aquaphonics/ui/gui_helper.dart';
import 'package:aquaphonics/ui/report_graph.dart';
import 'package:aquaphonics/ui/report_checkbox.dart';
import 'package:aquaphonics/datafields.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: GuiHelper.calculateHeightProportionalToScreen(context, 0.40),
            child: ReportGraph(),
          ),
          SizedBox(height: GuiHelper.calculateHeightProportionalToScreen(context, 0.05)),
          ReportCheckbox(),

        ],
      ),
    );
  }
}

