import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});
  static const String path = '/information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/start');
          },
          child: const Text('informacion'),
        ),
      ),
    );
  }
}
