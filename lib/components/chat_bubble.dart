import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isCurrentUser
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 25,
      ),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
