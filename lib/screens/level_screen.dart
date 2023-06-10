import 'package:flutter/material.dart';
import '../main.dart';
import 'math_quiz_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    LevelScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  void navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MathQuizApp()),
        );
        break;
      case 1:
      // Navigate to history screen (HistoryScreen)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryScreen()),
        );
        break;
      case 2:
      // Navigate to settings screen (SettingsScreen)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Level'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('.../assets/background.png'), // Replace with your PNG image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathQuizScreen(level: 1),
                    ),
                  );
                },
                child: Text('Level 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathQuizScreen(level: 2),
                    ),
                  );
                },
                child: Text('Level 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathQuizScreen(level: 3),
                    ),
                  );
                },
                child: Text('Level 3'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathQuizScreen(level: 4),
                    ),
                  );
                },
                child: Text('Level 4'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: navigateToScreen,
      ),
    );
  }

}
