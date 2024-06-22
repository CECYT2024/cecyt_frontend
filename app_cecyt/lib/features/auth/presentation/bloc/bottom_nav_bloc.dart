// navigation_bloc.dart
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:bloc/bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<PageTapped>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
