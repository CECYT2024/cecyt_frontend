import 'package:flutter/material.dart';

class NewsCardsOne extends StatelessWidget {
  const NewsCardsOne({super.key});
  static const String path = '/news1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 75),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Noticias 1'),
        ),
      ),
    );
  }
}
