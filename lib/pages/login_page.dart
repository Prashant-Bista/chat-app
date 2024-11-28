import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';
import '../widgets/rounded_button.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double deviceWidth;
  late double deviceHeight;
  late AuthenticationProvider _auth;
  late NavigationService _navigation;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/chatapplogo2.png",
              height: 200, width: 200),
          Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.25),
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.5,
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  CustomFormField(
                    onSaved: (_value) {
                      _email = _value;
                    },
                    regEx: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                    onSaved: (_value) {
                      _password = _value;
                    },
                    regEx: r'.{8,}',
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  _loginButton(),
                  _registerLink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Login",
      height: deviceHeight * 0.065,
      width: deviceWidth * 0.25,
      onpressed: () {
        if (loginFormKey.currentState!.validate()) {
          loginFormKey.currentState!.save();
          _auth.loginUsingEmailAndPassword(
              _email.toString(), _password.toString());
        }
      },
    );
  }

  Widget _registerLink() {
    return InkWell(
      child: Text(
        "Don't have an account",
        style: TextStyle(color: Colors.blueAccent),
      ),
      onTap: () {},
    );
  }
}
