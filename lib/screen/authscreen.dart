import 'package:flutter/material.dart';
import 'package:todo_app/screen/authform.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        centerTitle: true,
      ),
      body: AuthForm(),
    );
  }
}
