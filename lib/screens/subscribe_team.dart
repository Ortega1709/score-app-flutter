import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:score_app_flutter/model/team.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../widgets/m_button.dart';

class SubscribeTeam extends StatefulWidget {
  final User user;
  final Team team;

  const SubscribeTeam({super.key, required this.team, required this.user});

  @override
  State<SubscribeTeam> createState() => _SubscribeTeamState();
}

class _SubscribeTeamState extends State<SubscribeTeam> {
  subscribeTeam() async {
    const endpoint = '${Constants.host}api/v1/subscriptions';


    final body = {
      "user": widget.user.id,
      "team": widget.team.id,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Subscribed successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to subscribe"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team ${widget.team.name}"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Center(
            child: CircleAvatar(
              minRadius: 100,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: widget.team.flag.endsWith(".svg")
                  ? Hero(
                      tag: widget.team.id,
                      child: SvgPicture.network(
                        widget.team.flag,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) {
                          return const CircularProgressIndicator();
                        },
                      ),
                    )
                  : Hero(
                      tag: widget.team.id,
                      child: CachedNetworkImage(
                        imageUrl: widget.team.flag,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: ListTile(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                title: Text(widget.team.name),
                subtitle: Text(widget.team.country),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: MButton(
          text: "Subscribe",
          onPressed: () {
            subscribeTeam();
          },
        ),
      ),
    );
  }
}
