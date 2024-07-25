import 'package:flutter/material.dart';

class NewsCardsTwo extends StatelessWidget {
  const NewsCardsTwo({super.key});
  static const String path = '/news2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 75),
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Donde sera y que fecha sera el intec"),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
