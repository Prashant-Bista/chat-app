import 'package:chat_app/pages/splash.dart';
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
      title: "ChatItOut",
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(11, 28, 70, 1.0)
      ),
      home: Splash(onInitializationComplete: () {}),
    );
  }
}