import 'dart:convert';
import 'dart:io';

import 'package:fkafka/fkafka.dart';
import 'package:flutter/material.dart';
import 'package:kafkabr/kafka.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:score_app_flutter/widgets/match_tile.dart';
import 'package:score_app_flutter/model/match.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'match_details_screen.dart';

class MatchesScreen extends StatefulWidget {
  final User user;

  const MatchesScreen({super.key, required this.user});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {

  Future<List<Match>?> getAllMatches() async {
    final endpoint = '${Constants.host}api/v1/matches/${widget.user.id}';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Match.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }

  @override
  void initState() {
    getAllMatches();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: getAllMatches(),
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
                final match = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MatchTile(
                    match: match,
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MatchDetailsScreen(match: match);
                      }));
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
      ),
    );
  }
}
