import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION ="users";
const String CHAT_COLLECTION ="chats";
const String MESSAGE_COLLECTION ="messages";

class DatabaseService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService(){}
  Future<DocumentSnapshot> getUser(String _uid) async {
    try {
      DocumentSnapshot snapshot = await _db.collection(USER_COLLECTION).doc(_uid).get();
      if (!snapshot.exists) {
        throw Exception("User not found");
      }
      return snapshot;
    } catch (e) {
      print("Error getting user: $e");
      rethrow;  // Re-throw to handle further upstream
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
    Future<QuerySnapshot> getLastMessageForChat(String _chatId){
    return _db.collection(CHAT_COLLECTION).doc(_chatId).collection(MESSAGE_COLLECTION).orderBy("sent_time",descending: true).limit(1).get();
    }
  }
