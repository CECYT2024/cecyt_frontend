import 'package:flutter/material.dart';

class NewsCardsFour extends StatelessWidget {
  const NewsCardsFour({super.key});
  static const String path = '/news4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 350,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 240, 240, 1),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'Qué es Innotec?',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Innotec es un congreso organizado por los estudiantes de la Facultad de Ciencias y Tecnología de la Universidad Católica de Asunción, donde los participantes disfrutan de charlas interesantes, talleres y otras actividades centradas en la innovación, la ciencia, la tecnología y el medio ambiente. El congreso permite visibilizar diversas problemáticas y explorar cómo los futuros profesionales pueden aportar soluciones.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Image.asset('assets/Innotec_Charla2.jpg'),
                  const Text(
                    'El anteriores ediciones, el congreso contó con la participación de destacados conferencistas nacionales e internacionales que abordaron temas como energías renovables, inteligencia artificial, construcciones sustentables, transformación digital, economía circular y el uso del hidrógeno verde. Estas presentaciones y discusiones buscaron contribuir al crecimiento y la formación profesional de los asistentes.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/innotec_charla4.jpg'),
                  const SizedBox(height: 20),
                  const Text(
                    'Además, el congreso incluyó un emocionante Hackathon, en el que los participantes se enfrentaron a desafíos reales con el objetivo de encontrar soluciones innovadoras a problemas actuales. Este evento estimuló la creatividad y la colaboración, permitiendo a los jóvenes talentos demostrar su capacidad para abordar y resolver cuestiones relevantes del mundo profesional.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset('assets/hackatonimage4.jpg'),
                        const SizedBox(width: 15),
                        Image.asset('assets/hackatonimage3.jpg'),
                        const SizedBox(width: 15),
                        Image.asset('assets/hackatonImage2.jpg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
