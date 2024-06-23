import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickWidth;
  final double brickHeight;
  final bool brickBroken;
  const Brick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickWidth,
    required this.brickHeight,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            //  alignment:   Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            alignment: Alignment(brickX, brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                color: Colors.green,
              ),
            ),
          );
  }
}
