import 'package:flutter/material.dart';
import 'package:chat_app/widgets/custom_form_field.dart';

import '../widgets/rounded_button.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceWidth=0;
  late double deviceHeight=0;
  @override
  Widget build(BuildContext context) {
    deviceWidth= MediaQuery.of(context).size.width;
    deviceHeight= MediaQuery.of(context).size.width;
    return _buildUI();
  }
  Widget _buildUI(){
    return Scaffold(
      body: Column(
        children: [
Image.asset("assets/images/chatapplogo2.png",height: 200,width: 200),
          Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth*0.25),
            width: deviceWidth*0.8,
            height: deviceHeight*0.5,

            child: Form(child: Column(

              children: [CustomFormField(onSaved: (_value){}, regEx: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', hintText: "Email", obscureText: false),
                SizedBox(height: 20,),
                CustomFormField(onSaved: (_value){}, regEx: r'.{8,}', hintText: "Password", obscureText: true),
                SizedBox(height: 20,),
                _loginButton(),
                _registerLink()
            ],
            )),
          )
        ],
      ),
    );
  }
  Widget _loginButton(){
    return RoundedButton(name: "Login", height: deviceHeight*0.065, width: deviceWidth*0.25, onpressed: (){});
  }
  Widget _registerLink(){
    return InkWell(child: Text("Don't have and account",style: TextStyle(color: Colors.blueAccent),),onTap: (){});
  }
}
