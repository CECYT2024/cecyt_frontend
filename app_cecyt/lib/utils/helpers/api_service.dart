import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl; //TODO Agregar URL de la API
  ApiService({required this.baseUrl});
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

  Future<http.Response> getUserData(String token) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<bool> isAdmin(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/checkAdmin'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('Response Body: $responseBody'); // Log the response body
      return responseBody['isAdmin'];
    } else {
      print('Failed to check admin status: ${response.statusCode}'); // Log the error status code
      throw Exception('Failed to check admin status');
    }
  }

  Future<http.Response> saveQrInDb(String token, Map<String, String> formData) async {
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

  Future<http.Response> createTalk(String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/talks/create');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }

  Future<http.Response> editTalk(String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/talks/edit');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }

  Future<http.Response> deleteTalk(String token, String talkId) async {
    final url = Uri.parse('$baseUrl/talks/$talkId/delete');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> getQuestionByTalk(String token, String talkId) async {
    final url = Uri.parse('$baseUrl/questions/$talkId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> getMostLikedQuestions(String token, String talkId) async {
    final url = Uri.parse('$baseUrl/questions/$talkId/latest');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> checkNumberOfQuestionsByUser(String token, String talkId) async {
    final url = Uri.parse('$baseUrl/questions/talks/$talkId/user/count');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future<http.Response> likeQuestion(String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/questions/like');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }

  Future<http.Response> saveQuestion(String token, Map<String, String> formData) async {
    final url = Uri.parse('$baseUrl/questions/save');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: formData);
    return response;
  }
}
