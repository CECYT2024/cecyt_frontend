import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/models/news_model.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/features/home/ui/pages/news_page.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import '../../../utils/helpers/pref_manager.dart';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

final ApiService apiService = ApiService();


Future<List<News>> loadNews() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    News(
      image: 'assets/dotImage.jpeg',
      title: 'Noticia Demo',
      subtitle: 'Subtítulo noticia',
      description: 'Descripción de la noticia demo',
      date: '29 de junio, 2025'
    ),
    News(
      image: 'assets/dotImage.jpeg',
      title: 'Segunda Noticia Prueba',
      subtitle: 'Subtítulo noticia',
      description: 'Descripción de la noticia demo',
      date: '29 de julio, 2025'
    ),
    
  ];
}

class NewsCardList extends StatelessWidget {
  final String token;
  const NewsCardList({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: loadNews(), //Aquí recibe el token como parametro
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar noticias'));
        }
        final newsList = snapshot.data ?? [];
        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList[index];
            return NewsCard(news: news);
          },
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          NewsPage.path, // Cambia por la ruta de tu página destino
          arguments: news,
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Image.asset(
                    news.image,
                    width: 400,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(news.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,)),
                    Text(
                      news.date,
                      style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
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
    );
  }
}