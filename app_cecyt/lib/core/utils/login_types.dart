import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';
import 'package:app_cecyt/features/home/cards/account_card.dart';
import 'package:app_cecyt/features/home/cards/admin_card.dart';

enum LoginTypes { logged, notLogged, admin }

extension LoginTypesExtension on LoginTypes {
  bool get isAdmin => this == LoginTypes.admin;
  String get title {
    switch (this) {
      case LoginTypes.logged:
        return 'Cuenta';
      case LoginTypes.notLogged:
        return 'Iniciar Sesión';
      case LoginTypes.admin:
        return 'Admin';
    }
  }

  String? get pathRedirect {
    switch (this) {
      case LoginTypes.logged:
        // return LogoutPage.path;
        return AccountCard.path;
      case LoginTypes.notLogged:
        return LoginPage.path;
      case LoginTypes.admin:
        return AdminCard.path;
      // return LogoutPage.path;
    }
  }
}
