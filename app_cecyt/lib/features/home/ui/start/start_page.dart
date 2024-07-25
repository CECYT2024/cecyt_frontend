// start_page.dart
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                PrincipalButton(
                  titulo: 'Iniciar Sesión', //TODO: Tiene que decir Cerrar Sesion si iniciada
                  color: Colors.white,
                  colortexto: const Color.fromARGB(255, 21, 98, 160),
                  elevacion: 5,
                  callback: () {
                    Navigator.of(context).popAndPushNamed('/login');
                  },
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardImage(
                  alto: 135,
                  ancho: 340,
                  title: "¿QUÉ ES EL INNOTEC?",
                  imageassetpath: 'assets/Innotec.png',
                  onTap: () {
                    Navigator.of(context).pushNamed('/news4');
                  },
                  escala: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CardImage(
              alto: 135,
              ancho: 340,
              title: "ORGANIZADORES INNOTEC 2024",
              imageassetpath: 'assets/Organizadores.png',
              onTap: () {
                Navigator.of(context).pushNamed('/news3');
              },
              escala: 1,
              elevacion: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(
                //  width: 15,
                //),
                CardImage(
                    elevacion: 10,
                    fontScale: 1,
                    title: "PREGUNTAS",
                    imageassetpath: 'assets/foto1.jpg',
                    onTap: () {
                      Navigator.of(context).pushNamed('/news1');
                    }),
                const SizedBox(
                  width: 20,
                ),
                CardImage(
                  elevacion: 10,
                  title: "INFORMACIÓN",
                  imageassetpath: 'assets/innotec_logo.png',
                  escala: 10,
                  onTap: () {
                    Navigator.of(context).pushNamed('/news2');
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrincipalButton(
                  titulo: 'Administrador',
                  color: Colors.black,
                  callback: () {
                    Navigator.of(context).pushNamed('/admin');
                  }),
            )
          ],
        ),
      ),
    );
  }
}
