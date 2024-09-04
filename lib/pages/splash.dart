import 'package:chat_app/services/navigation_sercvice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/services.dart';
import 'package:chat_app/services/media_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_sercvice.dart';
class Splash extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const Splash({super.key, required this.onInitializationComplete});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_){_setup().then((_)=>widget.onInitializationComplete);
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatItOut",
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(11, 28, 70, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30,29,37,1.0))
      ),
      navigatorKey: NavigationService().navigatorKey,
      home: Scaffold(
        body: Center(
          child: Container(
      height: 200,
              width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/images/chatapplogo2.png") ,filterQuality: FilterQuality.high,fit: BoxFit.fill)
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _setup() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerService();
  }
  void _registerService(){
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorgaeService>(CloudStorgaeService());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }
}
