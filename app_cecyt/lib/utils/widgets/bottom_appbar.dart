import 'package:flutter/material.dart';

class NavegatorBar extends StatefulWidget {
  const NavegatorBar({Key? key}) : super(key: key);

  @override
  State<NavegatorBar> createState() => _NavegatorBarState();
}

class _NavegatorBarState extends State<NavegatorBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Asegura que los labels siempre se muestren
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
      currentIndex: _selectedIndex,  // Indica el índice seleccionado
      selectedItemColor: Colors.blue,  // Color de los ítems seleccionados
      unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
      backgroundColor: Colors.white,  // Color de fondo del BottomNavigationBar
      onTap: _onItemTapped, // Maneja los taps en los ítems
    );
  }
}