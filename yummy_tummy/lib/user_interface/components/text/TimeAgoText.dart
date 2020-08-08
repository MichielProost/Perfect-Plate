import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

enum TimeUnit {
  minutes,
  hours,
  days,
  weeks,
  date
}

const int millisecondsPerMinute = 60000;
const int millisecondsPerHour = 3600000;
const int millisecondsPerDay = 86400000;
const int millisecondsPerWeek = 604800000;
const int millisecondsPerMonth = 2419200000;

class TimeAgoText extends StatelessWidget {
  
  final Timestamp then;

  TimeAgoText(this.then);

  TimeUnit calculateTimeUnit(int deltaMilliseconds)
  {
    if (deltaMilliseconds < millisecondsPerHour)       // Less than 1h ago
      return TimeUnit.minutes;
    else if (deltaMilliseconds < millisecondsPerDay)   // Less than 24h ago
      return TimeUnit.hours;
    else if (deltaMilliseconds < millisecondsPerWeek)  // Less than 1 week ago
      return TimeUnit.days;
    else if (deltaMilliseconds < millisecondsPerMonth) // Less than 1 month ago
      return TimeUnit.weeks;
    else
      return TimeUnit.date;
  }

  /// Convert a number of milliseconds to an int in the given time unit
  /// Will return -1 when timeUnit is equal to TimeUnit.date as a date should be displayed
  /// Will also return -1 if no match is found (eg. switch statement is incomplete). In this case you may want to simply display the date anyway
  int millisecondsToUnit(int milliseconds, TimeUnit timeUnit)
  {
    switch(timeUnit) {
      case TimeUnit.minutes:
        return milliseconds ~/ millisecondsPerMinute;
      case TimeUnit.hours:
        return milliseconds ~/ millisecondsPerHour;
      case TimeUnit.days:
        return milliseconds ~/ millisecondsPerDay;
      case TimeUnit.weeks:
        return milliseconds ~/ millisecondsPerWeek;
      case TimeUnit.date:
        return -1;
    }
    return -1;
  }

  String dateToString(DateTime date)
  {
    String truncated = date.toString().split(' ')[0];
    String newDate = "";
    for (String sub in truncated.split('-'))
    {
      newDate = sub + '/' + newDate;
    }
    return newDate.substring(0, newDate.length-1);
  }


  @override
  Widget build(BuildContext context) {
    final Timestamp now = Timestamp.now();
    
    final int difference = now.millisecondsSinceEpoch - then.millisecondsSinceEpoch;
    TimeUnit timeUnit = calculateTimeUnit( difference );
    int time = millisecondsToUnit( difference , timeUnit);

    String timeIndicator;
    if (time == -1)
      timeIndicator = dateToString( then.toDate() );
    else
      timeIndicator =   Localization.instance.language.getMessage('posted_x_ago_prefix') 
                      + ' ' + time.toString() + ' ' + Localization.instance.language.getTimedisplay(timeUnit, time==1) + ' '
                      + Localization.instance.language.getMessage('posted_x_ago_suffix');

    return Text(
      timeIndicator
    );
  }

}