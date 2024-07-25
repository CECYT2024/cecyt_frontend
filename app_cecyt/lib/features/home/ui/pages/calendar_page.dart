import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:intl/intl.dart';
import 'package:app_cecyt/utils/helpers/horarios_format.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  static const String path = '/calendar';

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int selectedDay = 1;

  List<Event> getEventsForSelectedDay() {
    return events.where((event) {
      final selectedDate = selectedDay == 1 ? DateTime(2024, 10, 7) : DateTime(2024, 10, 8);
      return event.startTime.year == selectedDate.year && event.startTime.month == selectedDate.month && event.startTime.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Column(
        children: [
          const SizedBox(height: 10),
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
                  backgroundColor: selectedDay == 1 ? const Color.fromARGB(255, 102, 178, 236) : Colors.grey,
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
                  backgroundColor: selectedDay == 2 ? const Color.fromARGB(255, 102, 178, 236) : Colors.grey,
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
                return HorarioContainer(event.place, DateFormat('HH:mm').format(event.startTime), event.name, event.speaker);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
