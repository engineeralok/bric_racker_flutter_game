import "package:bric_racker/models/game_state.dart";
import "package:bric_racker/screen/home/home_page.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
      // ChangeNotifierProvider(
      // create: (context) => GameState(),
      // child: const MyApp(),
      const MyApp()
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bric Racker',
      home: HomePage(),
    );
  }
}
