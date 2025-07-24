import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  static const String path = '/credits';
  const CreditsPage({super.key});

  // Lista de personas
  final List<Map<String, String>> _creditsList = const [
    {'name': 'Matías Ayala', 'role': 'Director Front-End'},
    {'name': 'Fernando Elizondo', 'role': 'Director Front-End'},
    {'name': 'Jamile Hazime', 'role': 'Diseñadora'},
    {'name': 'Héctor Bernal', 'role': 'Programador Front-End'},
    {'name': 'Lucas Burgos', 'role': 'Programador Front-End'},
    {'name': 'Sebastián Laguardia', 'role': 'Programador Front-End'},
    {'name': 'Cecilia Romero', 'role': 'Programador Front-End'},
    {'name': 'Valdemar Ortiz', 'role': 'Programador Front-End'},
    {'name': 'Oliver Kochmann', 'role': 'Programador Front-End'},
  ];

  @override
  Widget build(BuildContext context) {


    // Estilos de texto definidos según el manual de diseño
  const TextStyle titleStyle = TextStyle( //Texto principal
  fontFamily: 'Poppins Bold',
  fontWeight: FontWeight.bold,
  fontSize: 32,
  color: Colors.black,
);

  const TextStyle subtitleStyle = TextStyle( //Texto complementario
    fontFamily: 'Poppins Medium',
    fontWeight: FontWeight.w300, // Light
    fontSize: 24,
    color: Color.fromARGB(255, 141, 140, 140),
);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Imagen de fondo que cubre toda la pantalla.
          Opacity(
            opacity: 0.5, //Ajustar opacidad del fondo
            child: Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/CECYT_Fondo_Claro.JPG'),
            fit: BoxFit.cover,
      ),
    ),
  ),
),

    // 1.5. Forma blanca con sombra encima del fondo, detrás de la mano.
    Positioned(

      top: MediaQuery.of(context).size.height * 0.33, // este valor para cambiar el punto desde el cual empieza
      left: -30,
      right: -30,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
        color: const Color.fromARGB(86, 255, 255, 255),
        borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(75),
        topRight: Radius.circular(75),
      ),

      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(20, 0, 0, 0),
          blurRadius: 15,
          offset: const Offset(0, -10),
        ),
      ],
    ),
  ),
),


// 2. Imagen de la mano, posicionada arriba a la derecha.
    Positioned(

      top: 115,
      right: -40,
      child: Image.asset(
        'assets/Recurso 8.png', // Imagen de la mano
        width: MediaQuery.of(context).size.width * 0.55,
        ),
      ),

      // 3. Contenido principal con encabezado fijo y lista con scroll.
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // --- ENCABEZADO FIJO  ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100), // Espacio para que el texto no choque con la mano.
                  Text('Historial', style: titleStyle),
                  SizedBox(height: 8),
                  Text(
                    'Desarrollo\nApp CECYT',
                    style: subtitleStyle,
                    textAlign: TextAlign.left,
                  ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),

                // --- LISTA CON SCROLL ---
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    itemCount: _creditsList.length,
                    itemBuilder: (context, index) {
                      final credit = _creditsList[index];
                      return _CreditPerson(
                        name: credit['name']!,
                        role: credit['role']!,
                        nameStyle: titleStyle.copyWith(fontSize: 24), 
                        roleStyle: subtitleStyle.copyWith(fontSize: 18),
                      );
                    },
                  ),
                ),
                
                // --- ESPACIO FIJO PARA LA BARRA DE NAVEGACIÓN ---
                const SizedBox(height: 80), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para mostrar cada persona en la lista.
class _CreditPerson extends StatelessWidget {
  const _CreditPerson({
    required this.name,
    required this.role,
    required this.nameStyle,
    required this.roleStyle,
  });

  final String name;
  final String role;
  final TextStyle nameStyle;
  final TextStyle roleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: nameStyle),
          Text(role, style: roleStyle),
          const SizedBox(height: 12),
          const Divider(
            thickness: 1,
            color: Color.fromARGB(100, 170, 170, 170), // gris claro de la barrita divisoria
          ),
        ],
      ),
    );
  }
}