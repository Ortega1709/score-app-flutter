import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:score_app_flutter/main.dart';
import 'package:score_app_flutter/screens/signup_screen.dart';
import 'package:score_app_flutter/utils/constants.dart';
import 'package:score_app_flutter/widgets/m_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signIn(String email, String password) async {
      const endpoint = '${Constants.host}api/v1/users/signin';
      final body = {
        "email": email,
        "password": password,
      };

      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        headers: headers,
        Uri.parse(endpoint),
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          final userData = User.fromJson(data);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', userData.id);
          prefs.setString('username', userData.username);
          prefs.setString('email', userData.email);

          User user = User(
            id: userData.id,
            username: userData.username,
            email: userData.email,
            password: userData.password,
          );

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => IndexScreen(user: user),
            ),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Authentication failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        throw Exception('Failed to load teams');
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Text(
                "Sign in",
                style: Theme.of(context)!
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 32),
              MButton(
                  text: "Sign in",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      signIn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    }
                  }),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignupScreen();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Don't have account ? Sign up",
                    style: Theme.of(context)!.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
