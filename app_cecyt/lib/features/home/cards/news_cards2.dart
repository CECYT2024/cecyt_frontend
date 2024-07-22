import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

import '../../../utils/widgets/card_image.dart';

class NewsCardsTwo extends StatelessWidget {
  const NewsCardsTwo({super.key});
  static const String path = '/news2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 75),
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
        ],
      ),
    );
  }
}
