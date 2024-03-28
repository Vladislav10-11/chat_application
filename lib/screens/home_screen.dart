import 'package:chat_application/components/my_drawer.dart';
import 'package:chat_application/components/user_tile.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/service/chat/chat_service.dart';
import 'package:chat_application/themes/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

// Build of listUser of users exept for the current logged in user

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        //return listview
        return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList());
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on user -> go to chat
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Home".toUpperCase(), style: AppFonts.textInterface),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
}
