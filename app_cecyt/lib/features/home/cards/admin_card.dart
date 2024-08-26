// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cecyt/utils/helpers/events_bloc.dart';
import 'package:app_cecyt/utils/helpers/event.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:intl/intl.dart';

class AdminCard extends StatefulWidget {
  const AdminCard({super.key});
  static const String path = '/admin';

  @override
  _AdminCardState createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  late EventsBloc _eventsBloc;
  final _formKey = GlobalKey<FormState>();
  final _dayController = TextEditingController();
  final _timeController = TextEditingController();
  final _nameController = TextEditingController();
  final _speakerController = TextEditingController();
  final _placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eventsBloc = EventsBloc(apiService: ApiService());
    _eventsBloc.add(FetchEvents());
  }

  @override
  void dispose() {
    _eventsBloc.close();
    _dayController.dispose();
    _timeController.dispose();
    _nameController.dispose();
    _speakerController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  void _confirmDelete(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                final response = await _eventsBloc.apiService
                    .deleteTalk(event.id, tokenCambiable);
                if (response.statusCode == 200) {
                  final responseBody = jsonDecode(response.body);
                  if (responseBody['status'] == 'ok') {
                    _eventsBloc.add(DeleteEvent(event));
                  } else {
                    print(
                        'Error al eliminar el evento: ${response.statusCode}');
                  }
                } else {
                  if (response.statusCode == 201) {
                    _eventsBloc.add(FetchEvents());
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Charla Eliminada')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTalkDialog(Event event) {
    _dayController.text = DateFormat('d').format(event.startTime);
    _timeController.text = DateFormat('HH:mm').format(event.startTime);
    _nameController.text = event.name;
    _speakerController.text = event.speaker;
    _placeController.text = event.place;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Charla'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _dayController,
                    decoration: const InputDecoration(labelText: 'Dia (1 o 2)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      if (value != '1' && value != '2') {
                        return 'Dia tiene que ser 1 o 2';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration:
                        const InputDecoration(labelText: 'Hora (HH:mm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      final timeRegex = RegExp(r'^\d{2}:\d{2}$');
                      if (!timeRegex.hasMatch(value)) {
                        return 'Se debe escribir HH:mm';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre de la charla'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _speakerController,
                    decoration: const InputDecoration(labelText: 'Disertante'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: const InputDecoration(labelText: 'Lugar'),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final updatedEvent = Event(
                    id: event.id,
                    name: _nameController.text,
                    place: _placeController.text,
                    speaker: _speakerController.text,
                    startTime: Event.parseDayAndTime(
                        _dayController.text, _timeController.text),
                  );
                  try {
                    final response = await ApiService()
                        .editTalk(updatedEvent, tokenCambiable);
                    if (response.statusCode == 201) {
                      final responseBody = jsonDecode(response.body);
                      if (responseBody['status'] == 'ok') {
                        _eventsBloc.add(FetchEvents());
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Charla editada con éxito')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error al editar la charla')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Error en la respuesta del servidor ${response.statusCode}')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error este: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddTalkDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Añadir Charla'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _dayController,
                    decoration: const InputDecoration(labelText: 'Dia (1 o 2)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      if (value != '1' && value != '2') {
                        return 'Dia tiene que ser 1 o 2';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration:
                        const InputDecoration(labelText: 'Hora (HH:mm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      final timeRegex = RegExp(r'^\d{2}:\d{2}$');
                      if (!timeRegex.hasMatch(value)) {
                        return 'Se debe escribir HH:mm';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre de la charla'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _speakerController,
                    decoration: const InputDecoration(labelText: 'Disertante'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: const InputDecoration(labelText: 'Lugar'),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Añadir'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final day = _dayController.text;
                  final time = _timeController.text;
                  final name = _nameController.text;
                  final speaker = _speakerController.text;
                  final place = _placeController.text;

                  final startTime = Event.parseDayAndTime(day, time);

                  final newEvent = Event(
                    id: 1,
                    name: name,
                    place: place,
                    speaker: speaker,
                    startTime: startTime,
                  );
                  _dayController.clear();
                  _timeController.clear();
                  _nameController.clear();
                  _speakerController.clear();
                  _placeController.clear();

                  try {
                    final response =
                        await ApiService().createTalk(newEvent, tokenCambiable);
                    if (response.statusCode == 201) {
                      final responseBody = jsonDecode(response.body);
                      if (responseBody['status'] == 'ok') {
                        _eventsBloc.add(FetchEvents());

                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Charla creada')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to create talk: ${responseBody['message']}')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to create talk, status code: ${response.statusCode}')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
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
      appBar: AppBar(
        title: const Text('Administrador'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTalkDialog,
          ),
        ],
      ),
      body: BlocBuilder<EventsBloc, EventState>(
        bloc: _eventsBloc,
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return ListTile(
                  title: Text(
                    '${event.name} , ${event.speaker}',
                    textScaler: const TextScaler.linear(0.9),
                  ),
                  subtitle: Text(
                      '${DateFormat('dd/MM/yyyy').format(event.startTime)},Hora: ${DateFormat('HH:mm').format(event.startTime)}'
                      ' , ${event.place}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditTalkDialog(event);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _confirmDelete(event);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load events'));
          }
        },
      ),
    );
  }
}
