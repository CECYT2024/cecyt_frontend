import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});
  static const String path = '/logout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
