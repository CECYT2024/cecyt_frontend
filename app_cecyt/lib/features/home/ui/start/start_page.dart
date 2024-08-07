// start_page.dart
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart'; // Importa ApiService
import 'package:app_cecyt/utils/constants.dart'; // Importa la constante
import 'package:shared_preferences/shared_preferences.dart'; // Para manejar el token

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenCambiable); // Obtén el token almacenado

    if (token != null) {
      final apiService = ApiService(baseUrl: baseUrl);
      try {
        final adminStatus = await apiService.isAdmin(token);
        setState(() {
          isAdmin = true;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // Maneja el error
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                      CardImage(
                          escala: 2,
                          elevacion: 10,
                          fontScale: 1,
                          title: "PREGUNTAS",
                          imageassetpath: 'assets/Preguntas.png',
                          onTap: () {
                            //Navigator.of(context).pushNamed('/news1');
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      CardImage(
                        elevacion: 10,
                        title: "INFORMACIÓN",
                        imageassetpath: 'assets/Informacion.png',
                        escala: 2,
                        onTap: () {
                          Navigator.of(context).pushNamed('/news2');
                        },
                      ),
                    ],
                  ),
                  if (true) //TODO Cambiar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrincipalButton(
                          titulo: 'Administrador',
                          color: Colors.black,
                          callback: () {
                            //Navigator.of(context).pushNamed('/admin');
                          }),
                    )
                ],
              ),
            ),
    );
  }
}
