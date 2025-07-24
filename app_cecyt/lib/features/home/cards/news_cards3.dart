import 'package:flutter/material.dart';

class NewsCardsThree extends StatelessWidget {
  const NewsCardsThree({super.key});
  static const String path = '/news3';

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
                'Organizadores',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista de algunas de las personas que ayudan a hacer esta experiencia inolvidable!',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      NombresLista('Fernanda Rojas', 'DIRECTORA GENERAL'),
                      NombresLista('Rafael Chica', 'DIRECTOR GENERAL'),
                      NombresLista('Sofía Cubilla', 'DIRECTORA DE FINANZAS'),
                      NombresLista('Leticia Franco', 'DIRECTORA DE MARKETING'),
                      NombresLista('Luján Medina', 'DIRECTORA DE MARKETING'),
                      NombresLista('Camilo Rivas', 'DIRECTOR DE DISEÑO'),
                      NombresLista('Alejandra Di Natale', 'DIRECTORA DE CONTENIDO'),
                      NombresLista('Gabriela Mendoza', 'DIRECTORA DE CONTENIDO'),
                      NombresLista('Luciana Cálcena', 'DIRECTORA DE SPONSORS'),
                      NombresLista('Nicole Wood', 'DIRECTORA DE LOGÍSTICA'),
                      NombresLista('Renata Ochippinti', 'DIRECTORA DE TALLERES'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NombresLista extends StatelessWidget {
  const NombresLista(this.nombreApellido, this.titulo, {super.key});

  final String nombreApellido;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border(
          top: BorderSide(width: 1.0, color: Color.fromARGB(54, 0, 0, 0)),
          bottom: BorderSide(width: 1.0, color: Color.fromARGB(53, 0, 0, 0)),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(
              nombreApellido,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 100, 100, 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
