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
  List<Question> questions;

  Event({
    required this.name,
    required this.place,
    required this.speaker,
    required this.startTime,
    List<Question>? questions,
  }) : questions = questions ?? [];

  static DateTime parseDayAndTime(String day, String time) {
    int dayInt = int.parse(day);
    String date = dayInt == 1 ? '2024-10-07' : '2024-10-08';
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date $time:00');
  }
}

List<Event> events = [
  Event(
    name: 'Charla 1',
    place: 'Auditorio',
    speaker: 'Dr. Pérez',
    startTime: DateTime.parse('2024-10-07 10:00:00'),
    questions: [],
  ),
  Event(
    name: 'Charla 2',
    place: 'Sala 1',
    speaker: 'Ing. López',
    startTime: DateTime.parse('2024-10-08 14:00:00'),
    questions: [],
  ),
];
