import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/login.dart';
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
    Future.delayed(const Duration(seconds: 3));
    _setup().then((_)=>    Navigator.pushReplacementNamed(context,'/login')
);


    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatItOut",
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30,29,37,1.0))
      ),
      navigatorKey: NavigationService().navigatorKey,
      home: Scaffold(
        body: Center(
          child: Container(
      height: 200,
              width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/images/chatapplogo2.png") ,filterQuality: FilterQuality.high,fit: BoxFit.fill)
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _setup() async{
    WidgetsFlutterBinding.ensureInitialized();
    print("BIndingensureInitialized");

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    
    _registerService();

  }
  void _registerService(){
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorageService>(CloudStorageService());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
    print("registered");
  }
}
