import 'package:cloud_firestore/cloud_firestore.dart';

const String User_Collection ="Users";
const String Chat_Collection ="chats";
const StringMessage_Collection ="Messages";

class DatabaseService{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  DatabaseService();

}
