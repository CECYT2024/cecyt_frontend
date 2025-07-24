import 'package:flutter/material.dart';

class NewsCardsFour extends StatelessWidget {
  const NewsCardsFour({super.key});
  static const String path = '/news4'; //Pantalla de 'Qué es el Innotec?'

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
                '¿Qué es Dot?',
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
                    'DOT es el congreso de diseño y arquitectura organizado por estudiantes de la FCyT – Universidad Católica. Un espacio para pensar, crear y transformar el mundo desde el diseño. Charlas, talleres y experiencias que cruzan disciplinas e inspiran nuevas formas de proyectar el futuro.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Image.asset('assets/dotinfoFoto.jpeg'),
                  const SizedBox(height: 10),
                  const Text(
                    'El tema central de esta edición es “Mente, espacio y forma”. Un llamado a pensar el diseño como un puente entre lo interno y lo externo, entre lo que somos, lo que imaginamos y lo que proyectamos.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Image.asset('assets/dotinfo2.jpeg'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}