import 'package:flutter/material.dart';

enum DialogTypeEnum {
  error(icono: Icons.error),
  warning(icono: Icons.warning),
  success(icono: Icons.check_circle),
  information(icono: Icons.info),
  custom(icono: Icons.info),
  ;

  final IconData icono;

  const DialogTypeEnum({required this.icono});
}

extension BuildContextExtension on BuildContext {
  Future<T?> showPopup<T>({
    required DialogTypeEnum type,
    String? message,
    bool? isDismissible,
    List<Widget>? actions,
    MainAxisAlignment? actionsAlignment,
    void Function()? closeOnPressed,
    AlertDialog? customDialog,
  }) {
    final screenWidth = MediaQuery.of(this).size.width;

    return showDialog<T>(
      context: this,
      barrierDismissible: isDismissible ?? true,
      builder: (BuildContext context) {
        if (type == DialogTypeEnum.custom) {
          assert(
              customDialog != null &&
                  message == null &&
                  isDismissible == null &&
                  actions == null &&
                  actionsAlignment == null &&
                  closeOnPressed == null,
              '''Cuando type == EAppPersonasDialogType.custom solo se
                 debe recibir el type y el customDialog''');

          return customDialog!;
        }

        return AlertDialog(
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          contentPadding: const EdgeInsets.all(20.0),
          insetPadding: const EdgeInsets.all(16.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
          content: SizedBox(
            width: screenWidth * 0.92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 22.0),
                    Icon(
                      type.icono,
                      color: Theme.of(context).colorScheme.primary,
                      size: 50,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      message ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (actions == null)
                      const SizedBox(
                        height: 32.0,
                      )
                  ],
                ),
                if (isDismissible ?? true)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.primary,
                        size: 18,
                      ),
                      onPressed: closeOnPressed,
                    ),
                  ),
              ],
            ),
          ),
          actionsPadding: (actions == null)
              ? null
              : EdgeInsets.fromLTRB(
                  screenWidth * 0.09, 0, screenWidth * 0.09, 42.0),
          actionsAlignment: actionsAlignment,
          actions: actions,
        );
      },
    );
  }
}
