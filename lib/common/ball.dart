import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool hasGameStarted;
  const Ball(
      {super.key,
      required this.ballX,
      required this.ballY,
      required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          )
        : Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              glowColor: Colors.green[400]!,
              child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
  }
}
