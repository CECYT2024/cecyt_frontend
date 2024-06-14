import 'package:flutter/material.dart';
import 'package:app_cecyt/features/home/ui/pages/calendario_page.dart';  // Asegúrate de que la ruta sea correcta
import 'package:app_cecyt/features/home/ui/pages/informacion_page.dart';  
import 'package:app_cecyt/features/home/ui/pages/usuario_page.dart';

import 'package:app_cecyt/features/home/ui/start/start_page.dart';

class NavegatorBar extends StatefulWidget {
  const NavegatorBar({Key? key}) : super(key: key);

  @override
  State<NavegatorBar> createState() => _NavegatorBarState();
}

class _NavegatorBarState extends State<NavegatorBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          StartPage(),
          CalendarioPage(),
          InformacionPage(),
          UsuarioPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
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
            label: "Usuario",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
