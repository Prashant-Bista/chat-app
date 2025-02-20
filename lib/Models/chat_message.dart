import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType{
  TEXT,
  IMAGE,
  UNKNOWN,
}

class ChatMessage{
  final String senderId;
  final MessageType type;
  final String content;
  final DateTime sentTime;
  ChatMessage({
    required this.content,
  required this.type,
  required this.senderId,
  required this.sentTime,

});
  factory ChatMessage.fromJson(Map<String,dynamic> _json){
    MessageType _messageType;
    switch(_json["type"]){
      case "text":
        _messageType = MessageType.TEXT;
        break;
      case "image":
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }
    print("messagetype set");
    return ChatMessage(content: _json["content"], type: _messageType, senderId: _json["sender_id"], sentTime: _json["sent_time"].toDate());

  }
  Map<String,dynamic> toJson(){
    String _messageType;
    switch(type){
      case MessageType.TEXT:
        _messageType = "text";
        break;
      case MessageType.IMAGE:
        _messageType = "image";
        break;
      default:
        _messageType = "";
    }
  return {
      "content": content,
    "type": _messageType,
    "sender_id": senderId,
    "sent_time":Timestamp.fromDate(sentTime),

  };
  }
}