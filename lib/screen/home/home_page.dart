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

// Direction
enum Direction { up, down }

class _HomePageState extends State<HomePage> {
  // ball alignment variables
  double ballX = 0;
  double ballY = 0;

  // Directions
  var ballDairection = Direction.down;

  // setting for game
  bool hasGameStarted = false;

  double ballSpeedX = 5;
  double ballSpeedY = 5;

  // player variables
  double playerX = -0.2;
  double playerWidth = 0.4; // out of 2

  // Focus node for keyboard input
  final FocusNode _focusNode = FocusNode();

  // Key press state
  final Set<LogicalKeyboardKey> _keysPressed = {};

  bool isGameOver = false;

  // Start the game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // Update Directions
      updateDirections();
      // Move ball
      moveBall();
      // Check if player dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  moveBall() {
    setState(() {
      if (ballDairection == Direction.down) {
        ballY += 0.006;
      } else if (ballDairection == Direction.up) {
        ballY -= 0.006;
      }
    });
  }

  // update direction of the ball
  updateDirections() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDairection = Direction.up;
      } else if (ballY <= -0.9) {
        ballDairection = Direction.down;
      }
    });
  }

  // Move player position to the Left
  void moveLeft() {
    setState(() {
      if (playerX > -0.991) {
        playerX -= 0.02;
      }
    });
  }

  void moveLeftWithArrowKey() {
    // Move ball
    setState(() {
      if (playerX > -0.991) {
        playerX -= 0.1;
      }
    });

    // Update directions
  }

  // Move player position to the right
  void moveRight() {
    setState(() {
      // only moving the player to the right if moving right doesn't move player off the screen

      if (playerX < 1 - playerWidth) {
        playerX += 0.02;
      }
    });
  }

  void moveRightWithArrowKey() {
    setState(() {
      // only moving the player to the right if moving right doesn't move player off the screen

      if (playerX < 1 - playerWidth) {
        playerX += 0.1;
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
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moveLeftWithArrowKey();
      }
      if (_keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moveRightWithArrowKey();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanStart: (details) => _lastTouchPosition = details.localPosition,
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        body: Center(
          child: KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: (KeyEvent event) {
              setState(() {
                if (event is KeyDownEvent) {
                  _keysPressed.add(event.logicalKey);
                  if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    moveLeftWithArrowKey();
                  } else if (event.logicalKey ==
                      LogicalKeyboardKey.arrowRight) {
                    moveRightWithArrowKey();
                  }
                } else if (event is KeyUpEvent) {
                  _keysPressed.remove(event.logicalKey);
                }
              });
            },
            child: Stack(
              children: [
                // Tap to play button
                CoverPage(hasGameStarted: hasGameStarted),

                // Ball
                Ball(
                  ballX: ballX,
                  ballY: ballY,
                ),

                // Player
                Player(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // Display playerX position
                // Container(
                //   alignment: Alignment(playerX, 0.9),
                //   child: Container(
                //     color: Colors.red,
                //     width: 4,
                //     height: 15,
                //   ),
                // ),
                // Container(
                //   alignment: Alignment(playerX + playerWidth, 0.9),
                //   child: Container(
                //     color: Colors.green,
                //     width: 4,
                //     height: 15,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
