import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

class RankInformation extends StatelessWidget {
  
  RankInformation()
  {
    FirebaseAnalytics().logEvent(name: 'side_menu_submenu', parameters: {'Option': 'rank_information'} );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      
                      // Action row with close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CloseButton(),
                        ],
                      ),
                      
                      Text(
                        Localization.instance.language.getMessage( 'rank_overview_title' ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      for (RankType rank in RankType.values)
                        _RankProgressTile(rank, rank.getRequiredScore() != 0 ? Constants.appUser.score / rank.getRequiredScore() : 1.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ActionButton(
                          Localization.instance.language.getMessage( 'close_menu' ),
                          onClick: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1.0,
              width: 1.0,
            ),
          ),
        ],
      ),
    );
  }

}

class _RankProgressTile extends StatelessWidget {
  
  final RankType rank;
  final double progress;

  _RankProgressTile(this.rank, this.progress);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        accentColor: Constants.main,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              Localization.instance.language.rankName( rank ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Container(
                width: 100.0,
                child: LinearProgressIndicator(
                  backgroundColor: Constants.bg_gray,
                  value: progress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}