import 'package:app_cecyt/utils/constants.dart';
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
  List<Object?> get props => [
        events
      ];
}

class EventsError extends EventState {
  final String message;

  EventsError({required this.message});

  @override
  List<Object?> get props => [
        message
      ];
}

// Bloc para manejar los eventos
class EventsBloc extends Bloc<EventEvent, EventState> {
  final ApiService apiService;

  EventsBloc({required this.apiService}) : super(EventsInitial()) {
    on<FetchEvents>(_onFetchEvents);
  }

  Future<void> _onFetchEvents(FetchEvents event, Emitter<EventState> emit) async {
    emit(EventsLoading());
    try {
      final response = await apiService.getAllTalks(tokenCambiable); // Reemplaza 'your_token_here' con el token real
      if (response.statusCode == 200) {
        List<Event> events = Event.fromJson(response.body);
        emit(EventsLoaded(events: events));
      } else {
        emit(EventsError(message: 'Error al obtener los eventos'));
      }
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }
}
