import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/splash.dart';
import 'package:chat_app/services/navigation_sercvice.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(Splash(onInitializationComplete: ()=>runApp(MyApp())));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatItOut",
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(11, 28, 70, 1.0),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30,29,37,1.0))
      ),
      home: Login(),
      navigatorKey: NavigationService().navigatorKey,
      routes: {
        '/login': (_context)=>Login(),
      },
      initialRoute: '/login',
    );
  }
}