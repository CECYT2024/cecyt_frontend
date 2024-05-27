import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/ui/pages/pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginPage.path,
      routes: {
        LoginPage.path: (_) => const LoginPage(),
        HomePage.path: (_) => const HomePage(),
      },
    );
  }
}
