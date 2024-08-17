
class Goal {
  final String id;
  final String scoreA;
  final String scoreB;

  Goal({
    required this.id,
    required this.scoreA,
    required this.scoreB,
  });


  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json["id"],
      scoreA: json["scoreA"],
      scoreB: json["scoreB"]
    );
  }
}