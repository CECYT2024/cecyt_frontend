import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  static const String path = '/calendar';

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class HorarioContainer extends StatelessWidget {
  const HorarioContainer(this.sala, this.hora, this.speaker, this.title, {super.key});

  final String sala;
  final String hora;
  final String speaker;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border(
          top: BorderSide(width: 2.0, color: Colors.black),
          bottom: BorderSide(width: 2.0, color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      height: 80, // Adjusted height to fit the content better
      child: Row(
        children: [
          Expanded(
            child: Text(
              sala,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speaker,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              hora,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarPageState extends State<CalendarPage> {
  int selectedDay = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Column(
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
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Siguientes eventos:',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20), // Separación entre el texto y los botones
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 1;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDay == 1
                      ? Color.fromARGB(255, 102, 178, 236)
                      : Colors.grey, // Color del botón cuando está seleccionado
                ),
                child: const Text(
                  'Día 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 60), // Separación entre los dos botones
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDay == 2
                      ? const Color.fromARGB(255, 102, 178, 236)
                      : Colors.grey, // Color del botón cuando está seleccionado
                ),
                child: const Text(
                  'Día 2',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Separación entre los botones y los widgets desplazables
          Expanded(
            child: selectedDay == 1
                ? ListView(
                    children: const [
                      HorarioContainer('Sala 1', '16:00', 'Speaker 1', 'Title 1'),
                      HorarioContainer('Sala 2', '18:00', 'Speaker 2', 'Title 2'),
                    ],
                  )
                : ListView(
                    children: const [
                      HorarioContainer('Sala 3', '10:00', 'Speaker 3', 'Title 3'),
                      HorarioContainer('Sala 4', '12:00', 'Speaker 4', 'Title 4'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

