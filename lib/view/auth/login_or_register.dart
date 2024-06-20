
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view/controller/auth_provider.dart';
import 'package:todo/view/login_screen/login_screen.dart';
import 'package:todo/view/register_screen/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    if (authprovider.showLoginPage) {
      return LoginPage(onTap: authprovider.togglepages);
    } else {
      return RegisterPage(onTap: authprovider.togglepages);
      
    }
  }
}
