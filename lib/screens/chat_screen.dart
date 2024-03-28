import 'package:chat_application/components/chat_bubble.dart';
import 'package:chat_application/components/my_textfiled.dart';
import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatScreen({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

// text controller

  final TextEditingController _messageController = TextEditingController();

  // chat & auth servises
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

// send Message
  void sendMessage() async {
    // if there is somesthing inside the textField
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      // clear textcontroller
      _messageController.clear();
    }
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return const Text('Error');
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          // return listview
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

// is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

// align message to the right if sender is the current user, otherwise left

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data["message"])
          ],
        ));
  }

  // build message input

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
                controller: _messageController,
                obscureText: false,
                hintText: "Type a Message"),
          ),
          // Send message button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          receiverEmail,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Column(
        children: [
          // dsiplay all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildUserInput(context),
        ],
      ),
    );
  }
}
