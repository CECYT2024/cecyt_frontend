import 'package:app_cecyt/features/home/cards/admin_card.dart';
import 'package:app_cecyt/features/home/cards/news_cards.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/bloc/bottom_nav_bloc.dart';
import 'features/home/ui/pages/calendar_page.dart';
import 'features/home/ui/pages/logout_page.dart';
import 'features/home/ui/pages/qr_page.dart';
import 'features/home/ui/start/start_page.dart';
import 'features/home/cards/news_cards2.dart';
import 'features/home/cards/news_cards3.dart';
import 'features/home/cards/news_cards4.dart';
import 'utils/helpers/events_bloc.dart';
import 'utils/helpers/api_service.dart'; // Importa ApiService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: baseUrl); // Crea una instancia de ApiService

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => EventsBloc(apiService: apiService)..add(FetchEvents()),
        ),
      ],
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
          LoginPage.path: (_) => const LoginPage(),
          LogoutPage.path: (_) => const LogoutPage(),
          QrPage.path: (_) => const QrPage(),
          AdminCard.path: (_) => const AdminCard(),
          NewsCardsOne.path: (_) => const NewsCardsOne(),
          NewsCardsTwo.path: (_) => const NewsCardsTwo(),
          NewsCardsThree.path: (_) => const NewsCardsThree(),
          NewsCardsFour.path: (_) => const NewsCardsFour()
        },
      ),
    );
  }
}
