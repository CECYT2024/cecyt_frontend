import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:flutter/material.dart';

import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  static const path = '/start';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      body: Column(
        children: [
          Image.asset(
            'assets/ejemplo.png',
            scale: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              PrincipalButton(
                titulo: 'Iniciar Sesión', //TODO:deberia ser una variable donde cambie si es que se inicio sesion
                color: Colors.white,
                colortexto: Colors.black,
                elevacion: 10,
                callback: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
