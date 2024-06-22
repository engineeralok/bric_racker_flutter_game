import 'dart:async';

import 'package:bric_racker/common/ball.dart';
import 'package:bric_racker/common/player.dart';
import 'package:bric_racker/screen/cover_page/cover_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ball alignment variables
  double ballX = 0;
  double ballY = 0;

  // setting for game
  bool hasGameStarted = false;

  double ballSpeedX = 5;
  double ballSpeedY = 5;

  // player variables
  double playerX = 0;
  double playerWidth = 0.3; // out of 2

  //Let's play the game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY += 0.006;
      });
    });
  }

  // Move player position to the Left
  void moveLeft() {
    setState(() {
      // only moving the play to the left if moving left doesn't move player off the screen
      // if (!(playerX - 0.2 <= -1)) {
      if (playerX > -0.991) {
        playerX -= 0.02;
      }
    });
  }

  // Move player position to the right
  void moveRight() {
    setState(() {
      // only moving the player to the right if moving right doesn't move player off the screen

      if (playerX < 1.3 - playerWidth) {
        playerX += 0.02;
      }
    });
  }

  Offset _lastTouchPosition = Offset.zero;

  void _onPanUpdate(DragUpdateDetails details) {
    final Offset delta = details.localPosition - _lastTouchPosition;
    // if (delta.dx > 0 && playerX < 1.3 - playerWidth) {
    if (delta.dx > 0) {
      moveRight();
      // } else if (delta.dx < 0 && playerX > -0.991) {
    } else if (delta.dx < 0) {
      moveLeft();
    }
    _lastTouchPosition = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          moveLeft();
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          moveRight();
        }
      },
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanStart: (details) => _lastTouchPosition = details.localPosition,
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.green[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play button
                CoverPage(hasGameStarted: hasGameStarted),

                // make a ball
                Ball(
                  ballX: ballX,
                  ballY: ballY,
                ),

                // make a player
                Player(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // where is playerX exactly?
                Container(
                  alignment: Alignment(playerX, 0.9),
                  child: Container(
                    color: Colors.red,
                    width: 4,
                    height: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
