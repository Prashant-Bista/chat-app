import 'package:chat_app/services/navigation_sercvice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart/';

import 'package:flutter/services.dart';
class Splash extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const Splash({super.key, required this.onInitializationComplete});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _setup().then((_)=>widget.onInitializationComplete());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
height: 200,
            width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage("assets/images/chatapplogo2.png") ,filterQuality: FilterQuality.high,fit: BoxFit.fill)
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
  }
}
