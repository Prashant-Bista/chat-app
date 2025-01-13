import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/navigation_service.dart';

import '../Models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier{
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;
  AuthenticationProvider(){
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.authStateChanges().listen((User? _user) {
      if (_user != null) {
  _databaseService.updateUserLastSeenTime(_user.uid);
  _databaseService.getUser(_user.uid).then((_snapshot){
    Map<String,dynamic>_userData= _snapshot.data()! as Map<String,dynamic>;
    user = ChatUser.fromJSON({
            "uid": _user.uid,
            "name": _userData["name"],
            "email": _userData["email"],
            "last_active": _userData["last_active"],
            "image": _userData["image_url"],
          });
  });
  print(user);
          _navigationService.removeAndNavigateToRoute('/home');
        } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }
  Future<void> loginUsingEmailAndPassword(String _email,String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      if(_auth.currentUser!=null){
        _navigationService.removeAndNavigateToRoute('/home')
;      }
    }on FirebaseAuthException{
      print("Error logging user into Firebase");
    }catch(e){
print(e);
    }
  }
  Future<String?> signUpWithEmailAndPassword(String _email,String _password) async {
    try {
      UserCredential credentials= await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      print("signup happened");
      return credentials.user!.uid;
    }on FirebaseAuthException catch (e){
      print(e.code);
    }catch(e){
      print(e);
    }
  }
  void setUser(String uid){
    if (uid != null) {
      _databaseService.updateUserLastSeenTime(uid);
      print("user last seen Updated");
      _databaseService.getUser(uid).then((_snapShot) {
        Map<String, dynamic> _userData = _snapShot.data()! as Map<String, dynamic>;
        user = ChatUser.fromJSON({
          "uid": uid,
          "name": _userData["name"],
          "email": _userData["email"],
          "last_active": _userData["last_active"],
          "image": _userData["image_url"]
        },);
        _navigationService.removeAndNavigateToRoute('/home');
      },);
    } else {
      _navigationService.removeAndNavigateToRoute('/login');
    }
  }
  Future<void> logout() async{
    try{
      await _auth.signOut();
    }
        catch(e){
      print(e);
        }
  }

}