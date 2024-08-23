// start_page.dart
import 'dart:convert';

import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/exceptions/exceptions.dart';

import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/cards/admin_card.dart';
import 'package:app_cecyt/features/home/ui/pages/logout_page.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart'; // Importa ApiService
import 'package:app_cecyt/utils/constants.dart'; // Importa la constante
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isLoading = false;
  // LoginTypes loginType = LoginTypes.notLogged;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    final apiService = ApiService();
    try {
      final token = PrefManager(null).token;
      if (token != null) {
        isLoading = true;
        tokenCambiable = token;

        try {
          final adminStatus = await apiService.isAdmin(tokenCambiable);
          final responseBody = jsonDecode(adminStatus.body);
          if (responseBody['isAdmin']) {
            context.read<SessionCubit>().setSession(token, true);
            setState(() {
              // isAdmin = true;
              // loginType = LoginTypes.admin;
              isLoading = false;
            });
          } else {
            context.read<SessionCubit>().setSession(token, false);
            setState(() {
              // isAdmin = false;
              isLoading = false;
            });
          }
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } on NotAuthException catch (e) {
      // PrefManager(null).logout();
      // loginType = LoginTypes.notLogged;
      // tokenCambiable = '';
      context.read<SessionCubit>().logout();
    } catch (e) {}
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
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardImage(
                          alto: 135,
                          ancho: 340,
                          title: "¿QUÉ ES EL INNOTEC?",
                          imageassetpath: 'assets/Innotec.png',
                          onTap: () {
                            Navigator.of(context).pushNamed('/news4');
                          },
                          escala: 1,
                        )
                            .animate(delay: Duration(milliseconds: 420))
                            .slideY(curve: Curves.easeIn),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CardImage(
                      alto: 135,
                      ancho: 340,
                      title: "ORGANIZADORES INNOTEC 2024",
                      imageassetpath: 'assets/Organizadores.png',
                      onTap: () {
                        Navigator.of(context).pushNamed('/news3');
                      },
                      escala: 1,
                      elevacion: 10,
                    )
                        .animate(delay: Duration(milliseconds: 320))
                        .slideY(curve: Curves.easeIn),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardImage(
                                escala: 2,
                                elevacion: 10,
                                fontScale: 1,
                                title: "PREGUNTAS",
                                imageassetpath: 'assets/Preguntas.png',
                                onTap: () {
                                  Navigator.of(context).pushNamed('/news1');
                                })
                            .animate(delay: Duration(milliseconds: 100))
                            .slideY(curve: Curves.easeIn),
                        const SizedBox(
                          width: 20,
                        ),
                        CardImage(
                          elevacion: 10,
                          title: "INFORMACIÓN",
                          imageassetpath: 'assets/Informacion.png',
                          escala: 2,
                          onTap: () {
                            Navigator.of(context).pushNamed('/news2');
                          },
                        )
                            .animate(delay: Duration(milliseconds: 220))
                            .slideY(curve: Curves.easeIn),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        // PrincipalButton(
                        //   titulo: loginType.title,
                        //   color: Colors.white,
                        //   colortexto: const Color.fromARGB(255, 21, 98, 160),
                        //   elevacion: 5,
                        //   callback: () {
                        //     // Navigator.of(context).popAndPushNamed('/login');
                        //     if (loginType != LoginTypes.notLogged) {
                        //       PrefManager(null).logout();
                        //       loginType = LoginTypes.notLogged;
                        //       tokenCambiable = '';
                        //       context.read<SessionCubit>().logout();
                        //     } else {
                        //       Navigator.of(context)
                        //           .popAndPushNamed(loginType.pathRedirect);
                        //     }
                        //     setState(() {});
                        //   },
                        // )
                        //     .animate()
                        //     .slideX(duration: Duration(milliseconds: 250)),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    // if (loginType.isAdmin)
                    //   Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: PrincipalButton(
                    //         titulo: 'Administrador',
                    //         color: Colors.black,
                    //         callback: () {
                    //           Navigator.of(context).pushNamed('/admin');
                    //         }),
                    //   )
                  ],
                ),
              ),
            ),
    );
  }
}
