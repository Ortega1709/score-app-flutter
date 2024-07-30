import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_app_flutter/screens/matches_screen.dart';
import 'package:score_app_flutter/screens/sign_in_screen.dart';
import 'package:score_app_flutter/screens/subscribed_teams_screen.dart';
import 'package:score_app_flutter/screens/teams_screen.dart';

void main() {
  runApp(const ScoreApp());
}

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xffF9F9FB),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Color(0xffF9F9FB),
          backgroundColor: Color(0xffF9F9FB),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 1,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentIndex = 0;
  final screens = const [
    TeamsScreen(),
    SubscribedTeamsScreen(),
    MatchesScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.group_solid,
              size: 24,
            ),
            label: "Teams",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.sportscourt_fill,
              size: 24,
            ),
            label: "Matches",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bell_fill,
              size: 24,
            ),
            label: "Subscribed Teams",
          ),
        ],
      ),
    );
  }
}

