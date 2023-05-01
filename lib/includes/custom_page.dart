import 'package:flutter/material.dart';

class CustomPage extends StatefulWidget {
  final List<StatefulWidget> widgets;

  const CustomPage({super.key, required this.widgets});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover)),
          child: Material(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const FlutterLogo(size: 100),
                      const SizedBox(height: 100),
                      Column(
                        children: widget.widgets,
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
