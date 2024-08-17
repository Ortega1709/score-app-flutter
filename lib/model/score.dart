class Score {
  final String match;
  final String scoreA;
  final String scoreB;

  Score({required this.match, required this.scoreA, required this.scoreB});

  factory Score.fromJson(Map<String, dynamic> data) {
    return Score(
      match: data['match'],
      scoreA: data['scoreA'],
      scoreB: data['scoreB'],
    );
  }
}