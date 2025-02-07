//Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//Services
import '../Models/chat_user.dart';
import '../services/database_service.dart';
import '../services/navigation_service.dart';

//Models

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

   late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    _auth.authStateChanges().listen((_user) async{
      if (_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        print("UserLastSeenUpdated");
       try{
        await _databaseService.getUser(_user.uid).then(
               (_snapshot) {
             Map<String, dynamic> _userData =
             _snapshot.data()! as Map<String, dynamic>;


             user = ChatUser.fromJSON(
               {
                 "uid": _user.uid,
                 "name": _userData["name"],
                 "email": _userData["email"],
                 "last_active": _userData["last_active"],
                 "image_url": _userData["image_url"],
               },
             );
             print("Userset");
             _navigationService.removeAndNavigateToRoute('/home');
           },
         );
       }catch(e){

       }
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException {
      print("Error logging user into Firebase");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      print("Error registering user.");
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}