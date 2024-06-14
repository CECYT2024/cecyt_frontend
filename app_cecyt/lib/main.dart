import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/ui/pages/logout_page.dart';
import 'package:app_cecyt/features/home/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/utils/widgets/bottom_appbar.dart';
import 'package:app_cecyt/features/home/ui/pages/calendario_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CECYT App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavegatorBar(),
      routes: {
        LoginPage.path: (_) => const LoginPage(),
        LogoutPage.path: (_) => const LogoutPage(),
      },
    );
  }
}