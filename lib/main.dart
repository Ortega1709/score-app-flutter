import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:score_app_flutter/screens/account_screen.dart';
import 'package:score_app_flutter/screens/matches_screen.dart';
import 'package:score_app_flutter/screens/subscribed_teams_screen.dart';
import 'package:score_app_flutter/screens/teams_screen.dart';
import 'package:score_app_flutter/entry_point.dart';
import 'package:score_app_flutter/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.intitializeNotification();
  runApp(const ScoreApp());
}

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Score App',
      theme: ThemeData(
        fontFamily: "Helvetica",
        colorScheme: const ColorScheme.light(primary: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xffF9F9FB),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Color(0xffF9F9FB),
          backgroundColor: Color(0xffF9F9FB),
          centerTitle: false
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
      home: const EntryPoint(),
    );
  }
}

class IndexScreen extends StatefulWidget {
  final User user;
  const IndexScreen({super.key, required this.user});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final screens = [
      TeamsScreen(user: widget.user),
      MatchesScreen(user: widget.user),
      SubscribedTeamsScreen(user: widget.user),
      AccountScreen(user: widget.user)
    ];

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
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_alt_circle_fill,
              size: 24,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
