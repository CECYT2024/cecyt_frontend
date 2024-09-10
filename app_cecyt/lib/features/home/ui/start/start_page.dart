// start_page.dart
import 'dart:convert';
import 'dart:io';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/features/auth/presentation/bloc/login_bloc.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart'; // Importa ApiService
import 'package:app_cecyt/utils/constants.dart'; // Importa la constante
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:no_screenshot/no_screenshot.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isLoading = false;
  final _noScreenshot = NoScreenshot.instance;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _unsecureScreen();
    } else {
      _noScreenshot.screenshotOn();
    }
    _checkAdminStatus();
  }

  Future<void> _secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> _checkAdminStatus() async {
    final apiService = ApiService();
    try {
      final token = PrefManager(null).token;
      if (token != null) {
        setState(() {
          isLoading = true;
        });

        final adminStatus = await apiService.isAdmin(token);
        final responseBody = jsonDecode(adminStatus.body);
        if (responseBody['isAdmin']) {
          context.read<SessionCubit>().setSession(token, true);
        } else {
          context.read<SessionCubit>().setSession(token, false);
        }
      }
    } on NotAuthException catch (e) {
      context.read<LoginBloc>().refreshToken();
    } catch (e) {
      context.read<SessionCubit>().logout();
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(
        isHome: true,
      ),
      bottomNavigationBar: const BottomNavCentro(
        index: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 21, 98, 160),
                          backgroundColor: Colors.white,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/news4');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/Innotec.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 1),
                            const Text(
                              "¿QUÉ ES EL INNOTEC?",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().slideY(
                      delay: Duration(milliseconds: 50),
                      duration: Duration(
                          milliseconds:
                              300)), //CardImage(title: 'ORGANIZADORES INNOTEC 2024', imageassetpath:'assets/Organizadores.png' , onTap: '/news3'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 21, 98, 160),
                          backgroundColor: Colors.white,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/news3');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/Organizadores.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 1),
                            const Text(
                              textAlign: TextAlign.center,
                              "ORGANIZADORES INNOTEC 2024",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().slideY(
                      delay: Duration(milliseconds: 50),
                      duration: Duration(milliseconds: 300)),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          CardImage(
                            title: 'PREGUNTAS',
                            imageassetpath: 'assets/Preguntas.png',
                            onTap: '/news1',
                          ),
                          SizedBox(width: 10),
                          CardImage(
                            title: 'INFORMACIÓN',
                            imageassetpath: 'assets/Informacion.png',
                            onTap: '/news2',
                          ),
                        ],
                      ),
                    ),
                  ).animate().slideY(
                      delay: Duration(milliseconds: 1),
                      duration: Duration(milliseconds: 300)),
                ],
              ),
            ),
    );
  }
}
