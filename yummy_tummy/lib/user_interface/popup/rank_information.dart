import 'package:flutter/material.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/constants.dart';

class RankInformation extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 300.0),
      child: Card(
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
                    "These are the available ranks and your progress towards all of them.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  for (RankType rank in RankType.values)
                    _RankProgressTile(rank, rank.getRequiredScore() != 0 ? Constants.appUser.score / rank.getRequiredScore() : 1.0),

                  ActionButton(
                    "Close menu",
                    onClick: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
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
              rank.getString(),
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