import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/goal.dart';
import 'package:score_app_flutter/model/match.dart';
import 'package:score_app_flutter/model/score.dart';
import 'package:score_app_flutter/services/notification_service.dart';
import 'package:score_app_flutter/utils/constants.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:http/http.dart' as http;

class MatchDetailsTile extends StatefulWidget {
  final Match match;
  const MatchDetailsTile({super.key, required this.match});

  @override
  State<MatchDetailsTile> createState() => _MatchDetailsTileState();
}

class _MatchDetailsTileState extends State<MatchDetailsTile> {
  late StompClient stompClient;
  String scoreA = '0';
  String scoreB = '0';

  @override
  void initState() {
    initializeStompClient();
    initializeScore();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    stompClient.deactivate();
  }

  initializeScore() async {
    final endpoint =
        '${Constants.host}api/v1/matches/current/${widget.match.id}';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final goals = data['goals'] as List;

      if (goals.isNotEmpty) {
        final goal = goals.last;
        setState(() {
          scoreA = goal['scoreA'].toString();
          scoreB = goal['scoreB'].toString();
        });
      }
      //return data.map((json) => Match.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }

  initializeStompClient() async {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '${Constants.host}ws',
        onConnect: (StompFrame frame) {
          debugPrint('Connected to STOMP server');
          stompClient.subscribe(
            destination: '/topic/score/${widget.match.id}',
            callback: (StompFrame frame) async {
              if (frame.body != null) {
                final scoreDecode = json.decode(frame.body!);
                final score = Score.fromJson(scoreDecode);

                setState(() {
                  scoreA = score.scoreA.toString();
                  scoreB = score.scoreB.toString();
                });

                await NotificationService.showNotification(
                  title: "But ! ⚽",
                  body:
                      '${widget.match.teamA.name} - ${score.scoreA} : ${score.scoreB} - ${widget.match.teamB.name}',
                );
              }
            },
          );
        },
        onWebSocketError: (error) => debugPrint('WebSocket error: $error'),
        beforeConnect: () async {
          debugPrint('Connecting to STOMP server...');
        },
      ),
    );
    stompClient.activate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.match.teamA.flag,
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
                const SizedBox(height: 16.0),
                Text(
                  widget.match.teamA.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(width: 32.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scoreA,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " - ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      scoreB,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  widget.match.status,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            const SizedBox(width: 32.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.match.teamB.flag,
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
                const SizedBox(height: 16.0),
                Text(
                  widget.match.teamB.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
