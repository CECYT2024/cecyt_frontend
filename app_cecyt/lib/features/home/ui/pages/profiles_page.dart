//import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/exceptions/exceptions.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesPage extends StatefulWidget {
  final String nombre;
  final String carrera;
  final String cedula;
  final String codigoEstudiante;
  final String departamento;
  final String fotoAsset;
  final String matricula;

  const ProfilesPage({
    super.key,
    required this.nombre,
    required this.carrera,
    required this.cedula,
    required this.codigoEstudiante,
    required this.departamento,
    required this.fotoAsset,
    required this.matricula,
  });

  static const String path = '/profiles';

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionCubit>().state;
    final bool isLoggedIn = sessionState is SessionLoaded;

    return Stack(
      children: [
        // Imagen de fondo
        Positioned.fill(
          child: Image.asset('assets/CECYT_Fondo_Claro.jpg', fit: BoxFit.cover),
        ),
        // Gradiente blanco
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),

        // Si no inició sesión, mostrar un botón para loguearse
        if (!isLoggedIn)
          Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: const BottomNavCentro(index: 1),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Iniciar sesión'),
              ),
            ),
          )
        else Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: const BottomNavCentro(index: 1),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    widget.nombre,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.carrera,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(131, 131, 131, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Editar foto de perfil",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(131, 131, 131, 1),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/LogoCyT.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "CYT-ID",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(12, 81, 131, 1),
                                          height: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 82,
                                                height: 82,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(237, 237, 237, 1),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                width: 74,
                                                height: 74,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(widget.fotoAsset),
                                                    fit: BoxFit.cover,
                                                    alignment: Alignment.topCenter,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 13),
                                          Text(
                                            widget.matricula,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(131, 131, 131, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      // Columna flexible para prevenir overflow
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _infoItem("NOMBRE Y APELLIDO", widget.nombre.toUpperCase()),
                                            _infoItem("NÚMERO DE CÉDULA", widget.cedula),
                                            _infoItem("CÓDIGO DE ESTUDIANTE CYT", widget.codigoEstudiante),
                                            _infoItem("DEPARTAMENTO", widget.departamento.toUpperCase()),
                                            _infoItem("CARRERA", widget.carrera.toUpperCase()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                          ],
                        ),
                      ),
                      // Foto de perfil grande
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 123,
                          height: 123,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(widget.fotoAsset),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(0, 0, 0, 0.75),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(131, 131, 131, 1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
