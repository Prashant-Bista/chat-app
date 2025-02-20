import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/navigation_service.dart';

import 'package:chat_app/Models/chat_user.dart';
import 'package:chat_app/Models/chat.dart';

import 'package:chat_app/providers/authentication_provider.dart';

import 'package:chat_app/pages/chat_page.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;
  late DatabaseService _database;
  late NavigationService _navigation;

  List<ChatUser>? users;
  late List<ChatUser> _selectedUsers;
  List<ChatUser> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _database = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
    getUsers();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getUsers({String? name}) {
    _selectedUsers = [];
    try {
      _database.getUsers(name: name).then((_snapshot) {
        users = _snapshot.docs.map((_doc) {
          Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
          _data["uid"]=_doc.id;
          return ChatUser.fromJSON(_data);
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print("Error getting users");
      print(e);
    }
  }
}
