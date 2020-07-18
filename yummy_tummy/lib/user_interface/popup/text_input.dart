import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  
  final String title;
  final Map<String, String> textFields;
  final String field;

  TextInput(Map<String, String> textMap, this.field, {this.title = ""}):
  this.textFields = textMap != null ? textMap : Map<String, String>();

  @override
  State<StatefulWidget> createState() {
    return _TextInputState();
  }

}

class _TextInputState extends State<TextInput> {
  
  String input = "";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          if (widget.title != "")
            Text( widget.title ),

          TextFormField(
            controller: _controller,
            onSaved: (String newValue) {
              widget.textFields[ widget.field ] = newValue;
            },
          ),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => widget.textFields[ widget.field ] = _controller.text,
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

}