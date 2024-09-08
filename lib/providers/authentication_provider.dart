import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../services/database_sercvice.dart';
import '../services/navigation_sercvice.dart';

class AuthenticationProvider extends ChangeNotifier{
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  AuthenticationProvider(){
    _auth = FirebaseAuth.instance;
    _navigationService= GetIt.instance.get<NavigationService>();
    _databaseService =GetIt.instance.get<DatabaseService>();

  }
  // Future<void> LoginUsingEmailAndPassword(String _email,String _password)async{
  //   try{
  //     await _auth.signInWithEmailAndPassword(email: _email, password: _password);
  //   }catch (e){
  //     print("error");
  //   }
  // }
}