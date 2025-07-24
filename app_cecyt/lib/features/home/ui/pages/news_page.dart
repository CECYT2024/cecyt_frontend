//Pagina de Descripcion de Noticia

import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_cecyt/features/auth/data/models/news_model.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  static const String path = '/news';

  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)!.settings.arguments as News;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/CECYT_Fondo_Claro.jpg', fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Para que el fondo se vea
          appBar: const AppbarCentro(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    news.image,
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
                        SvgPicture.asset('assets/Fecha.svg', width: 15, height: 15),
                        const SizedBox(width: 8),
                        Text(news.date, style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 10)),
                        const SizedBox(width: 8),
                        SvgPicture.asset('assets/Autor.svg', width: 15, height: 15),
                        const SizedBox(width: 8),
                        Text(news.subtitle, style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 10)),
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
                        news.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        news.description,
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
      ],
    );
  }
}