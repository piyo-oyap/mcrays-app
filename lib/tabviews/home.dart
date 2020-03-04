import 'package:flutter/material.dart';
import 'package:aquaphonics/ui/home_grid.dart';
import 'package:aquaphonics/ui/home_list.dart';
import 'package:aquaphonics/datafield.dart';

class Home extends StatelessWidget {
  final int gridBGColor = 0xFF64DCEA;
  final TextStyle gridTopText =  TextStyle(fontSize: 20,fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Colors.white);
  final TextStyle gridMiddleText =  TextStyle(fontSize: 60,fontFamily: "Open Sans", fontWeight: FontWeight.w800, color: Colors.white);
  final TextStyle gridBottomText =  TextStyle(fontSize: 15,fontFamily: "Open Sans", fontWeight: FontWeight.w400, color: Colors.white);

  @override
  Widget build(BuildContext context) {
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
                HomeGrid(type: DataField.Alkalinity),
                HomeGrid(type: DataField.Ammonia),
                HomeGrid(type: DataField.Chlorine),
                HomeGrid(type: DataField.Nitrate),
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
        HomeListView(type: DataField.WaterTemp),
        SizedBox(height: 15),
        HomeListView(type: DataField.WaterLevelAquarium),
        SizedBox(height: 15),
        HomeListView(type: DataField.WaterLevelTank),
        SizedBox(height: 15),
        HomeListView(type: DataField.AirTemp),
        SizedBox(height: 15),
        HomeListView(type: DataField.AirHumidity),
        SizedBox(height: 15),
        HomeListView(type: DataField.Feeds),
        
      ],
    );
}