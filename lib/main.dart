
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/view/auth/auth_gate.dart';
import 'package:todo/view/controller/auth_provider.dart';
import 'package:todo/view/controller/todo_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo APP',
        home:AuthGate()
      ),
    );
  }
}

