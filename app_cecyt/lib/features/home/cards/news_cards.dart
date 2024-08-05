import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/helpers/event.dart';

class NewsCardsOne extends StatefulWidget {
  const NewsCardsOne({super.key});
  static const String path = '/news1';

  @override
  _NewsCardsOneState createState() => _NewsCardsOneState();
}

class _NewsCardsOneState extends State<NewsCardsOne> {
  final String studentId = "Y0000";

  void _showQuestions(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsPage(event: event),
      ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(
                    'Día: ${DateFormat('dd/MM/yyyy').format(event.startTime)}, ${event.place}, ${event.speaker}, Hora: ${DateFormat('HH:mm').format(event.startTime)}',
                  ),
                  onTap: () => _showQuestions(event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionsPage extends StatefulWidget {
  final Event event;

  const QuestionsPage({super.key, required this.event});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final TextEditingController _controller = TextEditingController();
  final String studentId = "Y0000";
  int likeCount = 0;

  void _addQuestion(String text) {
    setState(() {
      widget.event.questions.add(Question(studentId: studentId, text: text));
    });
  }

  void _likeQuestion(Question question) {
    if (likeCount != 1) {
      setState(() {
        question.likes++;
        likeCount++;
      });
    }
  }

  void _showAddQuestionDialog() {
    _controller.clear(); // Clear the controller to avoid showing the previous question
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Pregunta'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Pregunta'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String text = _controller.text;
                if (text.isNotEmpty && !_containsObscenity(text)) {
                  if (widget.event.questions.where((q) => q.studentId == studentId).length < 3) {
                    _addQuestion(text);
                    Navigator.of(context).pop();
                  } else {
                    _showErrorDialog('No es posible hacer más de 3 preguntas.');
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _containsObscenity(String text) {
    const List<String> obscenities = [
      "puta",
      "puto",
      "sexo",
      "pene",
      "tetas",
      "culo"
    ];
    for (String obscenity in obscenities) {
      if (text.toLowerCase().contains(obscenity)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    events = [
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.event.questions.length,
              itemBuilder: (context, index) {
                final question = widget.event.questions[index];
                return ListTile(
                  title: Text(question.text),
                  trailing: IconButton(
                    icon: Icon(Icons.thumb_up, color: question.likes > 0 ? Colors.blue : Colors.grey),
                    onPressed: () => _likeQuestion(question),
                  ),
                  subtitle: Text('Likes: ${question.likes}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: _showAddQuestionDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
