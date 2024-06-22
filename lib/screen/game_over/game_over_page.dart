import 'package:flutter/material.dart';

class GameOverPage extends StatelessWidget {
  final bool isGameOver;
  const GameOverPage({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: Text("G A M E  O V E R",
                style: TextStyle(color: Colors.red[400])),
          )
        : Container();
  }
}
