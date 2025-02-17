import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/chats_page.dart';
import 'package:chat_app/pages/splash_page.dart';
import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/pages/home_page.dart';
import 'pages/register_page.dart';

void main() {
  runApp(SplashPage(key: UniqueKey(), onInitializationComplete: () {
    runApp(MainApp());
  })
);

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(create: (BuildContext _context){
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        title: "ChatItOut",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(
              color: Colors.white
            )
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
          bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30, 29, 37, 1.0)),
        ),
        home: HomePage(),
        navigatorKey: NavigationService.navigatorKey,
        routes: {
          "/login": (BuildContext context) => LoginPage(),
          "/home": (BuildContext context) => HomePage(),
          "/register": (BuildContext context) => RegisterPage(),
          "/chats_page":(BuildContext context) => ChatsPage(),
          "/chat":(BuildContext context) => ChatPage()



        },
      ),
    );
  }
}
