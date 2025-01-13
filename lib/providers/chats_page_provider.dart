import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_app/services/database_service.dart';

import 'authentication_provider.dart';

import 'package:chat_app/Models/chat_user.dart';
import 'package:chat_app/Models/chat.dart';
import 'package:chat_app/Models/chat_message.dart';


class ChatsPageProvider extends ChangeNotifier{
  AuthenticationProvider _auth;
  late DatabaseService _db;
  List<Chat>? chats;
  late StreamSubscription _chatStream;
  ChatsPageProvider(this._auth){
    _db=GetIt.instance.get<DatabaseService>();
    getChats();
  }
  @override
  void dispose() {
    _chatStream.cancel();
    super.dispose();
  }
  void getChats() async{

  }


}
