import 'dart:convert';
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
  final int id;
  List<Question> questions;

  Event({
    required this.name,
    required this.place,
    required this.speaker,
    required this.startTime,
    required this.id,
    List<Question>? questions,
  }) : questions = questions ?? [];

  static DateTime parseDayAndTime(String day, String time) {
    int dayInt = int.parse(day);
    String date = dayInt == 1 ? '2024-10-07' : '2024-10-08';
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date $time:00');
  }

  // Método para convertir JSON en una lista de objetos Event
  static List<Event> fromJson(String jsonString) {
    final data = json.decode(jsonString);

    // Manejo de errores
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
        id: eventData['id'],
      );
    }).toList();
  }
}

List<Event> events = [];
