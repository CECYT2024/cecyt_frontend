import 'dart:async';
import 'dart:convert';

import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/helpers/talks_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart'; // Importa ApiService
import 'package:uuid/uuid.dart';

class NewsCardsOne extends StatefulWidget {
  const NewsCardsOne({super.key});
  static const String path = '/news1';

  @override
  _NewsCardsOneState createState() => _NewsCardsOneState();
}

class _NewsCardsOneState extends State<NewsCardsOne> {
  final ApiService apiService = ApiService(); // Ajusta la URL base
  List<Event> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTalks();
  }

  Future<void> _loadTalks() async {
    try {
      final response = await apiService.getAllTalks(tokenCambiable);
      if (response.statusCode == 200) {
        List<Event> loadedEvents = Event.fromJson(response.body);
        setState(() {
          events = loadedEvents.where((event) {
            final now = DateTime.now();
            return event.startTime.isAfter(now.subtract(Duration(hours: 2)));
          }).toList()
            ..sort((a, b) => a.startTime.compareTo(b.startTime));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorDialog('Iniciar sesión o registrate para ver las preguntas');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }

  void _showQuestions(Event event) async {
    try {
      final response =
          await apiService.getQuestionByTalk(tokenCambiable, event.id);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          if (responseBody['status'] == 'ok' && responseBody['data'] != null) {
            List<Question> questions = (responseBody['data'] as List)
                .map((questionJson) => Question.fromJson(questionJson))
                .toList();
            questions.sort((a, b) => b.likes.compareTo(a.likes));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionsPage(event: event, questions: questions),
              ),
            );
          } else {
            _showErrorDialog(
                'Unexpected response format. ${response.statusCode},${response.body}');
          }
        } else {
          _showErrorDialog('No questions found.');
        }
      } else if (response.statusCode == 404) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuestionsPage(event: event, questions: const []),
          ),
        );
      } else {
        _showErrorDialog('Error al obtener las preguntas');
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Seleccionar charla"),
        toolbarHeight: 75,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return TalksSelector(
                          sala: event.place,
                          hora: DateFormat('HH:mm').format(event.startTime),
                          speaker: event.speaker,
                          title: event.name,
                          onTap: () {
                            _showQuestions(event);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class QuestionsPage extends StatefulWidget {
  final Event event;
  final List<Question> questions;

  const QuestionsPage(
      {super.key, required this.event, required this.questions});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late List<Question> questions;
  final ApiService apiService = ApiService();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    questions = widget.questions;
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _refreshQuestions();
    });
  }

  Future<void> _refreshQuestions() async {
    try {
      final updatedQuestions = await _showQuestions(widget.event);
      if (mounted) {
        setState(() {
          questions = updatedQuestions;
        });
      }
    } catch (e) {
      // Manejar el error si es necesario
    }
  }

  Future<List<Question>> _showQuestions(Event event) async {
    final response =
        await apiService.getQuestionByTalk(tokenCambiable, event.id);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'ok' && responseBody['data'] != null) {
        final List<dynamic> questionsData = responseBody['data'];
        return questionsData.map((data) => Question.fromJson(data)).toList();
      } else {
        throw Exception('Error en la respuesta de la API');
      }
    } else {
      throw Exception('Error al obtener las preguntas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: questions.isEmpty
          ? const Center(
              child: Text(
                'Aun no hay preguntas, se el primero en preguntar',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return ListTile(
                        title: Text(question.question),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Likes: ${question.likes}'),
                            IconButton(
                              icon: Icon(Icons.thumb_up,
                                  color: question.likes > 0
                                      ? Colors.blue
                                      : Colors.grey),
                              onPressed: () async {
                                final response = await apiService.likeQuestion(
                                    tokenCambiable, question.questionUuid);
                                if (response.statusCode == 200) {
                                  final Map<String, dynamic> responseBody =
                                      json.decode(response.body);
                                  if (responseBody['status'] == 'ok') {
                                    _refreshQuestions();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Error al dar like a la pregunta')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Error al dar like a la pregunta')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        subtitle: Text('User: ${question.userName}'),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addQuestion(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addQuestion(BuildContext context) async {
    final response = await apiService.checkNumberOfQuestionsByUser(
        tokenCambiable, widget.event.id);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'ok' && responseBody['data'] != null) {
        int questionCount = responseBody['data'];
        if (questionCount < 3) {
          _showAddQuestionDialog(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Solo se permiten 3 preguntas por usuario')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error al verificar el número de preguntas ${response.statusCode},${response.body}')),
      );
    }
  }

  void _showAddQuestionDialog(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Pregunta'),
          content: TextField(
            controller: questionController,
            decoration:
                const InputDecoration(hintText: 'Escribe tu pregunta aquí'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final questionText = questionController.text;
                if (questionText.isNotEmpty) {
                  final uuid = Uuid().v4();
                  final formData = {
                    'question': questionText,
                    'talk_id': widget.event.id.toString(),
                    'uuid': uuid,
                  };
                  final response =
                      await apiService.saveQuestion(tokenCambiable, formData);
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Pregunta agregada exitosamente')),
                    );
                    _refreshQuestions();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Error al agregar la pregunta, ${response.statusCode},${response.body}')),
                    );
                  }
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
