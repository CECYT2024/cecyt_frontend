// start_page.dart
//import 'dart:convert';
//import 'dart:io';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/exceptions/exceptions.dart';
//import 'package:app_cecyt/features/auth/presentation/bloc/login_bloc.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
//import 'package:app_cecyt/utils/widgets/card_image.dart';
import 'package:flutter/material.dart';
//import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart'; // Importa ApiService
//import 'package:app_cecyt/utils/constants.dart'; // Importa la constante
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/features/home/ui/pages/cecyt_page.dart'; // Import CecytPage

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  static const path = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isLoading = false;
  String userName = 'Usuario'; // Valor por defecto si no hay sesión

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      final sessionState = context.read<SessionCubit>().state;
      print('SessionCubit state in fetchUserName (called by BlocListener or init): $sessionState');

      if (sessionState is SessionLoaded) {
        final token = sessionState.token;
        final userData = await ApiService().getUserData(token); // Assuming this returns a Map
        print('UserData from API: $userData');

        // Get the full name from the API response
        // Adjust the key 'name' if your API uses a different field
        final dynamic fullNameFromApi = userData['name'];

        if (fullNameFromApi is String && fullNameFromApi.isNotEmpty) {
          // Split the full name by spaces and take the first part
          final List<String> nameParts = fullNameFromApi.split(' ');
          final String firstName = nameParts.isNotEmpty ? nameParts[0] : 'Usuario'; // Take the first part, or fallback

          print('Full name: $fullNameFromApi, Extracted first name: $firstName');

          if (mounted) {
            setState(() {
              userName = firstName; // Set only the first name
            });
          }
        } else {
          print('Name field from API is not a valid string or is empty.');
          if (mounted) {
            setState(() {
              userName = 'Usuario'; // Fallback
            });
          }
        }
      } else {
        // SessionNotLoaded or other state
        if (mounted) {
          setState(() {
            userName = 'Usuario';
          });
        }
      }
    } catch (e) {
      print('Error trayendo nombre del usuario: $e');
      if (mounted) {
        setState(() {
          userName = 'Usuario';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _checkAdminStatus() async {
    final apiService = ApiService();
    try {
      final token = PrefManager(null).token;
      if (token != null) {
        setState(() {
          isLoading = true;
        });
        print('Token Refrescado');
        // final adminStatus = await apiService.isAdmin(token);
        // final responseBody = jsonDecode(adminStatus.body);
        // print(responseBody);
        // context
        //     .read<SessionCubit>()
        //     .setSession(token, responseBody['isAdmin'], 3600);
        await context.read<SessionCubit>().refreshToken();
      }
    } on NotAuthException {
      // if (isReIntento)
      //   context.read<SessionCubit>().logout();
      // else
      //   context.read<SessionCubit>().refreshToken().then(
      //         (value) => _checkAdminStatus(isReIntento: true),
      //       );
    } catch (e) {
      // context.read<SessionCubit>().logout();
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        print('BlocListener in StartPage detected SessionCubit state: $state');

        if (state is SessionLoaded) {
          print('BlocListener: Session is loaded, fetching user name.');
          fetchUserName(); // Esta función debería actualizar userName con setState
        } else if (state is SessionNotLoaded) {
          setState(() {
            userName = 'Usuario';
          });
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/CECYT_Fondo_Claro.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(1),
                    Colors.white.withOpacity(0),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: const BottomNavCentro(index: 0),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // *** ENCABEZADO PERSONALIZADO ***
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // 1) Logo arriba a la derecha
                          Positioned(
                            top: -90,
                            right: -80,
                            child: Image.asset(
                              'assets/logoInnotec_lindo.jpg',
                              width: 250,
                              height: 250,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // 2) Texto “Hola,” + nombre abajo a la izquierda
                          Positioned(
                            left: 30,
                            bottom: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hola,',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    height: 1.0,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 32,
                                    height: 1.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 70,
                      ),
                      child: Column(
                        children: [
                          // Botón de Horarios
                          CustomButtonWithImageOverlap(
                            title: 'Horarios',
                            subtitle: 'Clases y exámenes',
                            imagePath: 'assets/Recurso 7.png',
                            onTap: () => Navigator.of(context).pushNamed('/horarios'),
                            imagePosition: ImagePosition.right,
                          ).animate().slideY(
                            delay: const Duration(milliseconds: 50),
                            duration: const Duration(milliseconds: 300),
                          ),

                          const SizedBox(height: 50),

                          // Botón de CECYT
                          CustomButtonWithImageOverlap(
                            title: 'CECYT',
                            subtitle: 'Noticias y actividades',
                            imagePath: 'assets/Recurso 6.png',
                            onTap: () => Navigator.of(context).pushNamed(CecytPage.path),
                            imagePosition: ImagePosition.left,
                          ).animate().slideY(
                            delay: const Duration(milliseconds: 50),
                            duration: const Duration(milliseconds: 300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Nuevo enum para controlar la posición de la imagen
enum ImagePosition { left, right }

class CustomButtonWithImageOverlap extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String imagePath;
  final VoidCallback onTap;
  final ImagePosition imagePosition;

  const CustomButtonWithImageOverlap({
    super.key,
    required this.title,
    this.subtitle,
    required this.imagePath,
    required this.onTap,
    this.imagePosition = ImagePosition.right,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 130;
    const double overlap = 60;

    final arrowIcon = const Icon(
      Icons.arrow_forward_ios,
      size: 25,
      color: Colors.black,
    );

    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            height: 1.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontStyle: FontStyle.italic,
              fontSize: 12,
              height: 1.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ],
    );

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 100,
        clipBehavior: Clip.none,

        // 1) Padding variable según posición
        padding: EdgeInsets.only(
          left: imagePosition == ImagePosition.left ? 0 : 30,
          right: 30,
          top: 20,
          bottom: 20,
        ),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // imagen sobresaliente (igual que antes)
            Positioned(
              top: -overlap,
              left: imagePosition == ImagePosition.left ? 0 : null,
              right: imagePosition == ImagePosition.right ? 24 : null,
              child: Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            ),

            Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: imagePosition == ImagePosition.left
                    ? [
                        SizedBox(width: imageSize + 10),
                        Expanded(child: textContent),
                        arrowIcon,
                      ]
                    : [
                        Expanded(child: textContent),
                        SizedBox(width: imageSize),
                        arrowIcon,
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
