import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/cloud_storage_service.dart';
import 'package:chat_app/services/media_services.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../services/database_service.dart';
class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      _setup().then((value) {
        widget.onInitializationComplete(); // Proceed to main app after setup
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ChatItOut",
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(30, 29, 37, 1.0)),
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/chatapplogo2.png'))),
            ),
          ),
        ));
  }

  Future<void> _setup() async {

    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false, // Disable offline persistence to ensure real-time data fetch
      );
      FirebaseFirestore.instance.clearPersistence(); // Clear cached data (optional)
      FirebaseFirestore.instance.enableNetwork();
    } catch (e) {
      print("Error initializing Firebase: $e");
    }

    _registerServices();
  }


  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorageService>(CloudStorageService());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }
}
