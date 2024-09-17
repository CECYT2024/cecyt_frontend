// news_cards_service.dart
import 'dart:convert';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';

class NewsCardsService {
  final ApiService apiService = ApiService();

  Future<List<Event>> loadTalks(String token) async {
    final response = await apiService.getAllTalks(token);
    if (response.statusCode == 200) {
      List<Event> loadedEvents = Event.fromJson(response.body);
      return loadedEvents.where((event) {
        final now = DateTime.now();
        return event.startTime.isAfter(now.subtract(Duration(hours: 2)));
      }).toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
    } else {
      throw Exception('Error al cargar las charlas');
    }
  }

  Future<List<Question>> getQuestionsByTalk(String token, int eventId) async {
    final response = await apiService.getQuestionByTalk(token, eventId);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'ok' && responseBody['data'] != null) {
        List<Question> questions = (responseBody['data'] as List)
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
        questions.sort((a, b) => b.likes.compareTo(a.likes));
        return questions;
      } else {
        throw Exception('Unexpected response format');
      }
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Error al obtener las preguntas');
    }
  }

  Future<void> likeQuestion(String token, String questionUuid) async {
    final response = await apiService.likeQuestion(token, questionUuid);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 403) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'error' &&
          responseBody['message'] ==
              'User does not have qr_code. You need to purchase a ticket to like or dislike a question') {
        throw Exception(
            'Necesitas comprar un ticket para dar like a una pregunta');
      } else {
        throw Exception('Error al dar like a la pregunta');
      }
    }
    if (response.statusCode != 200) {
      throw Exception('Error al dar like a la pregunta');
    }
  }

  Future<int> checkNumberOfQuestionsByUser(String token, int eventId) async {
    final response =
        await apiService.checkNumberOfQuestionsByUser(token, eventId);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'ok' && responseBody['data'] != null) {
        return responseBody['data'];
      } else {
        throw Exception('Error en la respuesta de la API');
      }
    } else if (response.statusCode == 403) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'error' &&
          responseBody['message'] ==
              'User does not have qr_code. You need to purchase a ticket to like or dislike a question') {
        throw Exception('Necesitas comprar un ticket para hacer una pregunta');
      } else {
        throw Exception('Error al verificar el número de preguntas');
      }
    } else {
      throw Exception('Error al verificar el número de preguntas');
    }
  }

  Future<void> saveQuestion(String token, Map<String, String> formData) async {
    final response = await apiService.saveQuestion(token, formData);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 403) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'error' &&
          responseBody['message'] ==
              'User does not have qr_code. You need to purchase a ticket to ask questions') {
        throw Exception('Necesitas comprar un ticket para hacer una pregunta');
      } else {
        throw Exception('Error al agregar la pregunta');
      }
    }
    if (response.statusCode != 200) {
      throw Exception('Error al agregar la pregunta');
    }
  }
}
