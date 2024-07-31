import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:score_app_flutter/model/team.dart';

class TeamTile extends StatelessWidget {
  final Team team;
  final Function()? onTap;
  final Function()? onDelete;

  const TeamTile({
    super.key,
    required this.team,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: ListTile(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        leading: team.flag.endsWith(".svg")
            ? Hero(
                tag: team.id,
                child: SvgPicture.network(
                  team.flag,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) {
                    return const CircularProgressIndicator();
                  },
                ),
              )
            : Hero(
                tag: team.id,
                child: CachedNetworkImage(
                  imageUrl: team.flag,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  placeholder: (context, url) {
                    return const CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
        title: Text(team.name),
        subtitle: Text(team.country),
        trailing: onDelete!= null ? IconButton(onPressed: onDelete, icon: const Icon(Icons.notifications_off)) : null,
      ),
    );
  }
}
