import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION ="users";
const String CHAT_COLLECTION ="chats";
const String MESSAGE_COLLECTION ="messages";

class DatabaseService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

}