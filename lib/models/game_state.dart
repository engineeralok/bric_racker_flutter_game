import 'package:bric_racker/screen/home/home_page.dart';
import 'package:flutter/foundation.dart';

class GameState with ChangeNotifier {
  // Ball properties
  double ballX = 0;
  double ballY = 0;
  double ballXincrement = 0.01;
  double ballYincrement = 0.01;
  Direction ballXDirection = Direction.left;
  Direction ballYDirection = Direction.down;

  // Player properties
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Game state
  bool hasGameStarted = false;
  bool isGameOver = false;

  // Bricks properties
  List<List<dynamic>> myBricks = [
    // Add initial brick properties here
  ];

  // Methods to update the state
  void startGame() {
    hasGameStarted = true;
    notifyListeners();
  }

  void moveBall() {
    if (ballXDirection == Direction.left) {
      ballX -= ballXincrement;
    } else if (ballXDirection == Direction.right) {
      ballX += ballXincrement;
    }

    if (ballYDirection == Direction.down) {
      ballY += ballYincrement;
    } else if (ballYDirection == Direction.up) {
      ballY -= ballYincrement;
    }
    notifyListeners();
  }

  void movePlayerLeft() {
    if (playerX > -0.991) {
      playerX -= 0.02;
      notifyListeners();
    }
  }

  void movePlayerRight() {
    if (playerX < 1 - playerWidth) {
      playerX += 0.02;
      notifyListeners();
    }
  }

  // Add other game state methods here
}
