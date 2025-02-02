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
    try{
      _chatStream = _db.getChatsForUser(_auth.user.uid).listen((_snapshot) async{
        chats= await Future.wait(_snapshot.docs.map((_doc)async {
          Map<String,dynamic> _chatData = _doc.data() as Map<String,dynamic>;
          //Get Users in chat
          List<ChatUser> _members=[];
          for(var _uid in _chatData["members"]){
            DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
            Map<String,dynamic> _userData= _userSnapshot.data() as Map<String,dynamic>;
            _members.add(ChatUser.fromJSON(_userData));
          }
          //Get last messages
          List<ChatMessage> _messages =[];
          QuerySnapshot _chatMessage = await _db.getLastMessageForChat(_doc.id);
          if(_chatMessage.docs.isNotEmpty){
            Map<String,dynamic> _messageData = _chatMessage.docs.first.data()! as Map<String,dynamic>;
            ChatMessage _message  = ChatMessage.fromJson(_messageData);
            _messages.add(_message);
          }
          //Return chat Instance
          return Chat(uid: _doc.id, currentUserUid: _auth.user.uid, members: _members, messages: _messages, activity: _chatData["is_activity"], group:  _chatData["is_group"]);
        }).toList()) ;
        notifyListeners();
      });
    }catch(e){
      print("Error getting chats");
      print(e);
    }

  }


}
