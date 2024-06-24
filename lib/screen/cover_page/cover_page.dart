import 'package:bric_racker/screen/game_over/game_over_page.dart';
import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;
  const CoverPage({super.key, required this.hasGameStarted, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.4),
            child: Text(
             isGameOver ? "":"BRIC RACKER",
              style: GameOverPage.gameFont.copyWith(
                color: Colors.green[200],
              ),

              //  TextStyle(
              //   color: Colors.green[400],

              // ),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.4),
                child: Text(
                  "BRIC RACKER", style: GameOverPage.gameFont,
                  //  TextStyle(
                  //   color: Colors.green[400],

                  // ),
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: Text(
                  "Tap to play",
                  style: TextStyle(
                    color: Colors.green[400],
                  ),
                ),
              ),
            ],
          );
  }
}
