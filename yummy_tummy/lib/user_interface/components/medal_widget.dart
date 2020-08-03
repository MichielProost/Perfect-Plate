import 'package:flutter/material.dart';
import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/model/board/series/series.dart';
import 'package:yummytummy/user_interface/constants.dart';

class MedalWidget extends StatelessWidget {
  
  // Title display
  final String title;
  
  // Medal display
  final MedalType type;
  final bool isAchieved;
  
  // Next display
  final bool hasNext;
  final double progress;
  
  MedalWidget(this.title, this.type, this.isAchieved, this.hasNext, this.progress);
  MedalWidget.series(Series series) : 
    title       = series.getEarnedMedal() != null ? series.getEarnedMedal().title : series.title,
    type        = series.getEarnedMedal() != null ? series.getEarnedMedal().medalType : MedalType.bronze,
    isAchieved  = series.getEarnedMedal() != null,
    hasNext     = series.getMedalsAchieved() != series.getMedalAmount(),
    progress    = series.getProgress();

  Color getMedalColor()
  {
    if (! isAchieved)
      return Colors.grey[800];

    switch( type )
    {
      case MedalType.bronze:
        return Color(0xFFCD7F32);
        break;
      case MedalType.silver:
        return Color(0xFFC0C0C0);
        break;
      case MedalType.gold:
        return Color(0xFFFFD700);
        break;
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          
          // Medal name
          Text(
            title,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Show the achieved medal
          Image.asset(
            'icons/medal.png',
            height: 100.0,
            color: getMedalColor(),
          ),

          // Show progress to next
          // hasNext ?
          if (hasNext)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                backgroundColor: Constants.bg_gray,
                value: progress,
              ),
            ),
            // :
            // Text(''),
        ],
      ),
    );
  }

}