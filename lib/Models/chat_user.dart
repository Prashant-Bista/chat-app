import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser{
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  late DateTime lastActive;
  ChatUser({
required this.uid,
required this.name,
  required this.email,
  required this.lastActive,
  required this.imageURL
  });
  factory ChatUser.fromJSON(Map<String,dynamic> _json){
    try{
      DateTime lastActive;

      if (_json["last_active"] is Timestamp) {
        lastActive = (_json["last_active"] as Timestamp).toDate();
      } else if (_json["last_active"] is String) {
        lastActive = DateTime.parse(_json["last_active"]);
      } else {
        lastActive = DateTime.now(); // Fallback in case of null or unexpected type
      }
      return ChatUser(uid: _json["uid"], name: _json["name"], email: _json["email"], lastActive: _json["last_active"].toDate(), imageURL: _json["image"]);
    }catch(e){
      print(e);
      return ChatUser(uid: _json["uid"], name: _json["name"], email: _json["email"], lastActive: _json["last_active"].toDate(), imageURL: _json["image"]);
    }
  }
  Map<String,dynamic> toMap(){
    return{
      "email": email,
      "name": name,
      "last_active": lastActive,
      "image": imageURL,
    };
  }
  String lastDayActive(){
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }
  bool wasRecentlyActive(){
    return DateTime.now().difference(lastActive).inHours<2;
  }

}