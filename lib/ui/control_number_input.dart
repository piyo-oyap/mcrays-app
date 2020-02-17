import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NumberInput();
}

class _NumberInput extends State<NumberInput> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
        ),
        RaisedButton(
          padding: EdgeInsets.all(0.0),
          textColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Styled RaisedButton',
              style: TextStyle(fontSize: 17)
            ),
          ),
          onPressed: () => {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}