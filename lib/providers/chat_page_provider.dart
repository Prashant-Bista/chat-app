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
    return _message!;
  }
   set message(String value){
     _message=value;
  }
  ChatPageProvider(this._chatID,this._auth,this._messagesListViewController){
    _db = GetIt.instance.get<DatabaseService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    listenToMessages();
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
        print("Messages parsed: ${_messages.length}");
        messages = _messages;
        notifyListeners();
    });
    }catch(e){
      print("Erorr getting messages");
      print(e);
    }
  }
  void sendTextMessage()async {
    if(_message!=null){
      ChatMessage _messageToSend = ChatMessage(content: _message!, type: MessageType.TEXT, senderId: _auth.user.uid, sentTime: DateTime.now());
      await _db.addMessageToChat(_chatID, _messageToSend);
    }
  }
  void sendImageMessage()async{
    try{
      PlatformFile? _file = await _media.pickImageFromLibrary();
      if(_file!=null){
        String? _downloadURL = await _storage.saveChatImageToStorage(_chatID, _auth.user.uid, _file);
        ChatMessage _messageToSend = ChatMessage(content: _downloadURL!, type: MessageType.IMAGE, senderId: _auth.user.uid, sentTime: DateTime.now());
        _db.addMessageToChat(_chatID, _messageToSend);
      }

    }
    catch(e){

    }
  }
  void deleteChat(){
    goBack();
    _db.deleteChat(_chatID);
  }
  void goBack(){
    _navigation.goBack();
  }
}