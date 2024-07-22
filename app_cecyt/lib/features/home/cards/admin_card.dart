import 'package:app_cecyt/features/home/ui/pages/calendar_page.dart';
import 'package:flutter/material.dart';

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
        events.add(Event(
            day: _day,
            place: _place,
            name: _name,
            speaker: _speaker,
            startTime: _startTime));
        _sortEvents();
      });
      Navigator.of(context).pop();
    }
  }

  void _editEvent(int index) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        events[index] = Event(
            day: _day,
            place: _place,
            name: _name,
            speaker: _speaker,
            startTime: _startTime);
        _sortEvents();
      });
      Navigator.of(context).pop();
    }
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
      _sortEvents();
    });
  }

  void _sortEvents() {
    events.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  void _showEventForm({int? index}) {
    if (index != null) {
      final event = events[index];
      _day = event.day;
      _place = event.place;
      _name = event.name;
      _speaker = event.speaker;
      _startTime = event.startTime;
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
                  validator: (value) =>
                      value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _place = value!,
                ),
                TextFormField(
                  initialValue: _name,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del Evento'),
                  validator: (value) =>
                      value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  initialValue: _speaker,
                  decoration: const InputDecoration(labelText: 'Disertante'),
                  validator: (value) =>
                      value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _speaker = value!,
                ),
                TextFormField(
                  initialValue: _startTime,
                  decoration: InputDecoration(labelText: 'Hora de Inicio'),
                  validator: (value) =>
                      value!.isEmpty ? 'El campo no puede estar vacío' : null,
                  onSaved: (value) => _startTime = value!,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.save();
              if (index == null) {
                _addEvent();
              } else {
                _editEvent(index);
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text('Gestión de Eventos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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
            subtitle: Text(
                'Día: ${event.day}, Lugar: ${event.place}, Disertante: ${event.speaker}, Hora: ${event.startTime}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEventForm(index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
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
