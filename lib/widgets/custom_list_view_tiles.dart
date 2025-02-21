import 'package:chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chat_app/Models/chat_message.dart';
import 'package:chat_app/Models/chat_user.dart';


class CustomListViewTile extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;
  CustomListViewTile({
    super.key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    required this.isActive,
    required this.isActivity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListTile(
        onTap: () => onTap(),
        minVerticalPadding: height * 0.20,
        leading: SizedBox(
          width: 55,
          child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 200,
                  backgroundImage: NetworkImage(imagePath),
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: isActive ? Colors.green : Colors.red,
                )
              ]),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: isActivity
            ? SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitThreeBounce(
                      color: Colors.white54,
                      size: height * 0.1,
                    ),
                  ],
                ),
              )
            : Text(
                subtitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
      ),
    );
  }
}
class CustomListViewTileWithSelected extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isSelected;
  final Function onTap;
  CustomListViewTileWithSelected({
    super.key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    required this.isActive,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListTile(
        trailing: isSelected?Icon(Icons.check,color: Colors.white,):null,
        onTap: () => onTap(),
        minVerticalPadding: height * 0.20,
        leading: SizedBox(
          width: 55,
          child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 200,
                  backgroundImage: NetworkImage(imagePath),
                ),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: isActive ? Colors.green : Colors.red,
                )
              ]),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle,
        style: TextStyle(color: Colors.white54,fontSize: 12,fontWeight: FontWeight.w400),),

      ),
    );
  }
}


class CustomChatListViewTile extends StatelessWidget {
  final double width;
  final double deviceWidth;
  final isOwnMessage;
  final ChatMessage message;
  final ChatUser sender;

  CustomChatListViewTile(
      {super.key,
      required this.width,
      required this.deviceWidth,
      required this.isOwnMessage,
      required this.message,
      required this.sender});

  @override
  Widget build(BuildContext context) {
    double deviceHeight= MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      child: Row(
        mainAxisAlignment:
            isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          isOwnMessage
              ? Container():CircleAvatar(
            backgroundImage: NetworkImage(sender.imageURL),
            radius: 15,
          )
          ,
          SizedBox(
            width: width * 0.05,
          ),
          message.type == MessageType.TEXT
              ? TextMessageBubble(message: message, height: deviceHeight*0.06, width: width, isOwnMessage: isOwnMessage)
              : ImageMessageBubble(message: message, height: deviceHeight*0.22, width: width*0.55, isOwnMessage: isOwnMessage),
        ],
      ),
    );
  }
}
