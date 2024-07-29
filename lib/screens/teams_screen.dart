import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:score_app_flutter/widgets/m_button.dart';
import 'package:score_app_flutter/widgets/team_tile.dart';
import 'package:http/http.dart' as http;

import '../model/team.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  Future<List<Team>?> getTeams() async {
    const endpoint = 'http://localhost:8080/api/v1/teams';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Team.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  @override
  Widget build(BuildContext context) {
    void showSuscribeModalSheet(Team team, BuildContext context) {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text(
                    "Suscribe team ${team.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TeamTile(team: team, onTap: null),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MButton(text: "Suscribe", onPressed: () {}),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    }

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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final team = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TeamTile(
                  team: team,
                  onTap: () {
                    showSuscribeModalSheet(team, context);
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
