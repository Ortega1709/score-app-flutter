import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/match.dart';

class MatchTile extends StatelessWidget {
  final Match match;
  final Function()? onTap;

  const MatchTile({
    super.key,
    required this.match,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: ListTile(
        title: Text(
          match.teamA.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          match.teamB.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: Text(match.status),
        onTap: onTap,
      ),
    );
  }
}
