import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverPage extends StatelessWidget {
  final bool isGameOver;
  final VoidCallback function;
  const GameOverPage({
    super.key,
    required this.isGameOver,
    required this.function,
  });

  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
    color: Colors.green[600],
    letterSpacing: 0,
    fontSize: 20,
  ));

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  "G A M E  O V E R",
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.green[400],
                      child: const Text(
                        "T A P  T O  R E S T A R T",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
