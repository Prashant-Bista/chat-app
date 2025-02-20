import 'package:chat_app/Models/chat_message.dart';
import 'package:chat_app/Models/chat_user.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/providers/chats_page_provider.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';


import 'package:chat_app/widgets/custom_list_view_tiles.dart';

import '../Models/chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
 late NavigationService _nav ;
  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;

  late double _deviceWidth;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    _nav= GetIt.instance.get<NavigationService>();
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth)),
    ], child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<ChatsPageProvider>();
      return Scaffold(
        appBar: AppBar(
          title: Text("Chats"),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _chatsList(),
          ],
        ),
      );
    });
  }

  Widget _chatsList() {
    List<Chat>? _chats = _pageProvider.chats;
    return Expanded(
        child: (() {
      if (_chats != null) {
        if (_chats.length != 0) {
          return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return _chatTile(
                  _chats[index],
                );
              });
        } else {
          return Center(
            child: Text(
              "No Chats found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    }()));
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients= _chat.recepients();
    bool _isactive = _recepients.any((_d)=>_d.wasRecentlyActive());
    String _subtitleText ="";
    if(_chat.messages.isNotEmpty){
      _subtitleText = _chat.messages.first.type!=MessageType.TEXT?"Media Attatchment":_chat.messages.first.content;

    }
    return CustomListViewTile(
        height: _deviceHeight * 0.1,
        title: _chat.title(),
        subtitle: _subtitleText,
        imagePath: _chat.imageURL(),
        onTap: () {
          print(_chat.uid);
          _nav.navigateToPage(ChatPage(chat:_chat));
        },
        isActive: _isactive,
        isActivity: _chat.activity);
  }
}
