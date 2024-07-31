import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';

class AccountTile extends StatelessWidget {
  final User user;
  const AccountTile({super.key, required this.user});

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
        leading: CircleAvatar(
          child: Text(user.username[0].toUpperCase()),
        ),
        title: Text(user.username),
        subtitle: Text(user.email),
      ),
    );
  }
}
