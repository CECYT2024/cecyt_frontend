import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class NewsCardsTwo extends StatelessWidget {
  const NewsCardsTwo({super.key});
  static const String path = '/news2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/start');
          },
          child: const Text('Noticias 2'),
        ),
      ),
    );
  }
}
