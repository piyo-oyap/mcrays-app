import 'package:aquaphonics/message_communication.dart';
import 'package:flutter/material.dart';

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
    currentPump = null;
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
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump In"),
            onPressed: () {},
            // onLongPress: () {},
            padding: EdgeInsets.all(10.0),
          ),
          // onTap: () => ,
          onLongPress: () => enablePump(PumpType.In),
          onLongPressUp: () => disablePump(PumpType.In),
        ),
        
        GestureDetector(
          child: RaisedButton(
            child: Text("Pump Out"),
            onPressed: () {},
            // onLongPress: () {},
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
          _setCurrentPump(null);
          break;
      }
    }
  }

  void enablePump(PumpType type) {
    if (currentPump == null) {
      switch(type) {
        case PumpType.In:
          messageCom.send("command", "P1");
          break;
        case PumpType.Out:
          messageCom.send("command", "P-1");
          break;
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
}