import 'package:flutter/material.dart';

class AppbarCentro extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCentro({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 75,
      title: Center(
        child: Image.asset(
          'assets/cecytlogo.png',
          height: 75,
          width: 75,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
