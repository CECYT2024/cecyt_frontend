// start_page.dart
import 'package:app_cecyt/features/auth/presentation/bloc/bottom_nav_bloc.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                titulo: 'Iniciar Sesión',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //const SizedBox(
              //  width: 15,
              //),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/news1');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/foto1.jpg',
                      scale: 5,
                    ),
                    const Text(
                      textScaler: TextScaler.linear(1),
                      'Questionario',
                      style: TextStyle(color: Color.fromARGB(255, 21, 98, 160)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/news2');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/foto1.jpg',
                      scale: 5,
                    ),
                    const Text(
                      'Registro al Innotec',
                      style: TextStyle(color: Color.fromARGB(255, 21, 98, 160)),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
