import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/chat_message.dart';

const String USER_COLLECTION ="users";
const String CHAT_COLLECTION ="chats";
const String MESSAGE_COLLECTION ="messages";

class DatabaseService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService(){}
  Future<DocumentSnapshot> getUser(String _uid) async {
    try {
      print(_uid);
      DocumentSnapshot snapshot = await _db.collection(USER_COLLECTION).doc(_uid).get();
      print("user recieved");
      return snapshot;
    } catch (e) {
      print("Error getting user: $e");
      rethrow;
    }
  }

  Future<void> updateUserLastSeenTime(String _uid) async{
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).update({"last_active":DateTime.now().toUtc()});
    }catch(e){
      print("databaseSErvice error");
    }
  }
  Future<void> createUser(String _uid,String _name,String _imageURL,String _email) async{
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).set({"name":_name,"image_url":_imageURL,"email":_email,"last_active":DateTime.now().toUtc()});
      print("user creation happened");
    }catch(e){
      print("user saving error");
      print(e);
    }
    }
    Stream<QuerySnapshot> getChatsForUser(String _uid){
    return _db.collection(CHAT_COLLECTION).where('members',arrayContains: _uid).snapshots();
    }

    Future<QuerySnapshot> getUsers({String? name}){
    Query _query = _db.collection(USER_COLLECTION);
    if(name!=null){
      _query = _query.where("name",isGreaterThanOrEqualTo: name).where("name",isLessThanOrEqualTo: name+"z");
    }
    return _query.get();
    }

    Future<QuerySnapshot> getLastMessageForChat(String _chatId) {
    return _db.collection(CHAT_COLLECTION).doc(_chatId).collection(MESSAGE_COLLECTION).orderBy("sent_time",descending: true).limit(1).get();
    }
    Stream<QuerySnapshot> streamMessagesForChat(String _chatID){

    return _db.collection(CHAT_COLLECTION).doc(_chatID).collection(MESSAGE_COLLECTION).orderBy("sent_time",descending: false).snapshots();
    }
    Future<void>deleteChat(String _chatID) async {
      try {
        await _db.collection(CHAT_COLLECTION).doc(_chatID).delete();
      } catch (e) {
        print(e);
      }
    }
    Future<DocumentReference?> createChat(Map<String,dynamic> _data) async{
    try{
      DocumentReference _chat= await _db.collection(CHAT_COLLECTION).add(_data);
return _chat;
    }
    catch(e){
      print(e);
    }
    }
    Future<void> addMessageToChat(String _chatId, ChatMessage _message) async{
      try{
        await _db.collection(CHAT_COLLECTION).doc(_chatId).collection(MESSAGE_COLLECTION).add(_message.toJson());
      }catch(e){
        print(e);
      }
    }
    Future<void> updateChatData(String _chatId, Map<String,dynamic>_data)async{
    try{
      await _db.collection(CHAT_COLLECTION).doc(_chatId).update(_data);
    }
    catch(e){
      print(e);
    }

}
  }
