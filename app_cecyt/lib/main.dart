import 'package:app_cecyt/core/cubit/global_cubit.dart';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/presentation/pages/forgot_password_page.dart';

import 'package:app_cecyt/features/auth/presentation/pages/register_page.dart';
import 'package:app_cecyt/features/home/cards/account_card.dart';
import 'package:app_cecyt/features/home/cards/admin_card.dart';
import 'package:app_cecyt/features/home/cards/news_cards.dart';
import 'package:app_cecyt/features/home/ui/pages/activity_page.dart';
import 'package:app_cecyt/features/home/ui/pages/cecyt_page.dart';
import 'package:app_cecyt/features/home/ui/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'features/home/ui/pages/profiles_page.dart';
import 'features/home/ui/pages/logout_page.dart';
import 'features/home/ui/pages/qr_page.dart';
import 'features/home/ui/pages/credits_page.dart';
import 'features/home/ui/start/start_page.dart';
import 'features/home/cards/news_cards2.dart';
import 'features/home/cards/news_cards3.dart';
import 'features/home/cards/news_cards4.dart';
import 'utils/helpers/events_bloc.dart';
import 'utils/helpers/api_service.dart';
import 'utils/helpers/pref_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then((value) async {
    PrefManager(value);
    runApp(const MyApp());
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(); // Crea una instancia de ApiService

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalCubit()),
        BlocProvider(
          create: (context) =>
              SessionCubit(ApiRepository(apiProvider: AuthApiDataSource())),
        ),
        // BlocProvider(
        //   create: (context) => NavigationBloc(),
        // ),
        BlocProvider(
          create: (context) =>
              EventsBloc(apiService: apiService)..add(FetchEvents()),
        ),
      ],
      child: MaterialApp(
        title: 'CECYT App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1EABE2)),
          useMaterial3: true,
        ),
        initialRoute: StartPage.path,
        routes: {
          StartPage.path: (_) => const StartPage(),
          ProfilesPage.path: (_) => const ProfilesPage(nombre: 'Fernando Elizondo', carrera: 'Ingeniería Informática', cedula: '8.107.818', codigoEstudiante: 'CECYT202420128', departamento: 'DEI', fotoAsset: 'assets/Ejemplo_Foto_Perfil.jpg', matricula: 'Y31200'),
          LoginPage.path: (_) => const LoginPage(),
          LogoutPage.path: (_) => const LogoutPage(),
          QrPage.path: (_) => const QrPage(),
          CreditsPage.path: (_) => const CreditsPage(),
          AdminCard.path: (_) => const AdminCard(),
          NewsCardsOne.path: (_) => const NewsCardsOne(),
          NewsCardsTwo.path: (_) => const NewsCardsTwo(),
          NewsCardsThree.path: (_) => const NewsCardsThree(),
          NewsCardsFour.path: (_) => const NewsCardsFour(),
          RegisterPage.path: (_) => const RegisterPage(),
          ActivitiesPage.path: (_) => const ActivitiesPage(),
          CecytPage.path: (_) => const CecytPage(),
          NewsPage.path: (_) => const NewsPage(),
          ForgotPasswordPage.path: (_) => const ForgotPasswordPage(),
          AccountCard.path: (_) => const AccountCard(),
        },
      ),
    );
  }
}
