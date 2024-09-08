class ChatUser{
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  final DateTime lastActive;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.lastActive

  });
  factory ChatUser.fromJSON(Map<String,dynamic>_json){
    return ChatUser(uid: _json["uid"], name: _json['name'], email: _json['email'], imageURL:_json['imageURL'] , lastActive: _json['lastActive'],);

  }
  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "email": email,
      "last_active" : lastActive,
      "image": imageURL,

    };
  }
  String lastDayActive(){
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}/${lastActive.minute}/${lastActive.second}";
  }
  bool wasRecentlyActive(){
    return DateTime.now().difference(lastActive).inHours<=2;
  }
}