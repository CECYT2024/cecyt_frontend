import 'dart:convert';

import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'event.dart';
import 'api_service.dart'; // Importa ApiService

// Definición de eventos
abstract class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEvents extends EventEvent {}

// Definición de estados
abstract class EventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventState {}

class EventsLoading extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded({required this.events});

  @override
  List<Object?> get props => [events];
}

class EventsError extends EventState {
  final String message;

  EventsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc para manejar los eventos
class EventsBloc extends Bloc<EventEvent, EventState> {
  final ApiService apiService;

  EventsBloc({required this.apiService}) : super(EventsInitial()) {
    on<FetchEvents>(_onFetchEvents);
    on<DeleteEvent>(
        _onDeleteEvent); // Agregar el manejador de eventos de eliminación
  }

  Future<void> _onFetchEvents(
      FetchEvents event, Emitter<EventState> emit) async {
    emit(EventsLoading());
    try {
      final response =
          await apiService.getAllTalks(PrefManager(null).token ?? '');
      if (response.statusCode == 200) {
        List<Event> events = Event.fromJson(response.body);
        emit(EventsLoaded(events: events));
      } else if (response.statusCode == 401) {
        emit(EventsError(message: 'Iniciar sesión para ver los eventos'));
      } else if (response.statusCode == 503) {
        emit(EventsError(message: 'El servidor esta en mantenimiento'));
      } else {
        emit(EventsError(message: 'Error desconocido${response.body}'));
      }
    } catch (e) {
      if (e.toString() == 'Instance of \'NotAuthException\'') {
        emit(EventsError(message: 'Iniciar sesión para ver los eventos'));
      }
      emit(EventsError(message: 'Iniciar sesión para ver los eventos'));
    }
  }

  Future<void> _onDeleteEvent(
      DeleteEvent event, Emitter<EventState> emit) async {
    try {
      final response = await apiService.deleteTalk(
          event.event.id, PrefManager(null).token ?? '');
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 && responseBody['status'] == 'ok') {
        // Eliminar el evento de la lista de eventos
        final currentState = state;
        if (currentState is EventsLoaded) {
          final updatedEvents =
              currentState.events.where((e) => e.id != event.event.id).toList();
          emit(EventsLoaded(events: updatedEvents));
        }
      } else {
        emit(EventsError(message: 'Error al eliminar el evento'));
      }
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }
}
