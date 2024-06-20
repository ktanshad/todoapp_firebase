
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/auth/login_or_register.dart';
import 'package:todo/view/controller/auth_provider.dart';
import 'package:todo/view/todolist_screen/todolist_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: authProvider.user != null ? TodoListPage() : LoginOrRegister(),
    );
  }
}
