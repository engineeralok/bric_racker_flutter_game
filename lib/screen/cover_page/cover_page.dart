import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  final bool hasGameStarted;
  const CoverPage({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.2),
            child: Text(
              "Tap to play",
              style: TextStyle(
                color: Colors.green[400],
              ),
            ),
          );
  }
}
