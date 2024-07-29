class Team {
  final String id;
  final String name;
  final String country;
  final String flag;

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.flag,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      flag: json['flag'],
    );
  }

}
