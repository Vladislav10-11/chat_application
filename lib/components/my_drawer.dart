import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/screens/setting_screen.dart';
import 'package:chat_application/themes/constants.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo

                // list tile Home
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 45.0),
                  child: ListTile(
                    title: Text(
                      "Home".toUpperCase(),
                      style: AppFonts.textInterface,
                    ),
                    leading: Icon(
                      Icons.cottage_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // list tile Settings
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text(
                      "SETTINGS",
                      style: AppFonts.textInterface,
                    ),
                    leading: Icon(
                      Icons.settings_applications_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                  ),
                ),
              ],
            ),
            // list tile Logout
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                title: Text(
                  "LOGOUT",
                  style: AppFonts.textInterface,
                ),
                leading: Icon(Icons.power_settings_new),
                onTap: () {
                  logout();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
