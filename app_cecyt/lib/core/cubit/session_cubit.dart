import 'package:app_cecyt/core/utils/login_types.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionNotLoaded());
  void setSession(String token, bool isAdmin) {
    emit(SessionLoaded(token: token, isAdmin: isAdmin));
  }

  void logout() {
    tokenCambiable = '';
    PrefManager(null).logout();

    emit(SessionNotLoaded());
  }

  // bool isAdmin() {
  //   return false;
  // }
}
