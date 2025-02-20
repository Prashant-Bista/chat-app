import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/providers/authentication_provider.dart';

import 'package:chat_app/widgets/topbar.dart';
import 'package:chat_app/widgets/custom_form_field.dart';
import 'package:chat_app/widgets/custom_list_view_tiles.dart';
import 'package:chat_app/widgets/rounded_button.dart';

import 'package:chat_app/Models/chat_user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.95),
      height: _deviceHeight * 0.95,
      width: _deviceWidth * 0.97,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TopBar(
            "Users",
            primaryAction: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(0, 80, 280, 1.0),
                )),
          ),
          CustomTextField(
            onEditingComplete: (_value) {},
            hintText: "Search..",
            obscureText: false,
            controller: _searchFieldController,
            icon: Icons.search,
          ),

        ],
      ),
    );
  }
}
