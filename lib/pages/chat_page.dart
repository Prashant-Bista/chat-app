import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/widgets/topbar.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/widgets/custom_list_view_tiles.dart';
import 'package:chat_app/widgets/custom_form_field.dart';
import 'package:chat_app/Models/chat.dart';
import 'package:chat_app/Models/chat_message.dart';
import 'package:chat_app/providers/chats_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/providers/chat_page_provider.dart';

class ChatPage extends StatefulWidget {
  final chat;
  const ChatPage({super.key, this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late ChatPageProvider _pageProvider;
  late AuthenticationProvider _auth;
  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messageListViewController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageFormState=GlobalKey<FormState>();
    _messageListViewController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    _deviceWidth =MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(providers:[
      ChangeNotifierProvider<ChatPageProvider>(create: (_)=>ChatPageProvider(this.widget.chat.uid, _auth, _messageListViewController))
    ],
    child: _buildUI(),);
  }
  Widget _buildUI(
      ){
    return Builder(builder: (context){
      _pageProvider = context.watch<ChatPageProvider>();
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth*0.03,vertical: _deviceHeight*0.02),
            height: _deviceHeight,
            width: _deviceWidth *0.97,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(widget.chat.title(),
                  fontsize: 10,

                  primaryAction: IconButton(onPressed: (){

                  }, icon: Icon(Icons.delete,color: Colors.blue),),
                  secondaryAction: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.blue,)),),
              ],
            ),

          ),
        ),
      );
    });
  }
}
