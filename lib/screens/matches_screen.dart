import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';

class MatchesScreen extends StatefulWidget {
  final User user;
  const MatchesScreen({super.key, required this.user});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
    );
  }
}
