import 'package:flutter/material.dart';

class ReportCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TODO: separate the generation of checkboxes into a new class
      CheckboxListTile(
        value: true,
        title: const Text("Programmatically generate the list of buttons"),
        onChanged: (value) {},
        
      ),

      const SizedBox(height: 30),
        RaisedButton(
          onPressed: () {},
          padding: EdgeInsets.all(10.0),
          child: const Text(
            'Update',
            style: TextStyle(fontSize: 20)
          ),
        ),
      
      ],
    );
  }
}



// class ReportCheckboxItem extends  {

// }