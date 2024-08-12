import 'dart:convert';
import 'package:app_cecyt/utils/constants.dart' as c;
import 'package:http/http.dart' as http;
import 'event.dart';

class ApiService {
  final String baseUrl = c.baseUrl;
  ApiService();
  Future<http.Response> register(Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(url, body: formData);
    return response;
  }

  Future<http.Response> login(Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url, body: formData);
    return response;
  }

  Future<http.Response> forgotPassword(Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    final response = await http.post(url, body: formData);
    return response;
  }

  Future<http.Response> recoverPassword(Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/forgot-password/recover');
    final response = await http.post(url, body: formData);
    return response;
  }

  Future<http.Response> refreshToken(String token) async {
    final url = Uri.parse('$baseUrl/refresh');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> logout(String token) async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final url = Uri.parse('$baseUrl/user/');
    final response = await _postWithRedirect(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load user data ${response.statusCode} ${response.body}');
    }
  }

  Future<http.Response> _postWithRedirect(Uri url,
      {required Map<String, String> headers}) async {
    final response = await http.post(url, headers: headers);
    if (response.statusCode == 301 || response.statusCode == 302) {
      final newUrl = response.headers['location'];
      if (newUrl != null) {
        return await http.post(Uri.parse(newUrl), headers: headers);
      } else {
        throw Exception('Redirection without location header');
      }
    }
    return response;
  }

  Future<http.Response> isAdmin(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/rol'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      // Log the error status code
      throw Exception('Failed to check admin status');
    }
  }

  Future<http.Response> saveQrInDb(
      String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/user/qr');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }

  Future<http.Response> getAllTalks(String token) async {
    final url = Uri.parse('$baseUrl/talks');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<List<Event>> getTalks() async {
    final response = await http.get(Uri.parse('$baseUrl/talks'));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body)['data'];
      List<Event> talks = body
          .map((dynamic item) => Event(
                id: item['id'],
                name: item['title'],
                place: item['place'],
                speaker: item['speaker'],
                startTime: DateTime.parse(item['time']),
              ))
          .toList();
      return talks;
    } else {
      throw Exception('Failed to load talks');
    }
  }

  Future<http.Response> editTalk(Event event, String token) async {
    final url = Uri.parse('$baseUrl/talks/edit/');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'place': event.place,
        'time': event.startTime.toString(),
        'title': event.name,
        'speaker': event.speaker,
        'talk_id': event.id,
      }),
    );
    if (response.statusCode == 301 || response.statusCode == 302) {
      final newUrl = response.headers['location'];
      if (newUrl != null) {
        final newResponse = await http.post(
          Uri.parse(newUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'place': event.place,
            'time': event.startTime.toIso8601String(),
            'title': event.name,
            'speaker': event.speaker,
            'talk_id': event.id,
          }),
        );
        return newResponse;
      }
    }
    return response;
  }

  Future<http.Response> createTalk(Event event, String token) async {
    final url = Uri.parse('$baseUrl/talks/create');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(event.toJson()),
    );
    return response;
  }

  Future<http.Response> deleteTalk(int id, String token) async {
    String idS = id.toString();
    final url = Uri.parse('$baseUrl/talks/$idS/delete');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> getQuestionByTalk(String token, int talkId) async {
    final url = Uri.parse('$baseUrl/questions/${talkId.toString()}');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> getMostLikedQuestions(
      String token, String talkId) async {
    final url = Uri.parse('$baseUrl/questions/$talkId/latest');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> checkNumberOfQuestionsByUser(
      String token, int talkId) async {
    final url =
        Uri.parse('$baseUrl/questions/talks/${talkId.toString()}/user/count');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> likeQuestion(String token, String questionUuid) async {
    final url = Uri.parse('$baseUrl/questions/$questionUuid/like');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<http.Response> saveQuestion(
      String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/questions/save');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }
}
