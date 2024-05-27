import 'package:flutter/material.dart';

class PrincipalButton extends StatelessWidget {
  const PrincipalButton({
    required this.titulo,
    required this.color,
    required this.callback,
    this.isIcon = false,
    this.icono,
    super.key,
    this.iconoPrincipal,
  });

  final String titulo;
  final IconData? icono;
  final IconData? iconoPrincipal;
  final void Function() callback;
  final Color color;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(color),
            textStyle: WidgetStateProperty.all<TextStyle>(
              Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                // side: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          onPressed: callback,
          // textColor: white,
          child: isIcon
              ? Icon(
                  iconoPrincipal,
                  color: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          titulo,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    if (icono != null)
                      Padding(
                        // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        padding: EdgeInsets.zero,
                        child: Icon(
                          icono,
                        ),
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
