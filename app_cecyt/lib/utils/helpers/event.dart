import 'dart:convert';
import 'package:app_cecyt/utils/helpers/events_bloc.dart';
import 'package:intl/intl.dart';

class Question {
  final String studentId;
  final String text;
  int likes;

  Question({
    required this.studentId,
    required this.text,
    this.likes = 0,
  });
}

class Event {
  final String name;
  final String place;
  final String speaker;
  final DateTime startTime;
  final int id; // Cambiado a non-nullable

  Event({
    required this.name,
    required this.place,
    required this.speaker,
    required this.startTime,
    required this.id, // Cambiado a required
  });

  static DateTime parseDayAndTime(String day, String time) {
    int dayInt = int.parse(day);
    String date = dayInt == 1 ? '2024-10-07' : '2024-10-08';
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date $time:00');
  }

  // Método para convertir JSON en una lista de objetos Event
  static List<Event> fromJson(String jsonString) {
    final data = json.decode(jsonString);

    if (data is Map<String, dynamic> && data.containsKey('message')) {
      if (data['message'] == "Unauthenticated.") {
        throw Exception("Usuario no autenticado.");
      }
    }

    final List<dynamic> eventsData = data['data'];
    return eventsData.map((eventData) {
      return Event(
        name: eventData['title'],
        place: eventData['place'],
        speaker: eventData['speaker'],
        startTime: DateTime.parse(eventData['time']),
        id: eventData['id'], // Asegurarse de que el id se almacene
      );
    }).toList();
  }

  Map<String, dynamic> toJson() {
    print('Numero tembo ${startTime}');
    return {
      'place': place,
      'time': startTime.toString(),
      'title': name,
      'speaker': speaker,
    };
  }
}

class DeleteEvent extends EventEvent {
  final Event event;

  DeleteEvent(this.event);

  @override
  List<Object?> get props => [
        event
      ];
}

List<Event> events = [];
