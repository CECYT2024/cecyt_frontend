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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lista de las personas que ayudan a hacer esta experiencia inolvidable!',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 400, // Puedes ajustar la altura según sea necesario
                    child: ListView(
                      children: const [
                        NombresLista('Santiago José María Céspedes Vento'),
                        NombresLista('Giovanna Verenice Vallena Martinez'),
                        NombresLista('Laura Verónica Wenz Aparici'),
                        NombresLista('Agustin Spinzi Cantero'),
                        NombresLista('Sebatián Andres Agüero Rachid'),
                        NombresLista('Ignacio Javier Barrail Masulli'),
                        NombresLista('Enzo Giuliano Barrios Sosa'),
                        NombresLista('Nicole Wood Arza'),
                        NombresLista('Leticia Maria Franco Benítez'),
                        NombresLista('Melany Agustina Ojeda Cardozo'),
                        NombresLista('María Paz Velázquez Aponte'),
                        NombresLista('Jimena Cordero Correa'),
                        NombresLista('Matías Samuel	Pavón Saldivar'),
                        NombresLista('Julio Javier Fernández León'),
                        NombresLista('Leticia María	Meyer Gauto'),
                        NombresLista('Emmanuel	Insfrán Caballero'),
                        NombresLista('Walder Matías	Pereira Gauto'),
                        NombresLista('Maria Paz Mercado Gomez'),
                        NombresLista('Miguel Angel	Rojas Netto'),
                        NombresLista('Jeandark Alejandra Chacal Méndez'),
                        NombresLista('Fiorella Belén	Sapienza Torales'),
                        NombresLista('Maximiliano José	Cárdenas García'),
                        NombresLista('Ayesa Zamira	Moreno Cáceres'),
                        NombresLista('Julieta	Vitale Fragnaud'),
                        NombresLista('Samara Yasmin	Esmeil Lesme'),
                        NombresLista('Sebastián David	Maidana Berino'),
                        NombresLista('María Alejandra	Barboza Guerrero'),
                        NombresLista('María Alejandra	Villa Larrosa'),
                        // Añade más instancias de NombresLista aquí
                      ],
                    ),
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
  const NombresLista(this.nombreApellido, {super.key});

  final String nombreApellido;

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
        // Cambio aquí: usa Center para alinear el contenido
        child: Text(
          nombreApellido,
          textAlign: TextAlign.center, // Cambio aquí: centra el texto
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
