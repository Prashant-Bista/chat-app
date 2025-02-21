import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/providers/users_page_provider.dart';

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
  late UsersPageProvider _pageProvider;

  late AuthenticationProvider _auth;
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider<UsersPageProvider>(
        create: (_) => UsersPageProvider(_auth),
      )
    ], child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext context) {
      _pageProvider = Provider.of<UsersPageProvider>(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("Users"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomTextField(
              onEditingComplete: (_value) {
                _pageProvider.getUsers(name: _value);
                FocusScope.of(context).unfocus();
              },
              hintText: "Search..",
              obscureText: false,
              controller: _searchFieldController,
              icon: Icons.search,
            ),
            _userList(),
            _createChatButton()
          ],
        ),
      );
    });
  }

  Widget _userList() {
    List<ChatUser>? _users = _pageProvider.users;
    return Expanded(child: () {
      if (_users != null) {
        if (_users.length == 0) {
          return Center(
            child: Text(
              "No users Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomListViewTileWithSelected(
                height: _deviceHeight * 0.10,
                title: _users[index].name,
                subtitle: "Last Active: ${_users[index].lastDayActive()}",
                imagePath: _users[index].imageURL,
                onTap: () {
                  _pageProvider.updateSelectedUsers(_users[index]);
                },
                isActive: _users[index].wasRecentlyActive(),
                isSelected: _pageProvider.selectedUsers.contains(_users[index]),
              );
            });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }());
  }

  Widget _createChatButton() {
    return Visibility(
      visible: _pageProvider.selectedUsers.isNotEmpty,
      child: RoundedButton(
          name: _pageProvider.selectedUsers.length == 1
              ? "Chat with ${_pageProvider.selectedUsers.first.name}"
              : "Create Group chat",
          height: _deviceHeight * 0.08,
          width: _deviceWidth * 0.80,
          onpressed: () {
            _pageProvider.createChat();
          }),
    );
  }
}
