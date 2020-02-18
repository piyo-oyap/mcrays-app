import 'package:flutter/material.dart';
import 'package:aquaphonics/message_communication.dart';
import 'package:aquaphonics/ui/home_grid.dart';
import 'package:aquaphonics/ui/home_list.dart';

class Home extends StatelessWidget {
  final int gridBGColor = 0xFF64DCEA;
  final TextStyle gridTopText =  TextStyle(fontSize: 20,fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Colors.white);
  final TextStyle gridMiddleText =  TextStyle(fontSize: 60,fontFamily: "Open Sans", fontWeight: FontWeight.w800, color: Colors.white);
  final TextStyle gridBottomText =  TextStyle(fontSize: 15,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);

  void _notifyDeviceStatus(json, context) {
    String status = "...";
    switch (json["content"]) {
      case "device_online":
        status = "Device is online";
        break;
      case "device_offline":
        status = "Device is offline";
        break;
      default:
    }
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(status)));
  }


  @override
  Widget build(BuildContext context) {
    messageCom.addConnectionListener((message) => _notifyDeviceStatus(message, context));
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid.count(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                HomeGrid(type: HomeGridNames.Alkalinity),
                HomeGrid(type: HomeGridNames.Ammonia),
                HomeGrid(type: HomeGridNames.Chlorine),
                HomeGrid(type: HomeGridNames.Nitrate),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
              delegate: listChildren,
            ),
          ),
        ],
      )
    );
  }

  final SliverChildListDelegate listChildren = 
    SliverChildListDelegate.fixed(
      <Widget>[
        HomeListView(type: HomeListNames.WaterTemp),
        SizedBox(height: 15),
        HomeListView(type: HomeListNames.WaterLevelAqua),
        SizedBox(height: 15),
        HomeListView(type: HomeListNames.WaterLevelTank),
        SizedBox(height: 15),
        HomeListView(type: HomeListNames.AirTemp),
        SizedBox(height: 15),
        HomeListView(type: HomeListNames.AirHumid),
        SizedBox(height: 15),
        HomeListView(type: HomeListNames.RemainingFeeds),
        
      ],
    );
}