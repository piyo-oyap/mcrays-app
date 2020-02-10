import 'package:flutter/material.dart';

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
              childAspectRatio: 1.0,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text("Alkalinity", style: gridTopText),
                      Text("1000", style: gridMiddleText),
                      Text("pH", style: gridBottomText),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  color: Color(gridBGColor),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text("aaaaaee"),
                  color: Color(gridBGColor),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Color(gridBGColor),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Color(gridBGColor),
                ),
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

  final SliverChildBuilderDelegate listChildren = 
    SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        String label;
        if (index.isEven) {
          switch (index ~/ 2) {
            case 0:
              label = "Water Temperature";
              break;
            case 1:
              label = "Water Level Aquarium";
              break;
            case 2:
              label = "Water Level Tank";
              break;
            case 3:
              label = "Air Temperature";
              break;
            case 4:
              label = "Air Humidity";
              break;
            case 5:
              label = "Remaining Feeds";
              break;
            default:
              label = "!!!Index out of range!!!";
              throw Exception("Index is out of range.");
          }

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("$label"),),
                Text("100"),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            color: Color(0xFF64EAA2),
            height: 50,
          );
        }
        return SizedBox(height: 15,);
      },
      childCount: 11,
    );
}