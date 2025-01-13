import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/providers/chats_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:chat_app/widgets/topbar.dart';

import 'package:chat_app/widgets/custom_list_view_tiles.dart';
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  AuthenticationProvider _auth= new AuthenticationProvider();
  late ChatsPageProvider _pageProvider;

  late double _deviceWidth;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth= MediaQuery.of(context).size.width;
    _deviceHeight= MediaQuery.of(context).size.height;

    return MultiProvider(
        providers: [ChangeNotifierProvider<ChatsPageProvider>(create: (_)=>ChatsPageProvider(_auth))],
        child: _buildUI());
  }
  Widget _buildUI(){
    return Builder(
      builder: (context) {
        _pageProvider = context.watch<ChatsPageProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text("Chats"),
            actions: [
              IconButton(onPressed: (){
                _auth.logout();
              }, icon: Icon(Icons.logout,color: Colors.white,))
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
      }
    );
  }
  Widget _chatsList(){
    return Expanded(child: _chatTile());
  }
  Widget _chatTile(){
    return CustomListViewTile(height: _deviceHeight*0.1, title: "Prashant Bista", subtitle: "Hello", imagePath: "https://i.pravatar.cc/150?img=3",
        onTap: (){}, isActive:false , isActivity: true);

  }
}
