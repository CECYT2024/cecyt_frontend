import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});
  static const String path = '/information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CardImage(
            title: "INFORMACION SOBRE EL INNOTEC",
            imageassetpath: 'assets/Innotec.png',
            onTap: () {},
            escala: 1,
            elevacion: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          CardImage(
            title: "ORGANIZADORES 2024",
            imageassetpath: 'assets/Organizadores.png',
            onTap: () {},
            escala: 1,
            elevacion: 1,
          )
        ],
      ),
    );
  }
}
