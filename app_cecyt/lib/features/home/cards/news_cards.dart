import 'dart:async';
import 'dart:io';

import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:app_cecyt/utils/helpers/talks_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import 'package:uuid/uuid.dart';
import 'news_cards_service.dart'; // Importa NewsCardsService

class NewsCardsOne extends StatefulWidget {
  const NewsCardsOne({super.key});
  static const String path = '/news1';

  @override
  _NewsCardsOneState createState() => _NewsCardsOneState();
}

class _NewsCardsOneState extends State<NewsCardsOne> {
  final NewsCardsService newsCardsService = NewsCardsService();
  List<Event> events = [];
  bool isLoading = true;
  bool isButtonLoading = false; // Estado para controlar el botón de carga

  @override
  void initState() {
    super.initState();
    _loadTalks();
  }



  Future<void> _loadTalks() async {
    try {
      final token = PrefManager(null).token ?? '';
      final loadedEvents = await newsCardsService.loadTalks(token);
      setState(() {
        events = loadedEvents;
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('No se tiene conexión a Internet.');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }

  void _showQuestions(Event event) async {
    setState(() {
      isButtonLoading = true; // Mostrar el indicador de carga
    });
    try {
      final token = PrefManager(null).token ?? '';
      final questions =
          await newsCardsService.getQuestionsByTalk(token, event.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionsPage(event: event, questions: questions),
        ),
      );
    } on SocketException {
      _showErrorDialog('No se tiene conexión a Internet.');
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        isButtonLoading = false; // Ocultar el indicador de carga
      });
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
                Navigator.of(context).popUntil((route) => route.isFirst);
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
          : Column(
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
                          if (!isButtonLoading) {
                            _showQuestions(event);
                          }
                        },
                      );
                    },
                  ),
                ),
                if (isButtonLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
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
  final NewsCardsService newsCardsService = NewsCardsService();
  Timer? _timer;
  bool isButtonLoading = false; // Estado para controlar el botón de carga

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
      final token = PrefManager(null).token ?? '';
      final updatedQuestions =
          await newsCardsService.getQuestionsByTalk(token, widget.event.id);
      if (mounted) {
        setState(() {
          questions = updatedQuestions;
        });
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se tiene conexión a Internet.')),
      );
    } catch (e) {
      // Manejar el error si es necesario
    }
  }

  @override
  bool isLiked = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                              icon: Icon(Icons.thumb_up, color: isLiked ? Colors.blue : Colors.grey),
                              onPressed: () async {
                                setState(() {
                                  isLiked = !isLiked; // Cambia el estado visual inmediatamente
                                });

                                try {
                                  final token = PrefManager(null).token ?? '';
                                  await newsCardsService.likeQuestion(token, question.questionUuid);
                                  _refreshQuestions();
                                } on SocketException {
                                  setState(() {
                                    isLiked = !isLiked; // Revertir el cambio si falla por conexión
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('No se tiene conexión a Internet.')),
                                  );
                                } catch (e) {
                                  setState(() {
                                    isLiked = !isLiked; // Revertir el cambio si ocurre otro error
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },

                            ),
                          ],
                        ),
                        subtitle: Text('Pregunta de ${question.userName}'),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: isButtonLoading
            ? null
            : () async {
                setState(() {
                  isButtonLoading = true; // Mostrar el indicador de carga
                });
                await _addQuestion(context);
                setState(() {
                  isButtonLoading = false; // Ocultar el indicador de carga
                });
              },
        child: isButtonLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addQuestion(BuildContext context) async {
    try {
      final token = PrefManager(null).token ?? '';
      final questionCount = await newsCardsService.checkNumberOfQuestionsByUser(
          token, widget.event.id);
      if (questionCount < 3) {
        _showAddQuestionDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Solo se permiten 3 preguntas por usuario')),
        );
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se tiene conexión a Internet.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
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
          content: AddQuestionForm(
            event: widget.event,
            refreshQuestions: _refreshQuestions,
          ),
        );
      },
    );
  }
}

class AddQuestionForm extends StatefulWidget {
  final Event event;
  final Function refreshQuestions;

  const AddQuestionForm({
    Key? key,
    required this.event,
    required this.refreshQuestions,
  }) : super(key: key);

  @override
  _AddQuestionFormState createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final TextEditingController questionController = TextEditingController();
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: questionController,
          decoration:
              const InputDecoration(hintText: 'Escribe tu pregunta aquí'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: isSubmitting
                  ? null
                  : () async {
                      setState(() {
                        isSubmitting = true; // Deshabilitar el botón
                      });
                      final questionText = questionController.text;
                      if (questionText.isNotEmpty) {
                        final uuid = Uuid().v4();
                        final formData = {
                          'question': questionText,
                          'talk_id': widget.event.id.toString(),
                          'uuid': uuid,
                        };
                        try {
                          final token = PrefManager(null).token ?? '';
                          final newsCardsService = NewsCardsService();
                          await newsCardsService.saveQuestion(token, formData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pregunta agregada exitosamente'),
                              backgroundColor: Color.fromARGB(255, 48, 112, 50),
                            ),
                          );
                          widget.refreshQuestions();
                          Navigator.of(context).pop();
                        } on SocketException {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No se tiene conexión a Internet.')),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                          Navigator.of(context).pop();
                        } finally {
                          setState(() {
                            isSubmitting = false; // Habilitar el botón
                          });
                        }
                      } else {
                        setState(() {
                          isSubmitting =
                              false; // Habilitar el botón si no hay texto
                        });
                      }
                    },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ],
    );
  }
}
