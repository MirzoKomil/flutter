import 'package:flutter/material.dart';
import 'screens/level_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MathQuizApp());
}

class MathQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
