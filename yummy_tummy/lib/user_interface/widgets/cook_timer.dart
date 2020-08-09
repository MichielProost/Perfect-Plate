import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/constants.dart';

class CookTimer extends StatefulWidget{
  
  // The time this Timer will start counting down from in number of seconds.
  final int seconds;
  // The action that is called when the Timer is stopped by pressing the stop button.
  final VoidCallback onStop;
  // The action that is called, ONLY when the Timer finishes counting down to zero.
  final VoidCallback onFinished;

  CookTimer(this.seconds, {this.onStop, this.onFinished, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CookTimerState(this.seconds);
  }

}

class CookTimerState extends State<CookTimer> with SingleTickerProviderStateMixin {
 
  bool _isPaused = false;
  int _remainingSeconds;
  Color _backgroundColor = Constants.main; 
  Timer timer;
  AnimationController playPauseController;

  CookTimerState(this._remainingSeconds);


  bool get isPaused => _isPaused;
  /// Handle pause/continue and shows the appropriate animation
  set isPaused (bool isPaused) {
    setState(() {
      _isPaused = isPaused;
      _isPaused ? playPauseController.forward() : playPauseController.reverse();
    });
  }

  void setBackgroundColor( Color newBackgroundColor )
  {
    setState(() {
      _backgroundColor = newBackgroundColor;
    });
  }

  @override
  void initState() {
    super.initState();

    playPauseController = AnimationController(
        duration: const Duration(milliseconds: 500), 
        vsync: this
      );
    

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!_isPaused)
      {
        if (_remainingSeconds > 0)
          setState( () => _remainingSeconds-- );
        else {

          t.cancel();
          if (widget.onFinished != null)
            widget.onFinished();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    String minutes = (_remainingSeconds ~/ 60).toString();
    String seconds = (_remainingSeconds % 60).toString();
    
    minutes = minutes.length < 2 ? '0' + minutes : minutes;
    seconds = seconds.length < 2 ? '0' + seconds : seconds;

    return Card(
      color: _backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            
            // Timer
            Text(
              minutes + ':' + seconds,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),

            // Play/pause
            IconButton(
              color: Colors.white,
              onPressed: () => this.isPaused = !isPaused,
              icon: AnimatedIcon(
                icon: AnimatedIcons.pause_play,
                progress: playPauseController,
                size: 30.0
              ),
            ),

            // Stop
            IconButton(
              icon: Icon(
                Icons.stop,
                color: Colors.white,
                size: 30.0
              ),
              onPressed: () {
                if (widget.onStop != null)
                  widget.onStop();
              }
            ),

          ],

        ),
      ),
    );
  }

  @override
  void dispose() {
    playPauseController.dispose();
    timer.cancel();
    super.dispose();
  }

}