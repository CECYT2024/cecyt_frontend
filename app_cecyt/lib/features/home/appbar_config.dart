import 'package:flutter/material.dart';

import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';

class AppbarConfig extends AppBar {
  AppbarConfig({super.key});

  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CECYTLogo(imagePath: 'assets/cecytlogo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
