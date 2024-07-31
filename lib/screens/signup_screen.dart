import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:score_app_flutter/model/user.dart';
import 'package:score_app_flutter/utils/constants.dart';

import '../widgets/m_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<User?> signUp(String username, String email, String password) async {
    const endpoint = '${Constants.host}api/v1/users/signup';
    final body = {
      "username": username,
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
        return User.fromJson(data);
      }
    } else {
      throw Exception('Failed to load teams');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Text(
                "Sign up",
                style: Theme.of(context)!
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              const SizedBox(height: 16),
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
                text: "Sign up",
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  if (formKey.currentState!.validate()) {
                    signUp(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
