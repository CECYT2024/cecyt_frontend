import 'dart:convert';
import 'package:app_cecyt/utils/helpers/events_bloc.dart';
import 'package:intl/intl.dart';

class Question {
  final String question;
  final String questionUuid; // New field
  final int talkId;
  final String userName;
  final int likes;

  Question({
    required this.question,
    required this.questionUuid, // New field
    required this.talkId,
    required this.userName,
    required this.likes,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      questionUuid: json['question_uuid'], // Parse new field
      talkId: json['talk_id'],
      userName: json['user_name'],
      likes: json['likes_count'],
    );
  }
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
    String date = dayInt == 1 ? '2025-06-05' : '2025-06-06';
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
    return {
      'place': place,
      'time': startTime.toString(),
      'title': name,
      'speaker': speaker,
    };
  }
}

class DeleteEventFromList extends EventEvent {
  final Event event;

  DeleteEventFromList(this.event);

  @override
  List<Object?> get props => [event];
}

List<Event> events = [];
