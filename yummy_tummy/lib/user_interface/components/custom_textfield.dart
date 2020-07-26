import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatefulWidget{
  
  final void Function(String content) callback;
  final void Function(String content) onChanged;
  final int maxLines;
  final String startValue;
  final String hint;

  final TextEditingController controller = TextEditingController();

  CustomTextField({this.hint, this.startValue, this.maxLines: 1, this.callback, this.onChanged, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (startValue != null) controller.text = startValue;
    return CustomTextFieldState();
  }
  
}

class CustomTextFieldState extends State<CustomTextField> {
  
  String getCurrentText()
  {
    return widget.controller.text;
  }

  void clearTextField()
  {
    widget.controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: true,
      controller: widget.controller,
      maxLines: widget.maxLines,
      onChanged: (String text) {
        if (widget.onChanged != null)
          widget.onChanged( text );
      },
      onFieldSubmitted: (String text) {
        if (widget.callback != null)
          widget.callback( text );
      },
      decoration: InputDecoration(
        focusColor: Constants.main,
        hintText: widget.hint,
      ),
    );
  }

}