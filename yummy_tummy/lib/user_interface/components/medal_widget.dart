import 'package:flutter/material.dart';
import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/model/board/series.dart';

class MedalWidget extends StatelessWidget {
  
  // Title display
  final String title;
  
  // Medal display
  final MedalType type;
  final bool isAchieved;
  
  // Next display
  final bool hasNext;
  final int current;
  final int goal;
  
  MedalWidget(this.title, this.type, this.isAchieved, this.hasNext, this.current, this.goal);
  MedalWidget.series(Series series, String seriesTitle) : 
    title       = series.getEarnedMedal() != null ? series.getEarnedMedal().title : seriesTitle,
    type        = series.getEarnedMedal() != null ? series.getEarnedMedal().medalType : MedalType.bronze,
    isAchieved  = series.getEarnedMedal() != null,
    hasNext     = series.getMedalsAchieved() != series.getMedalAmount(),
    // TODO replace score by actual progress
    current     = series.currentScore,
    goal        = series.getCurrentMedal() != null ? series.getCurrentMedal().score : 0;

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
              fontSize: 20.0,
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
            Text(
              'Next at: $current/$goal'
            ) 
            // :
            // Text(''),
        ],
      ),
    );
  }

}