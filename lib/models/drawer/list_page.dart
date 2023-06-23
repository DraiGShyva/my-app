import 'package:app/pages/calendar/table.dart';
import 'package:app/pages/chatbox.dart';
import 'package:flutter/material.dart';

import '../../pages/authentication/signin.dart';
import '../../pages/home.dart';

class ListPageDrawer extends StatefulWidget {
  const ListPageDrawer({super.key});

  @override
  State<ListPageDrawer> createState() => _ListPageDrawerState();
}

class _ListPageDrawerState extends State<ListPageDrawer> {
  List<String> pages = [
    'Home',
    'Chat Box',
    'Settings',
    'About',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pages[index]),
            onTap: () {
              Navigator.of(context).pop();
              switch (index) {
                case 0:
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatPage()));
                  break;
                case 2:
                  commingSoon(context);
                  break;
                case 3:
                  commingSoon(context);
                  break;
                case 4:
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()),
                      (route) => false);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
