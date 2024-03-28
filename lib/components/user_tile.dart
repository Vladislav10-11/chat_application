import 'package:chat_application/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // icon
            const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            SizedBox(
              width: 15,
            ),
            // user name
            Text(
              text,
              style: AppFonts.textInterface,
            )
          ],
        ),
      ),
    );
  }
}
