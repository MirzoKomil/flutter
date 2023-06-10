import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class MathQuizScreen extends StatefulWidget {
  final int level;

  const MathQuizScreen({Key? key, required this.level}) : super(key: key);

  @override
  _MathQuizScreenState createState() => _MathQuizScreenState();
}

class _MathQuizScreenState extends State<MathQuizScreen> {
  int _selectedIndex = 0;
  int number1 = 0;
  int number2 = 0;
  String operator = '';
  int answer = 0;
  int score = 0;
  int questionCount = 0;
  int maxQuestions = 10;
  Timer? timer;
  int remainingTime = 0;
  List<int> answerOptions = [];

  @override
  void initState() {
    super.initState();
    startQuiz();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startQuiz() {
    generateQuestion();
    startTimer();
  }

  void generateQuestion() {
    Random random = Random();
    number1 = random.nextInt(12) + 1;
    number2 = random.nextInt(12) + 1;

    if (widget.level == 1) {
      operator = '+';
      answer = number1 + number2;
    } else if (widget.level == 2) {
      operator = '-';
      // Ensure the answer is always non-negative
      answer = max(number1, number2) - min(number1, number2);
    } else if (widget.level == 3) {
      operator = 'x';
      answer = number1 * number2;
    } else if (widget.level == 4) {
      operator = '÷';
      // Ensure the division has no remainder
      int quotient = number1 ~/ number2;
      int remainder = number1 % number2;
      answer = remainder == 0 ? quotient : quotient + 1;
    }

    generateAnswerOptions();
  }


  void generateAnswerOptions() {
    answerOptions.clear();
    Random random = Random();
    answerOptions.add(answer);

    while (answerOptions.length < 4) {
      int option = random.nextInt(20) + 1;
      if (!answerOptions.contains(option)) {
        answerOptions.add(option);
      }
    }

    answerOptions.shuffle();
  }

  void startTimer() {
    int duration;

    if (widget.level == 1) {
      duration = 0;
    } else if (widget.level == 2) {
      duration = 30;
    } else if (widget.level == 3) {
      duration = 20;
    } else if (widget.level == 4) {
      duration = 10;
    } else {
      // Default duration if level is not 1, 2, 3, or 4
      duration = 0;
    }

    remainingTime = duration;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          // Perform actions when time is up
        }
      });
    });
  }

  void checkAnswer(int? userAnswer) {
    if (userAnswer == answer) {
      score++;
    }

    questionCount++;

    if (questionCount < maxQuestions) {
      generateQuestion();
      resetTimer();
    } else {
      endQuiz();
    }
  }

  void resetTimer() {
    if (timer != null) {
      timer!.cancel();
    }

    startTimer();
  }

  void endQuiz() {
    timer!.cancel();
    Navigator.pop(context);
  }

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
        title: Text('Math Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question: $questionCount/$maxQuestions',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            '$number1 $operator $number2 = ?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Time Remaining: $remainingTime seconds',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < answerOptions.length; i += 2)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => checkAnswer(answerOptions[i]),
                      child: Text('${answerOptions[i]}'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i < answerOptions.length; i += 2)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => checkAnswer(answerOptions[i]),
                      child: Text('${answerOptions[i]}'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Score: $score',
            style: TextStyle(fontSize: 20),
          ),
        ],
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
        selectedItemColor: Colors.blue, // Set the color for the selected item
        onTap: navigateToScreen,
      ),
    );
  }
}
