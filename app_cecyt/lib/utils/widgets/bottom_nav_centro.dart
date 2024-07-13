// navigation_event.dart

import 'package:app_cecyt/features/auth/presentation/bloc/bottom_nav_bloc.dart';
import 'package:app_cecyt/features/home/ui/pages/qr_page.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/ui/pages/calendar_page.dart';
import '../../features/home/ui/pages/information_page.dart';

//Animaciones para el buttom nav bar
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class PageTapped extends NavigationEvent {
  final int index;

  const PageTapped(this.index);

  @override
  List<Object> get props => [
        index
      ];
}
// navigation_state.dart

class NavigationState extends Equatable {
  final int selectedIndex;

  const NavigationState(this.selectedIndex);

  @override
  List<Object> get props => [
        selectedIndex
      ];
}
// custom_bottom_nav_bar.dart

String pageActual(int num) {
  const paths = [
    "/start",
    "/calendar",
    "/information",
    "/QRpage"
  ];
  return paths[num];
}

class BottomNavCentro extends StatelessWidget {
  const BottomNavCentro({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendario",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart_sharp),
              label: "Información",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Mi QR",
            ),
          ],
          currentIndex: state.selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index != state.selectedIndex) {
              BlocProvider.of<NavigationBloc>(context).add(PageTapped(index));
              _navigateToPage(context, pageActual(index));
            }
          },
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, String route) {
    Widget page;

    switch (route) {
      case '/calendar':
        page = const CalendarPage();
        break;
      case '/information':
        page = const InformationPage();
        break;
      case '/QRpage':
        page = const QrPage();
        break;
      case '/start':
      default:
        page = const StartPage();
    }

    Navigator.pushReplacement(
      context,
      PageTransition(
        alignment: Alignment.center,
        type: PageTransitionType.fade,
        child: page,
      ),
    );
  }
  //Animaciones para el buttom nav bar
}
