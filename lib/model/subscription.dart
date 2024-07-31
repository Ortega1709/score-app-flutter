import 'package:score_app_flutter/model/team.dart';
import 'package:score_app_flutter/model/user.dart';

class Subscription {
  final String id;
  final Team team;

  Subscription({
    required this.id,
    required this.team,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json['id'],
    team: Team.fromJson(json['team']),
  );
}
