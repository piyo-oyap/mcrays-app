import 'package:flutter/material.dart';
import 'package:aquaphonics/websocket_helper.dart';

class Control extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Control();
}

class _Control extends State<Control> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    sockets.addListener(printFromWS(context));
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          TextField(decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter txt",
            ),
            controller: textController,
          ),
          Row(
            children: <Widget>[
              const Text("Feed"),
              RaisedButton(
                onPressed: manualFeed,
                child: Text("Do it"),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
        ],
      ),
    );
  }

  void manualFeed() {
    sockets.send(textController.text);
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text(textController.text),),);
  }

  Function printFromWS(BuildContext context) {
    return (message) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("From WS: " + message),),);
    };
  }

  @override
  void dispose() {
    sockets.removeListener(printFromWS(context));
    textController.dispose();
    super.dispose();
  }
}