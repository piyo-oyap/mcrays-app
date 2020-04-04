import 'dart:convert';

import 'package:aquaphonics/ui/config_dialog.dart';
import 'package:flutter/material.dart';
import 'package:aquaphonics/tabviews/home.dart';
import 'package:aquaphonics/tabviews/control.dart';
import 'package:aquaphonics/tabviews/report.dart';
import 'package:aquaphonics/message_communication.dart';
import 'package:aquaphonics/ui/gui_helper.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            ConfigIcon(),
          ],
          title: Text("McRays"),
        ),
        body: AbsorbPointer(
          // TODO: make this widget stateful
          absorbing: false,
          child: TabBarView(
            children: <Widget>[
              Home(),
              Control(),
              Report(),
            ],
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    ),
  );



  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}

///////////////////////////
/// StatusIcon
/////////////////////////
class StatusIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatusIcon();
}

class _StatusIcon extends State<StatefulWidget> {
  status _currentStatus;
  void _setStatus(status isDeviceOnline) { 
    setState(() => _currentStatus = isDeviceOnline);
    debugPrint(_getStatusText());
    GuiHelper.showSnackBar(context, _getStatusUpdateText());
  }

  void _onMessageReceived(data) {
    switch (data) {
    case "device_online":
      _setStatus(status.device_online);
      break;
    case "device_offline":
      _setStatus(status.device_offline);
      break;
    case "server_offline":
      _setStatus(status.server_offline);
      break;
    default:
    }
  }

  @override
  void initState() {
    super.initState();
    _currentStatus = status.server_offline;
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
    switch (_currentStatus) {
      case status.device_online:
        return MaterialCommunityIcons.power_plug;
        break;
      case status.device_offline:
        return MaterialCommunityIcons.power_plug_off;
        break;
      case status.server_offline:
        return MaterialCommunityIcons.server_off;
        break;
    }
  }

  String _getStatusText() {
    switch (_currentStatus) {
      case status.device_online:
        return "Device is currently online";
        break;
      case status.device_offline:
        return "Device is currently offine";
        break;
      case status.server_offline:
        return "Server is currently offline";
        break;
    }
  }

  String _getStatusUpdateText() {
    switch (_currentStatus) {
      case status.device_online:
        return "Device is now online";
        break;
      case status.device_offline:
        return "Device is now offline";
        break;
      case status.server_offline:
        return "Disconnected from server, reconnecting...";
        break;
    }
  }
}

enum status {
  device_online,
  device_offline,
  server_offline,
}