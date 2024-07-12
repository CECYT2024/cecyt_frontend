import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  static const String path = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Calendar'),
        ),
      ),
    );
  }
}
