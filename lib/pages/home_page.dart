import 'package:app/includes/custom_button.dart';
import 'package:flutter/material.dart';

import 'signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          CustomButton(
            onPressed: () {},
            icon: Icons.video_call,
            radius: 50.0,
            size: 20,
          ),
          CustomButton(
            onPressed: () {},
            icon: Icons.call,
            radius: 50.0,
          ),
          const SizedBox(width: 5.0)
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            CustomButton(
                name: 'Logout',
                center: true,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()),
                      (route) => false);
                }),
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [],
              ),
            ),
          )),
    );
  }
}
