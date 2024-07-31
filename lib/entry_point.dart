import 'package:flutter/material.dart';
import 'package:score_app_flutter/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'model/user.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {

  @override
  void initState() {
    userAlreadyAuthenticated();
    super.initState();
  }

  userAlreadyAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userId')) {
      User user = User(
        id: prefs.getString("userId")!,
        username: prefs.getString("username")!,
        email: prefs.getString("email")!,
        password: prefs.getString("password") ?? "",
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => IndexScreen(user: user)),
              (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
