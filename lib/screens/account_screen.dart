import 'package:flutter/material.dart';
import 'package:score_app_flutter/model/user.dart';
import 'package:score_app_flutter/screens/sign_in_screen.dart';
import 'package:score_app_flutter/widgets/account_tile.dart';
import 'package:score_app_flutter/widgets/m_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final User user;
  const AccountScreen({super.key, required this.user});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  clearLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            AccountTile(
              user: User(
                id: widget.user.id,
                username: widget.user.username,
                email: widget.user.email,
                password: widget.user.password,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: MButton(
          text: "Logout",
          onPressed: () {
            clearLocalUserData();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
