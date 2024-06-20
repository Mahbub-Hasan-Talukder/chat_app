import 'package:chat_app/core/theme/theme.dart';
import 'package:chat_app/features/sign_up/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeClass.theme,
      home: SignUp(),
    );
  }
}
