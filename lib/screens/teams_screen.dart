import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:score_app_flutter/screens/subscribe_team.dart';
import 'package:score_app_flutter/utils/constants.dart';
import 'package:score_app_flutter/widgets/m_button.dart';
import 'package:score_app_flutter/widgets/team_tile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/team.dart';

class TeamsScreen extends StatefulWidget {
  final User user;

  const TeamsScreen({super.key, required this.user});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {

  Future<List<Team>?> getTeams() async {
    const endpoint = '${Constants.host}api/v1/teams';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Team.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final team = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TeamTile(
                  team: team,
                  onDelete: null,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SubscribeTeam(
                          team: team,
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
          );
        },
      ),
    );
  }
}
