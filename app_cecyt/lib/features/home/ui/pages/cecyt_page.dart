import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_cecyt/features/home/cards/news__card.dart';
import 'package:app_cecyt/features/home/cards/activity_card.dart';
import 'package:app_cecyt/features/auth/data/models/activity_model.dart'; 
import 'package:app_cecyt/features/auth/data/models/news_model.dart';
import 'package:app_cecyt/core/cubit/global_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CecytPage extends StatelessWidget {
  const CecytPage({super.key});
  static const String path = '/cecyt';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/CECYT_Fondo_Claro.jpg', fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: const AppbarCentro(),
          backgroundColor:
              Colors.transparent, // Fondo transparente para ver la imagen
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16), // margen izquierdo
                    child: Text(
                      'CECYT',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 28, 
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16), // margen izquierdo
                    child: Text(
                      'Actividades',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500, // Poppins Medium
                        fontSize: 20, 
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 140, // alto de las cards de actividades
                    child: FutureBuilder<List<Activity>>(
                      future: loadActivities(), // tu función para cargar actividades
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final activities = snapshot.data!;
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: activities.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            return ActivityCard(activity: activity);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16), // margen izquierdo
                    child: Text(
                      'Noticias',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500, 
                        fontSize: 20, 
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<News>>(
                    future: loadNews(), // función para cargar noticias
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final newsList = snapshot.data!;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final news = newsList[index];
                          return NewsCard(news: news);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
