import 'package:app_cecyt/core/user_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  late UserEntity user;
  String _token = '';
  void setUser(UserEntity user) {
    this.user = user;
  }

  void setToken(String token) {
    _token = token;
  }

  String get token => _token;
}
