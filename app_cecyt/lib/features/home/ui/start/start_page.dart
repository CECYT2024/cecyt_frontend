import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:flutter/material.dart';

import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  static const path = '/start';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                titulo:
                    'Iniciar Sesión', //TODO:deberia ser una variable donde cambie si es que se inicio sesion
                color: Colors.white,
                colortexto: Colors.black,
                elevacion: 5,
                callback: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                    backgroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {},
                child: Column(
                  children: [
                    Image.asset(
                      'assets/foto1.jpg',
                      scale: 10,
                    ),
                    const Text('Cyt League')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
