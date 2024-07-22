import 'package:flutter/material.dart';

class NewsCardsThree extends StatelessWidget {
  const NewsCardsThree({super.key});
  static const String path = '/news3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 75),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Noticias 3'),
        ),
      ),
    );
  }
}
