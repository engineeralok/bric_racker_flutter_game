import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double playerX;
  final double playerWidth;
  const Player({super.key, required this.playerX, required this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment(playerX, 0.9),
      alignment:
          Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          height: 10,
          width: MediaQuery.of(context).size.width * playerWidth / 2,
          color: Colors.green,
        ),
      ),
    );
  }
}
