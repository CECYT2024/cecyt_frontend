import 'package:flutter/material.dart';

class NewsCardsTwo extends StatelessWidget {
  const NewsCardsTwo({super.key});
  static const String path = '/news2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
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
                'Informacion',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/InformacionFoto1.png'), // Asegúrate de que la ruta sea correcta
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/InformacionFoto2.png'), // Asegúrate de que la ruta sea correcta
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Todos los derechos de las imágenes y logos son de propiedad de CECYT y de la Universidad Católica Nuestra Señora de la Asunción.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desarrolladores:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('- Federico Alonso ~ Director Frontend / Programador Fullstack'),
                  Text('- Hugo Sebastian Miranda Areco ~ Director Backend / Programador Fullstack'),
                  Text('- Matías José Ayala Olmedo ~ Programador Frontend'),
                  Text('- Valdemar Ortiz ~ Programador Fullstack'),
                  Text('- Fernando José Elizondo Peña ~ Programador Backend'),
                  Text('- Enzo Marcos Erico Fuster ~ Programador Backend'),
                  Text('- Damian Alejandro Ramirez Gonzalez ~ Programador Backend'),
                  Text('- Santiago Ramón Fernandez Martinez ~ Programador Backend'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
