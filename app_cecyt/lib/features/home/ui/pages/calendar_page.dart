import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class Event {
  final String day;
  final String place;
  final String name;
  final String speaker;
  final String startTime;

  Event({
    required this.day,
    required this.place,
    required this.name,
    required this.speaker,
    required this.startTime,
  });
}

final List<Event> events = [
  Event(
      day: '1',
      place: 'Sala 1',
      name: 'Evento 1',
      speaker: 'Disertante 1',
      startTime: '10:00'),
  Event(
      day: '1',
      place: 'Sala 1',
      name: 'Evento 2',
      speaker: 'Disertante 2',
      startTime: '12:00'),
  Event(
      day: '2',
      place: 'Sala 2',
      name: 'Evento 3',
      speaker: 'Disertante 3',
      startTime: '14:00'),
  Event(
      day: '2',
      place: 'Sala 3',
      name: 'Evento 4',
      speaker: 'Disertante 4',
      startTime: '16:00'),
];

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  static const String path = '/calendar';

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class HorarioContainer extends StatelessWidget {
  const HorarioContainer(this.sala, this.hora, this.speaker, this.title,
      {super.key});

  final String sala;
  final String hora;
  final String speaker;
  final String title;

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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                sala,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 19, 156, 224),
                ),
              ),
              Text(
                hora,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  speaker,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarPageState extends State<CalendarPage> {
  int selectedDay = 1;

  List<Event> getEventsForSelectedDay() {
    return events
        .where((event) => event.day == selectedDay.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                  blurRadius: 1.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: const Text(
              'Cronograma',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                      : Colors.grey,
                ),
                child: const Text(
                  'Día 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 60),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDay == 2
                      ? const Color.fromARGB(255, 102, 178, 236)
                      : Colors.grey,
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
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: getEventsForSelectedDay().map((event) {
                return HorarioContainer(
                  event.place,
                  event.startTime,
                  event.name,
                  event.speaker,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
