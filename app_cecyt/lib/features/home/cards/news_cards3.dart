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
                      NombresLista('Giovanna Vallena', 'PRESIDENTE CECYT'),
                      NombresLista('Santiago J. Céspedes', 'DIRECTOR GENERAL'),
                      NombresLista('Laura Wenz', 'DIRECTORA DE FINANZAS'),
                      NombresLista('Agustin Spinzi', 'DIRECTOR DE FINANZAS'),
                      NombresLista('Ignacio Barrail', 'DIRECTOR DE PRODUCCIÓN'),
                      NombresLista('Valentina Palarea', 'DIRECTORA DE PRODUCCIÓN'),
                      NombresLista('Nicole Wood', 'DIRECTORA DE PRODUCCIÓN'),
                      NombresLista('Sebastian Agüero', 'DIRECTOR DE PRODUCCIÓN'),
                      NombresLista('Leticia Franco', 'DIRECTORA DE MARKETING'),
                      NombresLista('Rafa Chica', 'DIRECTOR DE MARKETING'),
                      NombresLista('Melany Ojeda', 'DIRECTORA DE MARKETING'),
                      NombresLista('Ma. Alejandra Villa', 'DIRECTORA INSTITUCIONAL'),
                      NombresLista('Male Barboza', 'DIRECTORA INSTITUCIONAL'),
                      NombresLista('María Paz Velázquez', 'DIRECTORA DE SPONSORS'),
                      NombresLista('Paz Mercado', 'DIRECTORA DE SPONSORS'),
                      NombresLista('Matías Pavón', 'DIRECTOR DE SPONSORS'),
                      NombresLista('Lucas Ayala', 'DIRECTOR DE SPONSORS'),
                      NombresLista('Hugo Miranda', 'DIRECTOR TECNOLOGICO'),
                      NombresLista('Federico Alonso', 'DIRECTOR TECNOLOGICO'),
                      NombresLista('Sergio Medina', 'DIRECTOR TECNOLOGICO'),
                      NombresLista('Julio Fernández', 'DIRECTOR DE HACKATHON'),
                      NombresLista('Leticia Meyer', 'DIRECTORA DE HACKATHON'),
                      NombresLista('Emmanuel Insfrán', 'DIRECTOR DE HACKATHON'),
                      NombresLista('Walder Pereira', 'DIRECTOR DE HACKATHON'),
                      NombresLista('Miguel Rojas', 'DIRECTOR DE CONTENIDO'),
                      NombresLista('Jeandy Chacal', 'DIRECTORA DE CONTENIDO'),
                      NombresLista('Fiorella Sapienza', 'DIRECTORA DE CONTENIDO'),
                      NombresLista('Maximiliano Cárdenas', 'DIRECTOR RRPP'),
                      NombresLista('Palo Rios', 'DIRECTORA RRPP'),
                      NombresLista('Ayesa Moreno', 'DIRECTORA RRPP'),
                      NombresLista('Julieta Vitale', 'DIRECTORA ACADÉMICA'),
                      NombresLista('Samara Esmeil', 'DIRECTORA ACADÉMICA'),
                      NombresLista('Sebastián Maidana', 'DIRECTOR ACADÉMICO'),
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
