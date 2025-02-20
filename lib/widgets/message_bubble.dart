import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:chat_app/Models/chat_message.dart';
import 'package:http/http.dart' as http;

class TextMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final ChatMessage message;
  final double height;
  final double width;
  TextMessageBubble(
      {super.key,
      required this.message,
      required this.height,
      required this.width,
      required this.isOwnMessage});

  @override
  Widget build(BuildContext context) {
    List<Color> _colorScheme = isOwnMessage
        ? [Color.fromRGBO(0, 135, 250, 1.0), Color.fromRGBO(0, 85, 220, 1.0)]
        : [Color.fromRGBO(50, 50, 70, 1.0), Color.fromRGBO(50, 50, 70, 1.0)];
    return Container(
      height: height + (message.content.length / 20 * 6.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: _colorScheme,
              stops: [0.30, 0.70],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Column(
        spacing: height*0.02,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            timeago.format(message.sentTime),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ImageMessageBubble extends StatefulWidget {
  final bool isOwnMessage;
  final ChatMessage message;
  final double height;
  final double width;
  ImageMessageBubble(
      {super.key,
      required this.width,
      required this.isOwnMessage,
      required this.message,
      required this.height});

  @override
  State<ImageMessageBubble> createState() => _ImageMessageBubbleState();
}

class _ImageMessageBubbleState extends State<ImageMessageBubble> {
  void checkImageUrl() async {
    final response = await http.get(Uri.parse("https://www.hindustantimes.com/ht-img/img/2025/01/13/550x309/prayagraj_maha_kumbh_1736743787205_1736772264252.jfif"));
    print("Image Status Code: ${response.statusCode}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> _colorScheme = widget.isOwnMessage
        ? [Color.fromRGBO(0, 135, 250, 1.0), Color.fromRGBO(0, 85, 220, 1.0)]
        : [Color.fromRGBO(50, 50, 70, 1.0), Color.fromRGBO(50, 50, 70, 1.0)];
    DecorationImage _image = DecorationImage(
        image: NetworkImage(this.widget.message.content,),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high);
    return Container(
      height: widget.height + (widget.message.content.length / 15 * 6.0),
      padding: EdgeInsets.symmetric(
          horizontal: widget.width * 0.02, vertical: widget.height * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: _colorScheme,
              stops: [0.30, 0.70],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: _image,
            ),
          ),
          Text(
            timeago.format(widget.message.sentTime),
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

}
