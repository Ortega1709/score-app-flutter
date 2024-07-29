import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffF9F9FB),
        appBarTheme: const AppBarTheme(
          color: Color(0xffF9F9FB),
        ),
      ),
      home: const TeamsScreen(),
    );
  }
}

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

