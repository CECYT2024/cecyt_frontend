import 'package:flutter/material.dart';

class NewsCardsFour extends StatelessWidget {
  const NewsCardsFour({super.key});
  static const String path = '/news4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 75),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Noticias 4'),
        ),
      ),
    );
  }
}
