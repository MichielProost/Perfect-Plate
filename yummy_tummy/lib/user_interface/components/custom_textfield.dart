import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatefulWidget{
  
  final void Function(String content) callback;
  final int maxLines;
  final String hint;

  final TextEditingController controller = TextEditingController();

  CustomTextField({this.hint, this.maxLines: 1, this.callback, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
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