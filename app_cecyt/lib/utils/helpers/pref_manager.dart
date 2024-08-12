import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  const ActiveTheme(this.mode);
  final ThemeMode mode;
}

class PrefManager {
  static PrefManager? _instance;
  PrefManager._(this.preferences);

  factory PrefManager(SharedPreferences? preferences) {
    if (preferences == null) {
      return _instance!;
    }
    _instance ??= PrefManager._(preferences);
    return _instance!;
  }

  String kIsLogin = 'isLogin';
  String kIsEnable = 'isEnable';
  String kToken = 'token';
  String kRefreshToken = 'refresh_token';
  String kUser = 'user';
  String kTelefono = 'telefono';
  String kCedula = 'cedula';
  String kRole = 'role';
  String kTheme = 'theme';

  /// Light, Dark ,System

  SharedPreferences preferences;

  //for Bloc.Bloc.login
  set isLogin(bool value) => preferences.setBool(kIsLogin, value);

  bool get isLogin => preferences.getBool(kIsLogin) ?? false;

  Future<void> setToken(String? value) async {
    await preferences.setString(kToken, value ?? '');
  }

  Future<void> setRefreshToken(String? value) async {
    await preferences.setString(kRefreshToken, value ?? '');
  }

  String? get refreshToken => preferences.getString(kRefreshToken);

  String? get token => preferences.getString(kToken);

  set user(String? value) => preferences.setString(kUser, value ?? '');

  String? get user => preferences.getString(kUser);

  Future<void> setRole(String? value) async {
    try {
      if (value?.toLowerCase().contains('admin') ?? false) {
        throw Exception('admin');
      }
      final data = value?.split('.')[1].toLowerCase();

      await preferences.setString(kRole, data ?? '');
    } catch (e) {
      if (value?.toLowerCase().contains('admin') ?? false) {
        await preferences.setString(kRole, 'admin');
        return;
      }
      await preferences.setString(kRole, value ?? '');
    }
  }

  String? get role => preferences.getString(kRole);

  set telefono(String? value) => preferences.setString(kTelefono, value ?? '');

  String get telefono => preferences.getString(kTelefono) ?? '';

  set cedula(String? value) => preferences.setString(kCedula, value ?? '');

  String get cedula => preferences.getString(kCedula) ?? '';

  Future<void> setIsEnable(bool? value) async {
    await preferences.setBool(kIsEnable, value ?? false);
  }

  bool? get isEnable => preferences.getBool(kIsEnable);

  /// Default locale set to English
  set theme(String? value) =>
      preferences.setString(kTheme, value ?? ActiveTheme.system.name);

  String get theme => preferences.getString(kTheme) ?? ActiveTheme.system.name;

  Future<bool> logout() => preferences.clear();
}
