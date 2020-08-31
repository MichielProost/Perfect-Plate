import 'package:yummytummy/model/board/series/series.dart';

import 'board_functions.dart';

class MedalBoard {

  Map<String, Series> seriesMap = new Map<String, Series>();

  MedalBoard({
    this.seriesMap,
  });

  MedalBoard.fromMap(Map<String, dynamic> data)
    : this(
        seriesMap: data.containsKey('series') ?
          dataToSeriesMap(data['series']) : {},
      );

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return {
      'series' : seriesMap != null ? seriesToDataMap(seriesMap) : {},
    };
  }

  /// Print summary of [MedalBoard] to console.
  printSummary(){
    var seriesList = seriesMap.entries.toList();
    for(int i = 0; i < seriesList.length; i++){
      print("Series $i: " + seriesList[i].key);
      Series series = seriesList[i].value;
      series.printSummary();
    }
  }

}