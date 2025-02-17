import 'dart:async';

import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/cloud_storage_service.dart';
import 'package:chat_app/services/media_services.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'authentication_provider.dart';
import 'package:chat_app/Models/chat_message.dart';
import '';
class ChatPageProvider extends ChangeNotifier{
  late DatabaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;

  AuthenticationProvider _auth;
  ScrollController _messagesListViewController;

  late StreamSubscription _messagesStream;
  String _chatID;
  List<ChatMessage>? messages;
  String? _message;


  String get message{
    return message;
  }
  ChatPageProvider(this._chatID,this._auth,this._messagesListViewController){
    _db = GetIt.instance.get<DatabaseService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }
  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }
  void listenToMessages() async{
    try{
      _messagesStream = await _db.streamMessagesForChat(_chatID).listen((_snapshot){
        List<ChatMessage> _messages = _snapshot.docs.map((_m){
          Map<String,dynamic> _messageData =  _m.data() as Map<String,dynamic>;
          return ChatMessage.fromJson(_messageData);
      }).toList();
        messages = _messages;
        notifyListeners();
    });
    }catch(e){
      print("Erorr getting messages");
      print(e);
    }
  }
  void goBack(){
    _navigation.goBack();
  }
}