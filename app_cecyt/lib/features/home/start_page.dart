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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                //Agregado porque da errores
                height: 50,
                width: 300,
                child: PrincipalButton(
                  titulo: 'Iniciar Sesion', //TODO:deberia ser una variable donde cambie si es que se inicio sesion
                  color: Colors.white,
                  colortexto: Colors.black,
                  elevacion: 10,
                  callback: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
              ),
              const SizedBox(
                width: 50,
              )
            ],
          )
        ],
      ),
    );
  }
}
