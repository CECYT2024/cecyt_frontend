import 'package:flutter/material.dart';
import 'event.dart'; // Importa el archivo donde está definida la clase Event

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  String? _errorMessage;

  List<Event> get events => _events;
  String? get errorMessage => _errorMessage;

  void setEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchEvents() async {
    try {
      // Realiza la solicitud HTTP aquí y obtiene el JSON de respuesta
      String jsonResponse = '{"status": "ok", "data": [...]}'; // Ejemplo
      List<Event> events = Event.fromJson(jsonResponse);
      setEvents(events);
    } catch (e) {
      setError(e.toString());
    }
  }
}
