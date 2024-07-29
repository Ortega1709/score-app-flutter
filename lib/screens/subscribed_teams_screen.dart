import 'package:flutter/material.dart';

class SubscribedTeamsScreen extends StatefulWidget {
  const SubscribedTeamsScreen({super.key});

  @override
  State<SubscribedTeamsScreen> createState() => _SubscribedTeamsScreenState();
}

class _SubscribedTeamsScreenState extends State<SubscribedTeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribed Teams'),
      ),
    );
  }
}
