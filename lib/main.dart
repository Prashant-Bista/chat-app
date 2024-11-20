import 'package:chat_app/pages/splash_page.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(SplashPage(key: UniqueKey(), onInitializationComplete: () {
    runApp(MainApp());
  }));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatItOut",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
        bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30, 29, 37, 1.0)),
      ),
      home: LoginPage(),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: "/login",  // Start with login page
      routes: {
        "/login": (BuildContext context) => LoginPage(),
      },
    );
  }
}
