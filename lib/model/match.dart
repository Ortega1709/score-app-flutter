import 'package:score_app_flutter/model/team.dart';

import 'goal.dart';

class Match {
  final String id;
  final Team teamA;
  final Team teamB;
  final String status;
  final List<Goal> goals;

  Match({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.status,
    required this.goals,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json["id"],
      teamA: Team.fromJson(json["teamA"]),
      teamB: Team.fromJson(json["teamB"]),
      status: json["status"],
      goals: [],
    );
  }
}
