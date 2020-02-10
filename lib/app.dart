import 'package:flutter/material.dart';
import 'package:aquaphonics/tabviews/home.dart';
import 'package:aquaphonics/tabviews/control.dart';
import 'package:aquaphonics/tabviews/report.dart';

class App extends StatelessWidget {
  final materialApp = MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.build)),
              Tab(icon: Icon(Icons.insert_chart)),
            ],
          ),
          title: Text("McRays"),
        ),
        body: TabBarView(
          children: <Widget>[
            Home(),
            Control(),
            Report(),
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}