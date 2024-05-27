import 'package:flutter/material.dart';

mixin DialogHelper {
  static final key = GlobalKey<ScaffoldMessengerState>();
  static ScaffoldFeatureController? controller;
  static bool isPreloading = false;

  static void hidePreloader() {
    if (!isPreloading) return;
    isPreloading = false;
    if (Navigator.canPop(dialogContext!)) {
      Navigator.of(dialogContext!).pop();
    }
  }

  static BuildContext? dialogContext;

  static void showError(String errors) {
    key.currentState?.clearSnackBars();
    if (!(key.currentState?.mounted ?? false)) {
      return;
    }
    controller = key.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade800,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(18),
        content: Text(
          errors,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static void showSuccess(String message) {
    if (isPreloading) hidePreloader();
    key.currentState?.clearSnackBars();
    controller = key.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(18),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
