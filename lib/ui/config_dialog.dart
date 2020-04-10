import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aquaphonics/config_manager.dart';
import 'gui_helper.dart';
import 'package:aquaphonics/websocket_helper.dart';
import 'package:string_validator/string_validator.dart' as validator;

class ConfigIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigIcon();
}

class _ConfigIcon extends State<ConfigIcon> {
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () => _showConfig(context),
    );
  }

  void _showConfig(BuildContext context) async {
    const _textLabel = TextStyle(fontSize: 14);
    var _formKey = GlobalKey<FormState>();

    TextEditingController _controllerIP = TextEditingController(
      text: await Config.getString(ConfigKeys.ip)
    );
    
    TextEditingController _controllerPort = TextEditingController(
      text: (await Config.getInt(ConfigKeys.port)).toString()
    );

    
    return showDialog<void>(
      context: context,
      builder: (BuildContext innerContext) {
        return AlertDialog(
          title: Text("Settings"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Server IP Address:", style: _textLabel),
                  TextFormField(
                    enableSuggestions: false,
                    controller: _controllerIP,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter> [
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                    validator: (String value) {
                      if (!validator.isIP(value)) {
                        return "Invalid IP Address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Server Port:", style: _textLabel),
                  TextFormField(
                    enableSuggestions: false,
                    controller: _controllerPort,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter> [
                      BlacklistingTextInputFormatter.singleLineFormatter,
                    ],
                    validator: (String value) {
                      if (value.startsWith("-") || !validator.isInt(value)) {
                        return "Invalid Port Number";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                // can't dispose TextEditingController w/o throwing exception... :/
                  Navigator.of(innerContext).pop();
              },
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Config.setString(ConfigKeys.ip, _controllerIP.text);
                  Config.setInt(ConfigKeys.port, validator.toInt(_controllerPort.text));

                  GuiHelper.showToast("Settings saved successfully");
                  // TODO: prevent reconnection if ip/port pair is left unchanged
                  sockets.connect();
                  Navigator.of(innerContext).pop();
                }
              },
            ),
          ],
        );
      }
    );
  }
}