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
    _eventsBloc = EventsBloc(apiService: ApiService(baseUrl: baseUrl));
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
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                if (event.id != null) {
                  final response = await _eventsBloc.apiService.deleteTalk(event.id, tokenCambiable);
                  if (response.statusCode == 200) {
                    final responseBody = jsonDecode(response.body);
                    if (responseBody['status'] == 'ok') {
                      _eventsBloc.add(DeleteEvent(event));
                    } else {
                      print('Error al eliminar el evento: ${response.statusCode}');
                    }
                  } else {
                    if (response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Evento eliminado, salir y entrar para ver los cambios')),
                      );
                    }
                  }
                }
                Navigator.of(context).pop();
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
          title: Text('Add Talk'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _dayController,
                    decoration: InputDecoration(labelText: 'Day (1 or 2)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a day';
                      }
                      if (value != '1' && value != '2') {
                        return 'Day must be 1 or 2';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration: InputDecoration(labelText: 'Time (HH:mm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a time';
                      }
                      final timeRegex = RegExp(r'^\d{2}:\d{2}$');
                      if (!timeRegex.hasMatch(value)) {
                        return 'Time must be in HH:mm format';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _speakerController,
                    decoration: InputDecoration(labelText: 'Speaker'),
                    maxLength: 128,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a speaker';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _placeController,
                    decoration: InputDecoration(labelText: 'Place'),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a place';
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
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

                  try {
                    final response = await ApiService(baseUrl: baseUrl).createTalk(newEvent, tokenCambiable);
                    if (response.statusCode == 201) {
                      final responseBody = jsonDecode(response.body);
                      if (responseBody['status'] == 'ok') {
                        _eventsBloc.add(FetchEvents());
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Talk created successfully')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create talk: ${responseBody['message']}')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create talk, status code: ${response.statusCode}')),
                      );
                    }
                  } catch (e) {
                    print(e);
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
        title: Text('Admin Panel'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddTalkDialog,
          ),
        ],
      ),
      body: BlocBuilder<EventsBloc, EventState>(
        bloc: _eventsBloc,
        builder: (context, state) {
          if (state is EventsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.startTime.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Add edit functionality here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
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
            return Center(child: Text('Failed to load events'));
          }
        },
      ),
    );
  }
}
