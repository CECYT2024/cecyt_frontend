import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_cecyt/features/home/ui/pages/calendar_page.dart';
import 'package:app_cecyt/utils/helpers/event.dart';

class AdminCard extends StatefulWidget {
  const AdminCard({super.key});
  static const String path = '/admin';

  @override
  _AdminCardState createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  final _formKey = GlobalKey<FormState>();
  late String _day, _place, _name, _speaker, _startTime;

  void _addEvent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        DateTime startTime = Event.parseDayAndTime(_day, _startTime);
        events.add(Event(name: _name, place: _place, speaker: _speaker, startTime: startTime));
      });
      Navigator.of(context).pop();
    }
  }

  void _editEvent(int index) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        DateTime startTime = Event.parseDayAndTime(_day, _startTime);
        events[index] = Event(name: _name, place: _place, speaker: _speaker, startTime: startTime);
      });
      Navigator.of(context).pop();
    }
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  void _sortEvents() {
    events.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  void _showEventForm({int? index}) {
    if (index != null) {
      final event = events[index];
      _day = event.startTime.day == 7 ? '1' : '2';
      _place = event.place;
      _name = event.name;
      _speaker = event.speaker;
      _startTime = DateFormat('HH:mm').format(event.startTime as DateTime);
    } else {
      _day = '';
      _place = '';
      _name = '';
      _speaker = '';
      _startTime = '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Agregar Evento' : 'Editar Evento'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _day,
                  decoration: const InputDecoration(labelText: 'Día'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (value != '1' && value != '2') {
                      return 'El día debe ser "1" o "2"';
                    }
                    return null;
                  },
                  onSaved: (value) => _day = value!,
                ),
                TextFormField(
                  initialValue: _place,
                  decoration: const InputDecoration(labelText: 'Lugar'),
                  validator: (value) => value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _place = value!,
                ),
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(labelText: 'Nombre del Evento'),
                  validator: (value) => value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  initialValue: _speaker,
                  decoration: const InputDecoration(labelText: 'Disertante'),
                  validator: (value) => value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _speaker = value!,
                ),
                TextFormField(
                  initialValue: _startTime,
                  decoration: const InputDecoration(labelText: 'Hora de Inicio (24hrs)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo no puede estar vacío';
                    } else if (!RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(value)) {
                      return 'La hora debe estar en formato HH:mm';
                    }
                    return null;
                  },
                  onSaved: (value) => _startTime = value!,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (index == null) {
                  _addEvent();
                } else {
                  _editEvent(index);
                }
              }
            },
            child: Text(index == null ? 'Agregar' : 'Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _sortEvents();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Text('Gestión de Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEventForm(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.name),
            subtitle: Text('Día: ${DateFormat('yyyy-MM-dd').format(event.startTime as DateTime)}, Lugar: ${event.place}, Disertante: ${event.speaker}, Hora: ${DateFormat('HH:mm').format(event.startTime as DateTime)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEventForm(index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteEvent(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
