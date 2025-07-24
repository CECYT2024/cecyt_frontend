// navigation_event.dart

import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/utils/login_types.dart';
import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/cards/account_card.dart';
import 'package:app_cecyt/features/home/cards/admin_card.dart';
import 'package:app_cecyt/features/home/ui/pages/qr_page.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/features/home/ui/pages/credits_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/home/ui/pages/profiles_page.dart';

//Animaciones para el buttom nav bar
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

void _navigateToPage(BuildContext context, String route) {
  Widget page;

  switch (route) {
    case ProfilesPage.path:
      page = ProfilesPage(nombre: 'Fernando Elizondo', carrera: 'Ingeniería Informática', cedula: '8.107.818', codigoEstudiante: 'CECYT202420128', departamento: 'DEI', fotoAsset: 'assets/Ejemplo_Foto_Perfil.jpg', matricula: 'Y31200');
      break;
    case CreditsPage.path:  // Agrega este caso
      page = const CreditsPage();
      break;
    case LoginPage.path:
      page = const LoginPage();
      break;
    case StartPage.path:
    default:
      page = const StartPage();
  }

  if (route == StartPage.path) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  } else {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.fade, child: page),
    );
  }
}

String pageActual(int num) {
  const paths = [
    StartPage.path,
    ProfilesPage.path,
    CreditsPage.path,
    LoginPage.path,
    AccountCard.path,
  ];
  return paths[num];
}

enum TabsEnum { home, profiles, credits, session }

// Asegúrate de importar tus rutas y estados correctamente
// import 'your_routes.dart';
// import 'your_session_cubit.dart';

class BottomNavCentro extends StatelessWidget {
  const BottomNavCentro({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40), // Borde muy redondeado
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Más contraste
                    blurRadius: 20,
                    offset: const Offset(0, 8), // Más profundidad
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color(0xFF1EABE2),
                  unselectedItemColor: Colors.grey.shade400,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  currentIndex: index,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: '',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: '',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.access_time),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.settings),
                      label: '',
                    ),
                  ],
                  onTap: (newIndex) {
                    if (index != newIndex) {
                      if (newIndex == 3 && state is SessionLoaded) {
                        final loginType = BlocProvider.of<SessionCubit>(
                          context,
                        ).state.loginType;
                        if (loginType == LoginTypes.admin) {
                          Navigator.pushNamed(context, AdminCard.path);
                          return;
                        } else if (loginType == LoginTypes.logged) {
                          Navigator.pushNamed(context, AccountCard.path);
                          return;
                        } else if (loginType == LoginTypes.notLogged) {
                          Navigator.pushNamed(context, LoginPage.path);
                          return;
                        }
                      }

                      if (newIndex == 0) {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      } else {
                        _navigateToPage(context, pageActual(newIndex));
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void _navigateToPage1(BuildContext context, String route) {
  // Widget page;

  // switch (route) {
  //     break;
  //   case '/QRpage':
  //     page = const QrPage();
  //     break;
  //   case LoginPage.path:
  //     page = const LoginPage();
  //     break;
  //   case '/start':
  //   default:
  //     page = const StartPage();
  // }
  if (route == StartPage.path) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  } else {
    // Navigator.pushReplacement(
    //   context,
    //   PageTransition(
    //     alignment: Alignment.center,
    //     type: PageTransitionType.fade,
    //     child: page,
    //   ),
    // );
    Navigator.pushNamed(context, route);
  }
}
  //Animaciones para el buttom nav bar

