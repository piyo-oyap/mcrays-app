import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aquaphonics/tabviews/home.dart';
import 'package:aquaphonics/tabviews/control.dart';
import 'package:aquaphonics/tabviews/report.dart';
import 'package:aquaphonics/message_communication.dart';
import 'package:aquaphonics/ui/gui_helper.dart';

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
          actions: <Widget>[
            StatusIcon(),
          ],
          title: Text("McRays"),
        ),
        body: TabBarView(
          children: <Widget>[
            Home(),
            Control(),
            Report(),
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    ),
  );



  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}

class StatusIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatusIcon();
}

class _StatusIcon extends State<StatefulWidget> {
  bool _isDeviceOnline;
  void _setDeviceStatus(bool isDeviceOnline) { 
    setState(() => _isDeviceOnline = isDeviceOnline);
    debugPrint(_getStatusText());
    GuiHelper.showSnackBar(context, _getStatusUpdateText());
  }

  void _onMessageReceived(data) {
    switch (data) {
    case "device_online":
      _setDeviceStatus(true);
      break;
    case "device_offline":
      _setDeviceStatus(false);
      break;
    default:
    }
  }

  @override
  void initState() {
    super.initState();
    _isDeviceOnline = false;
    messageCom.addConnectionListener(_onMessageReceived);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        icon: Icon(_getIcon(), color: Colors.white,),
        onPressed: () {},
      ),
      onLongPress: () => GuiHelper.showSnackBar(context, _getStatusText()),
    );
  }

  @override
  void dispose() {
    messageCom.removeConnectionListener(_onMessageReceived);
    super.dispose();
  }

  IconData _getIcon() {
    return (_isDeviceOnline) ? Icons.done : Icons.do_not_disturb_alt;
  }

  String _getStatusText() {
    return _isDeviceOnline ? "Device is currently online" : "Device is currently offline";
  }

  String _getStatusUpdateText() {
    return _isDeviceOnline ? "Device is now online" : "Device is now offline";
  }
}