import 'dart:async';
import 'package:bric_racker/common/ball.dart';
import 'package:bric_racker/common/brick.dart';
import 'package:bric_racker/common/player.dart';
import 'package:bric_racker/screen/cover_page/cover_page.dart';
import 'package:bric_racker/screen/game_over/game_over_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Direction
enum Direction { up, down, left, right }

class _HomePageState extends State<HomePage> {
  // ball alignment variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrement = 0.01;
  double ballYincrement = 0.01;

  // Directions
  // var ballDairection = Direction.down;
  var ballXDirection = Direction.left;
  var ballYDirection = Direction.down;

  // setting for game
  bool hasGameStarted = false;

  double ballSpeedX = 5;
  double ballSpeedY = 5;

  // Brick Varialbes
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.2; // out of 2
  static double brickHeight = 0.05; // out of 2
  static double brickGap = 0.03;
  static int numberOfBrickInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBrickInRow * brickWidth -
          (numberOfBrickInRow - 1) * brickGap);
  // bool brickBroken = false;

  List myBricks = [
    //[x, y, brocken = true / false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false]
  ];

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
    if (hasGameStarted == false) {
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

        // Check if brick is hit
        checkForBrockenBricks();
      });
    }
  }

  // check for brocken bricks
  void checkForBrockenBricks() {
    // check for when ball is inside the brick (aka hits the brick)
    for (var i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] && ballX <= myBricks[i][0] + brickWidth) {
        if (ballY >= myBricks[i][1] &&
            ballY <= myBricks[i][1] + brickHeight &&
            myBricks[i][2] == false) {
          setState(() {
            myBricks[i][2] = true;

            // since brick is brocken update ball direction
            // based on which side of brick it hits
            // to do this calculate the distance of the ball
            // from each of the 4 side.
            // the smallest distance is the side of the ball hit

            double leftSideDist = (myBricks[i][0] - ballX).abs();
            double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
            double topSideDist = (myBricks[i][1] - ballY).abs();
            double bottomSideDist =
                (myBricks[i][1] + brickHeight - ballY).abs();

            String min = findMin(
                leftSideDist, rightSideDist, topSideDist, bottomSideDist);

            switch (min) {
              case "left":
                ballXDirection = Direction.left;
                break;
              case "right":
                ballXDirection = Direction.right;
                break;
              case "top":
                ballYDirection = Direction.up;
                break;
              case "bottom":
                ballYDirection = Direction.down;
                break;
            }

            // // if ball hit bottom side of brick then
            // ballYDirection = Direction.down;

            // // if ball hit top side of brick then
            // ballYDirection = Direction.up;

            // // if ball hit right side of brick then
            // ballXDirection = Direction.right;

            // // if ball hit left side of brick then
            // ballXDirection = Direction.left;
          });
        }
      }
    }
  }

  // return the smallest side
  String findMin(double a, double b, double c, double d) {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];

    double currentMin = 0;

    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'top';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'bottom';
    }

    return '';
  }

  // is player dead
  bool isPlayerDead() {
    // player dies if ball reaches the bottom of the screen
    if (ballY >= 0.8) {
      return true;
    }
    return false;
  }

  moveBall() {
    setState(() {
      // Move Horizontally
      if (ballXDirection == Direction.left) {
        // ballX -= 0.006;
        ballX -= ballXincrement;
      } else if (ballXDirection == Direction.right) {
        // ballX += 0.006;
        ballX += ballXincrement;
      }

      //
      if (ballYDirection == Direction.down) {
        // ballY += 0.006;
        ballY += ballYincrement;
      } else if (ballYDirection == Direction.up) {
        // ballY -= 0.006;
        ballY -= ballYincrement;
      }
    });
  }

  // update direction of the ball
  updateDirections() {
    setState(() {
      // ball goes up when it hits the player
      if (ballY >= 0.65 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      }
      // ball goes down when it hits the top of the screen
      else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }
      // ball goes left when it hits the right of the screen
      else if (ballX >= 1) {
        ballXDirection = Direction.left;
      }
      // ball goes right when it hits the left of the screen
      else if (ballX <= -1) {
        ballXDirection = Direction.right;
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
    // Move player
    setState(() {
      if (playerX > -0.991) {
        playerX -= 0.1;
      }
    });
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

  // reset gmae back to initial values when user hits the restart button
  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      myBricks = [
        //[x, y, brocken = true / false]
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false]
      ];
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
        body: SafeArea(
          child: Center(
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
                    } else if (event.logicalKey == LogicalKeyboardKey.space) {
                      startGame();
                    }
                  } else if (event is KeyUpEvent) {
                    _keysPressed.remove(event.logicalKey);
                  }
                });
              },
              child: Stack(
                children: [
                  // Tap to play button
                  CoverPage(
                    hasGameStarted: hasGameStarted,
                    isGameOver: isGameOver,
                  ),

                  // Game Over Screen
                  GameOverPage(
                    isGameOver: isGameOver,
                    function: resetGame,
                  ),

                  // Ball
                  Ball(
                    ballX: ballX,
                    ballY: ballY,
                    hasGameStarted: hasGameStarted,
                  ),

                  // Player
                  Player(
                    playerX: playerX,
                    playerWidth: playerWidth,
                  ),

                  // bricks
                  Brick(
                    brickX: myBricks[0][0],
                    brickY: myBricks[0][1],
                    brickBroken: myBricks[0][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                  ),

                  Brick(
                    brickX: myBricks[1][0],
                    brickY: myBricks[1][1],
                    brickBroken: myBricks[1][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                  ),
                  Brick(
                    brickX: myBricks[2][0],
                    brickY: myBricks[2][1],
                    brickBroken: myBricks[2][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
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
      ),
    );
  }
}
