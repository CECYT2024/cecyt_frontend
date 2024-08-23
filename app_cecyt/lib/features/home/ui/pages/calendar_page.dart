import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:app_cecyt/utils/helpers/events_bloc.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:app_cecyt/utils/helpers/horarios_format.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CalendarPage extends StatefulWidget {
  static const String path = '/calendar';

  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int selectedDay = 1;

  @override
  void initState() {
    super.initState();
    // Cargar los eventos cuando la página se inicializa
    context.read<EventsBloc>().add(FetchEvents());
  }

  List<Event> getEventsForSelectedDay(List<Event> events) {
    final selectedDate =
        selectedDay == 1 ? DateTime(2024, 10, 7) : DateTime(2024, 10, 8);
    return events.where((event) {
      return event.startTime.year == selectedDate.year &&
          event.startTime.month == selectedDate.month &&
          event.startTime.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(
        index: 1,
      ),
      backgroundColor: Colors.white,
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
          ).animate().fadeIn(duration: 500.ms),
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
                      ? const Color.fromARGB(255, 102, 178, 236)
                      : Colors.grey,
                ),
                child: const Text(
                  'Día 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ).animate().slideX(duration: 500.ms),
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
              ).animate().slideX(duration: 500.ms),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<EventsBloc, EventState>(
              builder: (context, state) {
                if (state is EventsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EventsLoaded) {
                  final events = getEventsForSelectedDay(state.events);
                  return ListView(
                    children: events.map((event) {
                      return HorarioContainer(
                        event.place,
                        DateFormat('HH:mm').format(event.startTime),
                        event.name,
                        event.speaker,
                      ).animate().fadeIn(duration: 500.ms);
                    }).toList(),
                  );
                } else if (state is EventsError) {
                  print(state.message);
                  return Center(child: Text('Error al cargar los eventos'));
                } else {
                  return const Center(
                      child: Text('No hay eventos disponibles'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
