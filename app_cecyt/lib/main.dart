import 'package:app_cecyt/features/auth/presentation/bloc/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/ui/pages/calendar_page.dart';
import 'package:app_cecyt/features/home/ui/pages/information_page.dart';
import 'package:app_cecyt/features/home/ui/pages/logout_page.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: MaterialApp(
        title: 'CECYT App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: StartPage.path,
        routes: {
          StartPage.path: (_) => const StartPage(),
          CalendarPage.path: (_) => const CalendarPage(),
          InformationPage.path: (_) => const InformationPage(),
          LoginPage.path: (_) => const LoginPage(),
          LogoutPage.path: (_) => const LogoutPage(),
        },
      ),
    );
  }
}
