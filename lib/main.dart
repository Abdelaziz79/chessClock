import 'package:flutter/material.dart';
import 'modules/chess_clock_screen/chess_clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:false,
      home:ChessClock(),
    );
  }
}


