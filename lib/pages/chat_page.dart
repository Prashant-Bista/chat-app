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
        resizeToAvoidBottomInset: true,
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

                  primaryAction: IconButton(onPressed: (){_pageProvider.deleteChat();
                  }, icon: Icon(Icons.delete,color: Colors.blue),),
                  secondaryAction: IconButton(onPressed: (){
                    _pageProvider.goBack();
                  }, icon: Icon(Icons.arrow_back,color: Colors.blue,)),),
                _messagesListView(),
                _sendMessageForm()
              ],
            ),
          ),
        ),
      );
    });
  }
  Widget _messagesListView(){
  if(_pageProvider.messages!=null){
    print(_pageProvider.messages!.length);
    if(_pageProvider.messages!.length!=0){
      return Container(
        height: _deviceHeight*0.70,child: ListView.builder(itemCount:_pageProvider.messages!.length,itemBuilder: (BuildContext context,int _index){
          ChatMessage _message= _pageProvider.messages![_index];
          bool _isOwnMessage = _message.senderId == _auth.user.uid;
          return Container(
            child: CustomChatListViewTile(width: _deviceWidth, deviceWidth: _deviceHeight, isOwnMessage: _isOwnMessage, message: _message, sender: this.widget.chat.members.where((_m)=>_m.uid==_message.senderId).first),
          );
      },),
      );
    }
    else{
      return Align(alignment: Alignment.center,child: Text("Be the first one to say Hi!.",style: TextStyle(color: Colors.white),),);

    }
  }
  else
    {
      return Center(child: CircularProgressIndicator(color: Colors.white,));
    }

}
Widget _sendMessageForm(){
  return Container(
    height: _deviceHeight*0.06,
    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(10)
    ),
    margin: EdgeInsets.symmetric(horizontal: _deviceWidth*0.04,vertical: _deviceHeight*0.03),
    child: Form(
      key: _messageFormState,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _messageTextField(),
          _sendMessageButton(),
          _imageMessageButton()
        ],
      ),
    ),

  );

}
Widget _messageTextField(){
  return   SizedBox(
    width: _deviceWidth*0.60,
    child: CustomFormField(onSaved: (_value){
      _pageProvider.message=_value;
    }, regEx:r"^(?!\s*$).+", hintText: "Type a message", obscureText: false)
  );

}
Widget _sendMessageButton(){
  double _size = _deviceHeight *0.04;
  return Container(
    height: _size,
    width: _size,
    child: IconButton(onPressed: (){
      if(_messageFormState.currentState!.validate()){
        _messageFormState.currentState!.save();
        _pageProvider.sendTextMessage();
        _messageFormState.currentState!.reset();

      }
    }, icon:Icon(Icons.send) ,color: Colors.white,),
  );
}
  Widget _imageMessageButton(){
    double _size = _deviceHeight *0.05;
    return Container(
      height: _size,
      width: _size,
      child: FloatingActionButton(onPressed: (){
        _pageProvider.sendImageMessage();
      }, backgroundColor:Color.fromRGBO(0, 80, 220, 1.0),child: Icon(Icons.camera_enhance,color: Colors.black,), ),
    );
  }


}
