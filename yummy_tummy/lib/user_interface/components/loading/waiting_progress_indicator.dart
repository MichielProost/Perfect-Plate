import 'package:flutter/material.dart';

import '../../constants.dart';


class WaitingProgressIndicator extends StatelessWidget {
  
  final int total;
  final int current;

  WaitingProgressIndicator(this.current, this.total);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Constants.accent,
        valueColor: new AlwaysStoppedAnimation<Color>(Constants.main),
        value: total != null ? current / total : null,
        strokeWidth: 5.0,
      ));
  }

}