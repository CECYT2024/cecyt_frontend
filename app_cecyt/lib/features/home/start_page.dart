import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';

import 'appbar_config.dart';
import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Center(
          child: Image.asset(
            'assets/cecytlogo.png',
            height: 75,
            width: 75,
          ),
        ),
      ),
      body: const Column(
        children: [
          Card(
            elevation: 10,
            borderOnForeground: false,
            color: Colors.white,
            child: Column(
              children: [
                Text('Texto'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
