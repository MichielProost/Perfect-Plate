import 'package:yummytummy/model/board/series.dart';
import 'package:yummytummy/model/board/medal.dart';

import 'board_functions.dart';

class MedalBoard {

  Map seriesMap = new Map<String, Series>();
  Map medalMap = new Map<String, Medal>();

  MedalBoard({
    this.seriesMap,
    this.medalMap,
  });

  MedalBoard.fromMap(Map<String, dynamic> data)
    : this(
        seriesMap: data.containsKey('series') ?
          dataToSeriesMap(data['series']) : {},
        medalMap : data.containsKey('medals') ?
          dataToMedalMap(data['medals']) : {},
      );

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return {
      'series' : seriesMap != null ? seriesToDataMap(seriesMap) : {},
      'medals' : medalMap != null ? medalToDataMap(medalMap) : {},
    };
  }

  /// Print summary of medal board to console.
  printSummary(){
    var seriesList = seriesMap.entries.toList();
    for(int i = 0; i < seriesList.length; i++){
      print("Series $i: " + seriesList[i].key);
      Series series = seriesList[i].value;
      series.printSummary();
    }
    var medalList = medalMap.entries.toList();
    for(int i = 0; i < seriesList.length; i++){
      print("Medal $i: " + medalList[i].key);
      Medal medal = medalList[i].value;
      medal.printSummary();
    }
  }

}