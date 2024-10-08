// navigation_event.dart

import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/utils/login_types.dart';

import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/home/cards/account_card.dart';
import 'package:app_cecyt/features/home/cards/admin_card.dart';
import 'package:app_cecyt/features/home/ui/pages/qr_page.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/home/ui/pages/calendar_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

//Animaciones para el buttom nav bar
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

void _navigateToPage(BuildContext context, String route) {
  Widget page;

  switch (route) {
    case CalendarPage.path:
      page = const CalendarPage();
      break;
    case QrPage.path:
      page = const QrPage();
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
      PageTransition(
        type: PageTransitionType.fade,
        child: page,
      ),
    );
  }
}

String pageActual(int num) {
  const paths = [
    StartPage.path,
    CalendarPage.path,
    QrPage.path,
    LoginPage.path,
    AccountCard.path,
  ];
  return paths[num];
}

enum TabsEnum {
  home,
  calendar,
  qr,
  session,
}

class BottomNavCentro extends StatelessWidget {
  const BottomNavCentro({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendario",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: "Mi QR",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: state.loginType.title,
            ),
          ],
          currentIndex: index,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: (newIndex) {
            if (index != newIndex) {
              if (newIndex == 3 && state is SessionLoaded) {
                if (BlocProvider.of<SessionCubit>(context).state.loginType ==
                    LoginTypes.admin) {
                  Navigator.pushNamed(context, AdminCard.path);
                  return;
                } else if (BlocProvider.of<SessionCubit>(context)
                        .state
                        .loginType ==
                    LoginTypes.logged) {
                  Navigator.pushNamed(context, AccountCard.path);
                  return;
                } else if (BlocProvider.of<SessionCubit>(context)
                        .state
                        .loginType ==
                    LoginTypes.notLogged) {
                  Navigator.pushNamed(context, LoginPage.path);
                  return;
                }
                // BlocProvider.of<SessionCubit>(context).logout();

                // return;
              }
              if (newIndex == 0) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              } else {
                _navigateToPage(context, pageActual(newIndex));
              }
            }
          },
        );
      },
    );
  }
}

void _navigateToPage1(BuildContext context, String route) {
  // Widget page;

  // switch (route) {
  //   case '/calendar':
  //     page = const CalendarPage();
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

