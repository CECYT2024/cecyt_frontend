import 'package:flutter/material.dart';

// El siguiente codigo NO ESTA IMPLEMENTADO
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

class EventManager extends ChangeNotifier {
  final List<Event> _events = [
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

  String selectedDay = '';

  List<Event> get events => _events;

  List<Event> getEventsForSelectedDay() {
    return _events.where((event) => event.day == selectedDay).toList();
  }

  void addEvent(Event event) {
    _events.add(event);
    _sortEvents();
    notifyListeners();
  }

  void editEvent(int index, Event event) {
    _events[index] = event;
    _sortEvents();
    notifyListeners();
  }

  void deleteEvent(int index) {
    _events.removeAt(index);
    notifyListeners();
  }

  void _sortEvents() {
    _events.sort((a, b) => a.startTime.compareTo(b.startTime));
  }
}
