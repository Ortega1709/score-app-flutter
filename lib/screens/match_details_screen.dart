import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/match.dart';
import 'package:score_app_flutter/widgets/match_details_tile.dart';

class MatchDetailsScreen extends StatefulWidget {
  final Match match;
  const MatchDetailsScreen({super.key, required this.match});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MatchDetailsTile(match: widget.match),
          ),
        ],
      ),
    );
  }
}
