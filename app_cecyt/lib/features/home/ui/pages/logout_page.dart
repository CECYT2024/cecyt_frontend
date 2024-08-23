import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});
  static const String path = '/logout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      // bottomNavigationBar: const BottomNavCentro(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
