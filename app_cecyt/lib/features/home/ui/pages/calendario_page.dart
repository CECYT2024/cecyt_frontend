import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class CalendarioPage extends StatelessWidget {
  const CalendarioPage({super.key});
  static const String path = '/calendario';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarCentro(),
      body:Text('holaa'),
    );
  }
}