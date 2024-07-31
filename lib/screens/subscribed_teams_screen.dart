import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:http/http.dart' as http;

import '../model/subscription.dart';
import '../utils/constants.dart';
import '../widgets/team_tile.dart';

class SubscribedTeamsScreen extends StatefulWidget {
  final User user;

  const SubscribedTeamsScreen({super.key, required this.user});

  @override
  State<SubscribedTeamsScreen> createState() => _SubscribedTeamsScreenState();
}

class _SubscribedTeamsScreenState extends State<SubscribedTeamsScreen> {
  Future<List<Subscription>?> getSubscribedTeams() async {
    final endpoint = '${Constants.host}api/v1/${widget.user.id}/subscriptions';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Subscription.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  deleteSubscription(String subscriptionId) async {
    final endpoint = '${Constants.host}api/v1/subscriptions/$subscriptionId';
    final response = await http.delete(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      setState(() {
        getSubscribedTeams();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Team unsubscribed'),
        ),
      );
    }
  }

  @override
  void initState() {
    getSubscribedTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribed Teams'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_active)),
          const SizedBox(width: 16)
        ],
      ),
      body: FutureBuilder(
        future: getSubscribedTeams(),
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
              final subscription = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TeamTile(
                    team: subscription.team,
                    onDelete: () {
                      deleteSubscription(subscription.id);
                    },
                    onTap: null),
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
