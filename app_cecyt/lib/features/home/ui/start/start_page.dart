// start_page.dart
import 'package:app_cecyt/features/auth/presentation/bloc/bottom_nav_bloc.dart';
import 'package:app_cecyt/features/home/cards/news_cards.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:page_transition/page_transition.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              PrincipalButton(
                titulo:
                    'Iniciar Sesión', //TODO: Tiene que decir Cerrar Sesion si iniciada
                color: Colors.white,
                colortexto: Colors.black,
                elevacion: 5,
                callback: () {
                  Navigator.of(context).popAndPushNamed('/login');
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
              CardImage(
                  title: "QUESTIONARIO",
                  imageassetpath: 'assets/foto1.jpg',
                  onTap: () {
                    Navigator.of(context).pushNamed('/news1');
                  }),
              const SizedBox(
                width: 20,
              ),
              CardImage(
                  title: "INFORMACION",
                  imageassetpath: 'assets/innotec_logo.png',
                  escala: 13.5,
                  onTap: () {
                    Navigator.of(context).pushNamed('/news2');
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardImage(
                title: "ORGANIZADORES INNOTEC 2024",
                imageassetpath: 'assets/Organizadores.png',
                onTap: () {},
                escala: 10,
                elevacion: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
