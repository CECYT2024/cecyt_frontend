//Pagina de Descripcion de Actividad
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_cecyt/features/auth/data/models/activity_model.dart';


class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});
  static const String path = '/activities';

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/CECYT_Fondo_Claro.jpg', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const AppbarCentro(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    activity.image,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/Fecha.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          activity.date,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/Hora.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          activity.time,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/Ubicacion.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          activity.place,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activity.subtitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        activity.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}
