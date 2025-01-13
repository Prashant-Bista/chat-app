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
    return ListTile(
      onTap: onTap(),
      minVerticalPadding: height*0.20,
      leading: SizedBox(
        width: 55,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [CircleAvatar(
            radius: 200,
            backgroundImage: NetworkImage(imagePath),
          ),
          CircleAvatar(
            radius: 5,
            backgroundColor: isActive?Colors.green:Colors.red,
          )]
        ),
      ),
      title: Text(title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,),),
      subtitle: isActivity?Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitThreeBounce(color: Colors.white54,size: height*0.10,),
        ],
      ):Text(subtitle,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
    );
  }
}
