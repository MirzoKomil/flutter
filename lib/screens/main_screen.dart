import 'package:flutter/material.dart';
import 'level_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('Main Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Implement your history menu functionality here
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LevelScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
