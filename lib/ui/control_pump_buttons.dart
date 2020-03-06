import 'package:aquaphonics/message_communication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flushbar/flushbar.dart';

class ControlPumpButtons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlPumpButtons();
}

class _ControlPumpButtons extends State<ControlPumpButtons> {
  PumpType currentPump;

  @override
  void initState() {
    super.initState();
    messageCom.addCommandListener(_onDataReceived);
    currentPump = PumpType.Off;
  }

  @override
  void dispose() {
    messageCom.removeCommandListener(_onDataReceived);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row (
      children: <Widget>[
        Icon(
          FontAwesome5Solid.tint,
          size: 24.0,
          color: Color(getIconColor()),
        ),
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump In"),
            onPressed: showHelp,
            padding: EdgeInsets.all(10.0),
          ),
          onLongPress: () => enablePump(PumpType.In),
          onLongPressUp: () => disablePump(PumpType.In),
        ),
        
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump Out"),
            onPressed: showHelp,
            padding: EdgeInsets.all(10.0),
          ),
          onLongPress: () => enablePump(PumpType.Out),
          onLongPressUp: () => disablePump(PumpType.Out),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  void _setCurrentPump(PumpType _currentPump) {
    setState(() {
      currentPump = _currentPump;
    });
  }

  void _onDataReceived(command) {
    if (command.startsWith("P")) {
      switch (command.substring(1)) {
        case "1":
          _setCurrentPump(PumpType.In);
          break;
        case "-1":
          _setCurrentPump(PumpType.Out);
          break;
        case "0":
          _setCurrentPump(PumpType.Off);
          break;
      }
    }
  }

  void showHelp() {
    // maybe revert back to normal snackbar...
    Flushbar(
      message: "Press & hold the button to start the pump",
      duration: Duration(seconds: 5),
      animationDuration: Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOut,
    )..show(context);
  }

  int getIconColor() {
    switch (currentPump) {
      case PumpType.In:
        return 0xFF4CAF50;
        break;
      case PumpType.Out:
        return 0xFFAB000D;
        break;
      case PumpType.Off:
        return 0xFF494949;
        break;
      default:
        throw Exception("Unknown enum value");
    }
  }

  void enablePump(PumpType type) {
    if (currentPump == PumpType.Off) {
      switch(type) {
        case PumpType.In:
          messageCom.send("command", "P1");
          break;
        case PumpType.Out:
          messageCom.send("command", "P-1");
          break;
        default:
      }
    }
  }
  
  void disablePump(PumpType type) {
    if (currentPump == type) {
      messageCom.send("command", "P0");
    }
  }
}

enum PumpType {
  In,
  Out,
  Off,
}